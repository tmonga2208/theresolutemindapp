import 'package:flutter/material.dart';
import 'package:theresolutemind/components/my_button.dart';
import 'package:theresolutemind/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register() {}

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
            onTap: register,
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
