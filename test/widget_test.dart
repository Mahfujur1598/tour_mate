import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:tour_mate/app/routes/app_routes.dart';

void main() {
  testWidgets('App loads WelcomePage by default', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TourMate',
        initialRoute: AppRoutes.welcome,
        getPages: AppRoutes.routes,
      ),
    );

    expect(find.text('Welcome'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify navigation to Home
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
