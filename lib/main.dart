import 'package:flutter/material.dart';
import 'package:student_app/repository/student_repo.dart';
import 'package:student_app/screen/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    StudentRepo.updateStudentList();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Students',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
       routes: {
        'login': (context) => const LoginPage(),
       },
    );
  }
}
