import 'package:flutter_test/flutter_test.dart';
import 'package:tidyo/App.dart';
import 'package:tidyo/Config/Injection/InjectionContainer.dart';

void main() {
  testWidgets('Tidyo smoke test', (WidgetTester tester) async {
    await setupServiceLocator();
    await tester.pumpWidget(const TidyoApp());
    expect(find.text('Hi, User'), findsOneWidget);
  });
}
