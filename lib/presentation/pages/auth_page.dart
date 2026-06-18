import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 40),
            Text('Selamat datang di GaluhMart', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Login, register, OTP WhatsApp, dan lupa password disiapkan untuk integrasi backend Laravel.'),
            const SizedBox(height: 32),
            const TextField(decoration: InputDecoration(labelText: 'Nomor WhatsApp / Email')),
            const SizedBox(height: 12),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () {}, child: const Text('Kirim OTP WhatsApp')),
            const SizedBox(height: 12),
            FilledButton(onPressed: onDone, child: const Text('Masuk Dashboard')),
            TextButton(onPressed: () {}, child: const Text('Register toko UMKM / Forgot password')),
          ],
        ),
      ),
    );
  }
}
