import 'package:flutter_test/flutter_test.dart';
import 'package:bookface/main.dart';

void main() {
  testWidgets('shows loading splash then login screen', (tester) async {
    await tester.pumpWidget(const BookfaceApp());

    expect(find.text('Facebook'), findsOneWidget);
    expect(find.text('from'), findsOneWidget);
    expect(find.text('Meta'), findsOneWidget);
    expect(find.text('curated by'), findsOneWidget);
    expect(find.text('Mobbin'), findsOneWidget);
    expect(find.byType(LoadingDots), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Log in to Facebook'), findsOneWidget);
    expect(find.text('Email or phone number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
    expect(find.text('Create new account'), findsOneWidget);
  });
}
