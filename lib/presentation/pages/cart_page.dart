import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/cart_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _deliveryMethod = 'Kurir internal';
  String _paymentMethod = 'COD';
  final _customerController = TextEditingController(text: 'Pembeli GaluhMart');
  final _blockController = TextEditingController();
  final _addressController = TextEditingController(text: 'Perum Kota Galuh');

  @override
  void dispose() {
    _customerController.dispose();
    _blockController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang & Checkout')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Keranjang masih kosong. Tambahkan produk dari katalog.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(controller: _customerController, decoration: const InputDecoration(labelText: 'Nama pembeli')),
                const SizedBox(height: 12),
                TextField(
                  controller: _blockController,
                  decoration: const InputDecoration(
                    labelText: 'Blok pengiriman',
                    hintText: 'Contoh: Blok B2',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Alamat / catatan pengiriman')),
                const SizedBox(height: 16),
                for (final entry in cart.itemsBySeller.entries) _SellerCartGroup(shopName: entry.key, items: entry.value),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  initialValue: _deliveryMethod,
                  items: const [
                    DropdownMenuItem(value: 'Ambil sendiri', child: Text('Ambil sendiri')),
                    DropdownMenuItem(value: 'Kurir internal', child: Text('Kurir internal')),
                    DropdownMenuItem(value: 'Ojek lokal', child: Text('Ojek lokal')),
                  ],
                  onChanged: (value) => setState(() => _deliveryMethod = value ?? _deliveryMethod),
                  decoration: const InputDecoration(labelText: 'Delivery lokal'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: _paymentMethod,
                  items: const [
                    DropdownMenuItem(value: 'Transfer Bank', child: Text('Transfer Bank')),
                    DropdownMenuItem(value: 'QRIS', child: Text('QRIS')),
                    DropdownMenuItem(value: 'COD', child: Text('COD')),
                    DropdownMenuItem(value: 'Midtrans', child: Text('Payment Gateway Midtrans')),
                  ],
                  onChanged: (value) => setState(() => _paymentMethod = value ?? _paymentMethod),
                  decoration: const InputDecoration(labelText: 'Pembayaran'),
                ),
                const SizedBox(height: 20),
                Card(child: ListTile(title: const Text('Total belanja'), subtitle: const Text('Ongkir dikonfirmasi masing-masing penjual'), trailing: Text(_rupiah(cart.subtotal)))),
                FilledButton.icon(onPressed: () => _checkout(context, cart), icon: const Icon(Icons.send), label: const Text('Checkout via WhatsApp per toko')),
              ],
            ),
    );
  }

  Future<void> _checkout(BuildContext context, CartController cart) async {
    for (final entry in cart.itemsBySeller.entries) {
      final sellerPhone = entry.value.first.product.sellerWhatsApp;
      final message = _buildSellerMessage(entry.key, entry.value);
      final uri = Uri.parse('https://wa.me/$sellerPhone?text=${Uri.encodeComponent(message)}');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Detail pesanan dibuka ke WhatsApp masing-masing penjual.')));
    }
  }

  String _buildSellerMessage(String shopName, List<CartItem> items) {
    final lines = [
      'Halo $shopName, saya ingin checkout pesanan dari GaluhMart:',
      '',
      for (final item in items) '- ${item.product.name} x${item.quantity} = ${_rupiah(item.subtotal)}',
      '',
      'Subtotal toko: ${_rupiah(items.fold(0, (total, item) => total + item.subtotal))}',
      'Nama: ${_customerController.text}',
      'Blok pengiriman: ${_blockController.text.isEmpty ? '-' : _blockController.text}',
      'Alamat/catatan: ${_addressController.text}',
      'Pengiriman: $_deliveryMethod',
      'Pembayaran: $_paymentMethod',
    ];
    return lines.join('\n');
  }
}

class _SellerCartGroup extends StatelessWidget {
  const _SellerCartGroup({required this.shopName, required this.items});

  final String shopName;
  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartController>();
    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(shopName),
        subtitle: Text('Dikirim ke WhatsApp ${items.first.product.sellerWhatsApp}'),
        children: [
          for (final item in items)
            ListTile(
              title: Text(item.product.name),
              subtitle: Text('${item.quantity} x ${_rupiah(item.product.price)}'),
              trailing: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  IconButton(onPressed: () => cart.decrease(item.product), icon: const Icon(Icons.remove_circle_outline)),
                  Text(_rupiah(item.subtotal)),
                  IconButton(onPressed: () => cart.add(item.product), icon: const Icon(Icons.add_circle_outline)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

String _rupiah(int value) => 'Rp$value';
