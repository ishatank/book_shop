import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_grocer/common/color_extenstion.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import 'otp_verification_view.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController txtPhoneNumber = TextEditingController();
  String? errorMessage;

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
                "Forgot Password",
                style: TextStyle(
                    color: TColor.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              RoundTextField(
                controller: txtPhoneNumber,
                hintText: "Phone Number",
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 25),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              RoundLineButton(
                title: "Submit",
                onPressed: () async {
                  await sendOtp(txtPhoneNumber.text.trim());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendOtp(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          // Navigate to the home screen or another appropriate screen
          Navigator.of(context).pushReplacementNamed('/home'); // Adjust this route as needed
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            errorMessage = e.message;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerificationView(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out
          setState(() {
            errorMessage = "OTP auto-retrieval timed out. Please try again.";
          });
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred. Please try again later.";
      });
      print("Error sending OTP: $e");
    }
  }

  @override
  void dispose() {
    txtPhoneNumber.dispose();
    super.dispose();
  }
}