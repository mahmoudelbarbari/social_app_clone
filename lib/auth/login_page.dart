import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app_clone/auth/register_page.dart.dart';
import 'package:social_app_clone/widgets/bottom_auth_row_widget.dart';
import 'package:social_app_clone/widgets/common_elevated_button_widget.dart';
import 'package:social_app_clone/widgets/login_textfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerPassword;

  late final GlobalKey<FormState> keyform;

  @override
  void initState() {
    controllerPassword = TextEditingController();
    controllerEmail = TextEditingController();
    keyform = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerEmail.dispose();
    super.dispose();
  }

  bool passwordVisible = true;

  Future<void> _remoteLoginAccount() async {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login successful !")));
      // Navigator.of(
      //   context,
      // ).push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 12);
    return Scaffold(
      body: Form(
        key: keyform,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome back !",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              sizedBox,
              LoginTextFieldWidget(
                controller: controllerEmail,
                isfilled: true,
                textInputType: TextInputType.emailAddress,
                labelText: "Email Address",
                formFieldValidator: (value) {
                  if (!RegExp(
                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
                  ).hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                prefixIcon: Icon(Icons.mail),
              ),
              sizedBox,
              LoginTextFieldWidget(
                controller: controllerPassword,
                isfilled: true,
                textInputType: TextInputType.multiline,
                isobscureText: passwordVisible,
                labelText: "Password",
                formFieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password.';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.]+').hasMatch(value)) {
                    return 'Please enter a valid password....\nYour password must be at least 8 characters long,\nattached with lowercase and uppercase letters';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              sizedBox,
              CommonElevatedButton(
                onTap: () {
                  if (keyform.currentState!.validate()) {
                    _remoteLoginAccount();
                  }
                },
                text: "Sign in",
              ),
              sizedBox,
              BottomAuthRowWidget(
                text: "Don't have an account ?",
                value: "Register",
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
