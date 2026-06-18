import 'package:flutter/material.dart';

class SellerDashboardPage extends StatelessWidget {
  const SellerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const actions = ['Tambah Produk', 'Edit Produk', 'Daftar Order', 'Laporan Penjualan', 'Chat Customer', 'Profil Toko'];
    return Scaffold(
      appBar: AppBar(title: const Text('Seller Panel')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: actions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
        itemBuilder: (context, index) => Card(
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.storefront, size: 36),
                const SizedBox(height: 12),
                Text(actions[index], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
