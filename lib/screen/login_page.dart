import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/screen/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Now'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
        
          child: Padding(
            
        padding: const EdgeInsets.only(right: 20, left: 20, top: 150),
        child: Form(
          key: formkey,
          child: Column(
            
            children: [
              const Text(
                'User Login',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter User Name';
                  } else {
                    return null;
                  }
                },
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'User Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Password';
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Password'),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        signup();
                      },
                      child: const Text('Sign up'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            checkLogin(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Enter your name and password')));
                          }
                        },
                        child: const Text("Login"))
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> checkLogin(BuildContext context) async {
    final sharedpref = await SharedPreferences.getInstance();
    final savedusername = sharedpref.getString('username');
    final savedpassword = sharedpref.getString('password');

    final username = usernameController.text;
    final password = passwordController.text;

    if (savedusername == username && savedpassword == password) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext ctx) =>  const MyHomePage()));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password or username does match'),
        ),
      );
    }
  }

  Future<void> signup() async {
    final sharedpref = await SharedPreferences.getInstance();
    await sharedpref.setString('username', usernameController.text);
    await sharedpref.setString('password', passwordController.text);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('sign up complete'),
      ),
    );
    usernameController.clear();
    passwordController.clear();
  }
}
