import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang & Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(child: ListTile(title: Text('Nasi Uduk Galuh'), subtitle: Text('2 x Rp12000'), trailing: Text('Rp24000'))),
          const Card(child: ListTile(title: Text('Es Kopi Susu Tetangga'), subtitle: Text('1 x Rp15000'), trailing: Text('Rp15000'))),
          const SizedBox(height: 16),
          DropdownButtonFormField(initialValue: 'Kurir internal', items: const [
            DropdownMenuItem(value: 'Ambil sendiri', child: Text('Ambil sendiri')),
            DropdownMenuItem(value: 'Kurir internal', child: Text('Kurir internal')),
            DropdownMenuItem(value: 'Ojek lokal', child: Text('Ojek lokal')),
          ], onChanged: (_) {}, decoration: const InputDecoration(labelText: 'Delivery lokal')),
          const SizedBox(height: 12),
          DropdownButtonFormField(initialValue: 'COD', items: const [
            DropdownMenuItem(value: 'Transfer Bank', child: Text('Transfer Bank')),
            DropdownMenuItem(value: 'QRIS', child: Text('QRIS')),
            DropdownMenuItem(value: 'COD', child: Text('COD')),
            DropdownMenuItem(value: 'Midtrans', child: Text('Payment Gateway Midtrans')),
          ], onChanged: (_) {}, decoration: const InputDecoration(labelText: 'Pembayaran')),
          const SizedBox(height: 20),
          const Card(child: ListTile(title: Text('Total'), subtitle: Text('Termasuk ongkir lokal Rp5000'), trailing: Text('Rp44000'))),
          FilledButton(onPressed: () {}, child: const Text('Checkout')),
        ],
      ),
    );
  }
}
