import 'package:flutter_test/flutter_test.dart';
import 'package:galuh_mart/main.dart';

void main() {
  testWidgets('shows public catalog landing page before login', (tester) async {
    await tester.pumpWidget(const GaluhMartApp());

    expect(find.text('GaluhMart'), findsOneWidget);
    expect(find.text('Produk Lokal'), findsOneWidget);
    expect(find.text('Login Seller'), findsNothing);
  });
}
