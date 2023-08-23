import 'package:batrena/modules/login/login_screen.dart';
import 'package:batrena/shared/networks/local/cache_helper.dart';
import 'package:batrena/shared/networks/remote/dio_helper.dart';
import 'package:batrena/shared/themes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: LoginScreen(),
    );
  }
}
