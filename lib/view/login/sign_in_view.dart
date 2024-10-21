import 'package:book_grocer/common/color_extenstion.dart';
import 'package:book_grocer/view/login/forgot_password_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import '../main_tab/main_tab_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isStay = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to sign in and check if the user exists in Firestore
  Future<void> _signIn() async {
    try {
      // Query Firestore to find a user with the provided email and password
      QuerySnapshot querySnapshot = await _firestore
          .collection('book_shop')
          .where('email', isEqualTo: txtEmail.text)
          .where('password', isEqualTo: txtPassword.text)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // User exists, proceed with sign-in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-in successful!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to the MainTabView after successful sign-in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainTabView()), // Use your main tab view widget here
        );
      } else {
        // User does not exist or incorrect credentials
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle Firestore or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                    color: TColor.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              RoundTextField(
                controller: txtEmail,
                hintText: "Email Address",
              ),
              const SizedBox(
                height: 15,
              ),
              RoundTextField(
                controller: txtPassword,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isStay = !isStay;
                      });
                    },
                    icon: Icon(
                      isStay ? Icons.check_box : Icons.check_box_outline_blank,
                      color: isStay
                          ? TColor.primary
                          : TColor.subTitle.withOpacity(0.3),
                    ),
                  ),
                  Text(
                    "Stay Logged In",
                    style: TextStyle(
                      color: TColor.subTitle.withOpacity(0.3),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight, // Align the button to the right
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordView()),
                    );
                  },
                  child: Text(
                    "Forgot Your Password?",
                    style: TextStyle(
                      color: TColor.subTitle.withOpacity(0.5),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              RoundLineButton(
                title: "Sign In",
                onPressed: _signIn, // Call the sign-in method
              ),
            ],
          ),
        ),
      ),
    );
  }
}
