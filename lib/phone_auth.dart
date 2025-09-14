import 'package:firebase_app/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Phone Authontication"),
        centerTitle: true,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  
                )
            
              ),
            
            ),
            
          ),
           SizedBox(height: 10,),

           ElevatedButton(onPressed: ()async{
            await FirebaseAuth.instance.verifyPhoneNumber(
              verificationCompleted: (PhoneAuthCredential credentials){}, 
              verificationFailed:( FirebaseAuthException ex){}, 
              codeSent:(String verificationid, int? resendtoken){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> Otpscreen(verificationid: verificationid,)));
              }, 
              codeAutoRetrievalTimeout: (String verificationid){}, 
            phoneNumber: _controller.text.toString());
           }, child: Text("Verify Phone Number ")),

        ],
      ),
    );
  }
}