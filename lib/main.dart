import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'data/repositories/marketplace_repository.dart';
import 'presentation/pages/admin_dashboard_page.dart';
import 'presentation/pages/auth_page.dart';
import 'presentation/pages/cart_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/orders_page.dart';
import 'presentation/pages/seller_dashboard_page.dart';

void main() => runApp(const GaluhMartApp());

class GaluhMartApp extends StatefulWidget {
  const GaluhMartApp({super.key});

  @override
  State<GaluhMartApp> createState() => _GaluhMartAppState();
}

class _GaluhMartAppState extends State<GaluhMartApp> {
  bool _authenticated = false;

  @override
  Widget build(BuildContext context) {
    final repository = MarketplaceRepository();
    return MaterialApp(
      title: 'GaluhMart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: _authenticated
          ? MainShell(repository: repository)
          : AuthPage(onDone: () => setState(() => _authenticated = true)),
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
      HomePage(repository: widget.repository),
      const CartPage(),
      OrdersPage(repository: widget.repository),
      const SellerDashboardPage(),
      const AdminDashboardPage(),
    ];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Order'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Seller'),
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Admin'),
        ],
      ),
    );
  }
}
