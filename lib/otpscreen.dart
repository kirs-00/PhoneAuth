
import 'package:firebase_app/phone_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Otpscreen extends StatefulWidget {
  String verificationid;
  Otpscreen({super.key, required this.verificationid});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final TextEditingController _otpControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP VERIFICATION"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: _otpControler,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter Otp",
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      await PhoneAuthProvider.credential(
                        verificationId: widget.verificationid,
                        smsCode: _otpControler.text.toString(),
                      );
                  FirebaseAuth.instance.signInWithCredential(credential).then((
                    value,
                  ) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneAuth()),
                    );
                  });
                } catch (ex) {
                 print("error message $ex");
                }
              },
              child: Text("OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
