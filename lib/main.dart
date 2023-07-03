import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_test/views/auth/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Photo Manager Example',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
