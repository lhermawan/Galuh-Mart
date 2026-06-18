import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const modules = ['Data User', 'Data Seller', 'Approval Seller', 'Data Produk', 'Transaksi', 'Statistik', 'Kategori', 'Pengumuman'];
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(spacing: 12, runSpacing: 12, children: const [
            _StatCard(label: 'Seller aktif', value: '28'),
            _StatCard(label: 'Transaksi', value: '146'),
            _StatCard(label: 'Produk', value: '312'),
          ]),
          const SizedBox(height: 20),
          ...modules.map((module) => Card(child: ListTile(leading: const Icon(Icons.admin_panel_settings_outlined), title: Text(module), trailing: const Icon(Icons.chevron_right)))),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
            Text(label),
          ]),
        ),
      ),
    );
  }
}
