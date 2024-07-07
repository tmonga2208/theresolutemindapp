import 'package:flutter/material.dart';
import 'package:theresolutemind/services/auth/auth_service.dart';
import 'package:theresolutemind/components/my_button.dart';
import 'package:theresolutemind/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;
  RegisterPage({Key? key, required this.onTap});

  void register(BuildContext context) {
    final _auth = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
          _nameController.text,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: Text(e.toString()),
                )));
      }
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
          const SizedBox(height: 30),
          Text(
            'Register For An Account',
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
              hintText: "Enter Your Name..",
              obscureText: false,
              controller: _nameController),
          const SizedBox(height: 10),
          MyTextField(
              hintText: "Enter Your Password..",
              obscureText: true,
              controller: _pwController),
          const SizedBox(height: 10),
          MyTextField(
              hintText: "Confirm Password..",
              obscureText: true,
              controller: _confirmPwController),
          const SizedBox(height: 10),
          MyButton(
            text: "Register",
            onTap: () => register(context),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Have an account?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login",
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
