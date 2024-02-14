import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/main.dart';
import 'package:student_app/screen/home_page.dart';
import 'package:student_app/screen/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoglogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image.network('https://cdn.vectorstock.com/i/preview-1x/43/98/student-education-logo-vector-14724398.jpg',height: 250,),
      ),
    );
  }
  Future<void>gotohomeScreen()async{
    Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const LoginPage()));

  }
  Future<void>checkLoglogin()async{
    final sharedpref = await SharedPreferences.getInstance();
    final userloged=sharedpref.getBool(saveKeyName);
    if(userloged==null||userloged==false){
      gotohomeScreen();
    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const MyHomePage())));
    }
  }

  

}
