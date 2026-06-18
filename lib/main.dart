import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/marketplace_repository.dart';
import 'presentation/controllers/cart_controller.dart';
import 'presentation/pages/admin_dashboard_page.dart';
import 'presentation/pages/auth_page.dart';
import 'presentation/pages/cart_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/orders_page.dart';
import 'presentation/pages/seller_dashboard_page.dart';

void main() => runApp(const GaluhMartApp());

class GaluhMartApp extends StatelessWidget {
  const GaluhMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = MarketplaceRepository();
    return ChangeNotifierProvider(
      create: (_) => CartController(),
      child: MaterialApp(
        title: 'GaluhMart',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: MainShell(repository: repository),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.repository});

  final MarketplaceRepository repository;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        repository: widget.repository,
        onLoginSelected: _openLogin,
        onCartSelected: () => setState(() => _index = 1),
      ),
      const CartPage(),
      OrdersPage(repository: widget.repository),
    ];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Katalog'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: 'Keranjang'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Pesanan'),
        ],
      ),
    );
  }

  void _openLogin(DashboardRole role) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AuthPage(
          role: role,
          onDone: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => role == DashboardRole.seller ? const SellerDashboardPage() : const AdminDashboardPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
