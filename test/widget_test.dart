import 'package:flutter_test/flutter_test.dart';

import 'package:tribes_capital/main.dart';

void main() {
  testWidgets('app builds smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TribesCapitalApp());

    expect(find.text('Hello Olaitan,'), findsOneWidget);
    expect(find.byType(BrandMenuButton), findsOneWidget);
  });
}
