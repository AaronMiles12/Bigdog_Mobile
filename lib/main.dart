import 'dart:io';

import 'package:big_dog_app/features/onboarding/view/selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: Color(0xff242D3C),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: Color(0xffDD075E),
                primary: Color(0xff242D3C),
                primaryContainer: Color(0xff4F5D72),
                onPrimaryContainer: Color(0xffD5DBE3),
                secondaryContainer: Color(0xff333F51),
              ),
              textTheme: TextTheme(
                bodyLarge:
                    TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
                bodyMedium:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                bodySmall:
                    TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ),
            home: LoginSelection(),
          );
        });
  }
}
