import 'package:afridelight/app/afridelight_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AfriDelight starts on home', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AfriDelightApp()));
    await tester.pump();
    expect(find.text('AfriDelight'), findsWidgets);
  });
}
