import 'package:flutter/material.dart';

enum AuthMode { signin, signup }

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isCheck = false;
  bool loading = false;
  AuthMode _mode = AuthMode.signup;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Row(
                children: [
                  const Text(
                    "ANIFLIX",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 32,
                        fontFamily: "Bebas Neue",
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          (_mode == AuthMode.signin)
                              ? _mode = AuthMode.signup
                              : _mode = AuthMode.signin;
                        });
                      },
                      child: Text(
                        (_mode == AuthMode.signin) ? "Sign Up" : "Sign In",
                        style: const TextStyle(color: Colors.red),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                (_mode == AuthMode.signup)
                    ? "Create your account"
                    : "Welcome back!!",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (_mode == AuthMode.signup)
              const SizedBox(
                height: 10,
              ),
            if (_mode == AuthMode.signup)
              CustomTextField(controller: _nameController, title: "Username"),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(controller: _emailController, title: "Email"),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(controller: _passwordController, title: "Password"),
            const SizedBox(
              height: 15,
            ),
            if (_mode == AuthMode.signup)
              Row(
                children: [
                  Checkbox(
                    value: _isCheck,
                    onChanged: (value) {
                      setState(() {
                        _isCheck = value!;
                      });
                    },
                  ),
                  const Text("Please do not email me Netflix special offers.")
                ],
              ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => {},
              child: Container(
                width: double.maxFinite,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: (loading)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text((_mode == AuthMode.signup) ? "Sign Up" : "Sign In"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: title == "Password",
        decoration: InputDecoration(
          labelText: title,
          border: InputBorder.none,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
