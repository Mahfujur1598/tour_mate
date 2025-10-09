import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/controllers/home_controller.dart';
import 'firebase_options.dart';

import 'app/routes/app_routes.dart';
import 'app/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  Get.lazyPut<HomeController>(() => HomeController(), fenix: true);


  runApp(const TourMateApp());
}

class TourMateApp extends StatelessWidget {
  const TourMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TourMate',
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.routes,

      unknownRoute: GetPage(
        name: '/404',
        page: () => const Scaffold(
          body: Center(child: Text('Route not found')),
        ),
      ),
      builder: (context, child) {
        ErrorWidget.builder = (details) => Material(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(details.exceptionAsString(),
                  textAlign: TextAlign.center),
            ),
          ),
        );
        return child!;
      },
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
    );
  }
}
