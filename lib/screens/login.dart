import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  navigateTo(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const Home();
    }));
  }

  authenticate() async{
    final isLogged =await UserService().aunthenticate(_usernameController.text, _passwordController.text);
    print(isLogged);
    if (isLogged){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      await prefs.setBool('isLogged', true);
      navigateTo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 150),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50,),
             TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(),
                label: Text("Username"),
              ),
            ),
            const SizedBox(height: 20),
             TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
                label: Text("Password")
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                authenticate();
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}