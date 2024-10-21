import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/color_extenstion.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import '../main_tab/main_tab_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isStay = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add user data to Firestore
  Future<void> _signUp() async {
    try {
      // Add user data to Firestore using .add() method
      await _firestore.collection('book_shop').add({
        'name': txtFirstName.text,
        'email': txtEmail.text,
        'phone': txtMobile.text,
        'password': txtPassword.text, // Ideally, don't store passwords as plain text
      });

      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-up successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to profile or any other screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainTabView()),
      );
    } catch (e) {
      // Show error Snackbar
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
                "Sign up",
                style: TextStyle(
                    color: TColor.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                controller: txtFirstName,
                hintText: "First & Last Name",
              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                  controller: txtEmail,
                  hintText: "Email Address",
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                controller: txtMobile,
                hintText: "Mobile Phone",
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 20,
              ),
              RoundTextField(
                controller: txtPassword,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
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
                  Expanded(
                    child: Text(
                      "Please sign me up for the monthly newsletter.",
                      style: TextStyle(
                        color: TColor.subTitle.withOpacity(0.3),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              RoundLineButton(
                title: "Sign Up",
                onPressed: _signUp, // Call the signup method
              )
            ],
          ),
        ),
      ),
    );
  }
}
