import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/color_extenstion.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../view/home/home_view.dart'; // Import your HomeScreen

class OtpVerificationView extends StatefulWidget {
  final String verificationId;
  const OtpVerificationView({Key? key, required this.verificationId}) : super(key: key);

  @override
  _OtpVerificationViewState createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  TextEditingController txtOtp = TextEditingController();
  String? errorMessage;
  bool isLoading = false;

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
            color: Colors.blue, // Replace TColor.primary with a standard color
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
                "Enter OTP",
                style: TextStyle(
                  color: Colors.black, // Replace TColor.text with a standard color
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              RoundTextField(
                controller: txtOtp,
                hintText: "OTP",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 25),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              ElevatedButton( // Replace RoundLineButton with ElevatedButton
                child: Text(isLoading ? "Verifying..." : "Verify OTP"),
                onPressed: isLoading ? null : () async {
                  await verifyOtp(txtOtp.text.trim());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyOtp(String otp) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the HomeScreen after successful verification
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred. Please try again.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    txtOtp.dispose();
    super.dispose();
  }
}