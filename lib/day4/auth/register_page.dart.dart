import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/auth/login_page.dart';
import 'package:flutter_application_1/day4/widgets/bottom_auth_row_widget.dart';

import '../../day3/widgets/common_elevated_button_widget.dart';
import '../../day3/widgets/login_textfield_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  late final TextEditingController controllerName;
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerPassword;
  late final TextEditingController controllerGender;
  late final TextEditingController controllerPhone;
  late final TextEditingController controllerJob;
  late final TextEditingController controllerAddress;
  late final GlobalKey<FormState> keyform;

  @override
  void initState() {
    controllerPassword = TextEditingController();
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerGender = TextEditingController();
    controllerPhone = TextEditingController();
    controllerJob = TextEditingController();
    controllerAddress = TextEditingController();
    keyform = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerName.dispose();
    controllerEmail.dispose();
    controllerGender.dispose();
    controllerPhone.dispose();
    controllerJob.dispose();
    controllerAddress.dispose();
    super.dispose();
  }

  bool passwordVisible = true;

  String? selectedValue;
  List<String> items = ['Female', 'Male'];

  Future<void> _registerAccount() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: controllerEmail.text.trim(),
            password: controllerPassword.text.trim(),
          );
      await credential.user!.updateDisplayName(controllerName.text.trim());
      if (!mounted) return;
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("The password provided is too weak.")),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("The account already exists for that email.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('name', controllerName.text);
    // await prefs.setString('email', controllerEmail.text);
    // await prefs.setString('password', controllerPassword.text);
    // await prefs.setString('gender', controllerGender.text);
    // await prefs.setString('phone', controllerPhone.text);
    // await prefs.setString('job', controllerJob.text);
    // await prefs.setString('address', controllerAddress.text);
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 12);
    return Scaffold(
      body: ListView(
        children: [
          Form(
            key: keyform,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
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
                      if (!RegExp(
                        r'^[a-zA-Z0-9]+@[a-zA-Z0-9.]+',
                      ).hasMatch(value)) {
                        return 'Please enter a valid password....\nYour password must be at least 8 characters long,\nattached with lowercase and uppercase letters';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  // sizedBox,
                  // DropdownButtonFormField<String?>(
                  //   borderRadius: BorderRadius.circular(12),
                  //   decoration: InputDecoration(
                  //     prefixIcon: const Icon(Icons.person_outline, size: 24),
                  //     hintText: 'Gender',
                  //     hintStyle: const TextStyle(
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //     filled: true,
                  //     focusedErrorBorder: OutlineInputBorder(
                  //       borderSide: const BorderSide(color: Colors.white),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   value: selectedValue,
                  //   icon: const Icon(Icons.keyboard_arrow_down),
                  //   items: items.map((String item) {
                  //     return DropdownMenuItem(
                  //       value: item,
                  //       child: Text(item, style: const TextStyle(fontSize: 16)),
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       controllerGender.text = value!;
                  //     });
                  //   },
                  // ),
                  // sizedBox,
                  // LoginTextFieldWidget(
                  //   controller: controllerPhone,
                  //   labelText: "Phone Number",
                  //   formFieldValidator: (value, {int i = 1}) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your Phone number.';
                  //     }
                  //     if (!RegExp(
                  //       r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)',
                  //     ).hasMatch(value)) {
                  //       return 'Please enter an valid phone number';
                  //     }
                  //     return null;
                  //   },
                  //   prefixIcon: Icon(Icons.phone),
                  // ),
                  // sizedBox,
                  // LoginTextFieldWidget(
                  //   controller: controllerJob,
                  //   labelText: "Job",
                  //   formFieldValidator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "This field is required";
                  //     }
                  //     return null;
                  //   },
                  //   prefixIcon: Icon(Icons.work),
                  // ),
                  // sizedBox,
                  // LoginTextFieldWidget(
                  //   controller: controllerAddress,
                  //   labelText: "Address",
                  //   formFieldValidator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "This field is required";
                  //     }
                  //     return null;
                  //   },
                  //   prefixIcon: Icon(Icons.local_activity),
                  // ),
                  sizedBox,
                  CommonElevatedButton(
                    onTap: () {
                      if (keyform.currentState!.validate()) {
                        _registerAccount();
                      }
                    },
                    text: "Sign up",
                  ),
                  sizedBox,
                  BottomAuthRowWidget(
                    text: "Already have an account ?",
                    value: "Login",
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
