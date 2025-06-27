import 'package:flutter/material.dart';
import 'package:flutter_application_1/day3/widgets/bottom_nav_bar.dart';
import 'package:flutter_application_1/day3/widgets/common_elevated_button_widget.dart';
import 'package:flutter_application_1/day3/widgets/login_textfield_widget.dart';

class LogingScreen extends StatefulWidget {
  const LogingScreen({super.key});

  @override
  State<LogingScreen> createState() => _LogingScreenState();
}

class _LogingScreenState extends State<LogingScreen> {
  late final TextEditingController controllerName;
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerPassword;
  late final GlobalKey<FormState> keyform;

  @override
  void initState() {
    controllerPassword = TextEditingController();
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    keyform = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerName.dispose();
    controllerEmail.dispose();
    super.dispose();
  }

  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 12);
    return Form(
      key: keyform,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome back",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            sizedBox,
            LoginTextFieldWidget(
              controller: controllerName,
              labelText: "Your name",
              formFieldValidator: (value) {
                if (value == null) {
                  return 'Name is required';
                }
                if (value.length < 6) {
                  return "Name must be at least 6 characters";
                }
                return null;
              },
              prefixIcon: Icon(Icons.person),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BottomNavBar(
                        name: controllerName.text,
                        email: controllerEmail.text,
                      ),
                    ),
                  );
                }
              },
              text: "Sign in",
            ),
          ],
        ),
      ),
    );
  }
}
