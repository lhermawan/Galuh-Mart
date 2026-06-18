import 'package:flutter/material.dart';

enum DashboardRole { seller, admin }

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required this.role, required this.onDone});

  final DashboardRole role;
  final VoidCallback onDone;

  String get _roleLabel => role == DashboardRole.seller ? 'Seller' : 'Admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login $_roleLabel')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 24),
            Text('Masuk sebagai $_roleLabel', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('Katalog bisa dilihat pembeli tanpa login. Login ini khusus untuk akses dashboard ${_roleLabel.toLowerCase()}.'),
            const SizedBox(height: 32),
            const TextField(decoration: InputDecoration(labelText: 'Nomor WhatsApp / Email')),
            const SizedBox(height: 12),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () {}, child: const Text('Kirim OTP WhatsApp')),
            const SizedBox(height: 12),
            FilledButton(onPressed: onDone, child: Text('Masuk Dashboard $_roleLabel')),
            if (role == DashboardRole.seller) TextButton(onPressed: () {}, child: const Text('Register toko UMKM / Forgot password')),
          ],
        ),
      ),
    );
  }
}
