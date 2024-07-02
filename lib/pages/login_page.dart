import 'package:flutter/material.dart';
import 'package:theresolutemind/auth/auth_service.dart';
import 'package:theresolutemind/components/my_button.dart';
import 'package:theresolutemind/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: Text(e.toString()),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/log.jpg',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 50),
          Text(
            'Login',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          MyTextField(
              hintText: "Enter Your Email..",
              obscureText: false,
              controller: _emailController),
          const SizedBox(height: 10),
          MyTextField(
              hintText: "Enter Your Password..",
              obscureText: true,
              controller: _pwController),
          const SizedBox(height: 10),
          MyButton(
            text: "Login",
            onTap: () => login(context),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
