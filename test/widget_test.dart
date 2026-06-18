import 'package:flutter_test/flutter_test.dart';
import 'package:galuh_mart/main.dart';

void main() {
  testWidgets('shows authentication landing page', (tester) async {
    await tester.pumpWidget(const GaluhMartApp());

    expect(find.text('Selamat datang di GaluhMart'), findsOneWidget);
    expect(find.text('Masuk Dashboard'), findsOneWidget);
  });
}
