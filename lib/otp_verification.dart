import 'package:blackcoffer/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTP_verification extends StatefulWidget {
  const OTP_verification({Key? key}) : super(key: key);

  @override
  State<OTP_verification> createState() => _OTP_verificationState();
}

class _OTP_verificationState extends State<OTP_verification> {

  // auth instance of firebase
  final FirebaseAuth auth = FirebaseAuth.instance;

  // var to store sms code
  var code = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        //to create the back button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
              Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verify Your Phone Number',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10.0,),

              Text(
                'Please enter the OTP sent to your phone number!',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10.0,),


              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),

              SizedBox(height: 10.0,),

              SizedBox(
                child: ElevatedButton(
                  onPressed: () async{
                    try{
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: SignUp.verify,
                          smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);

                      // if otp is verified, go to the next screen
                      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                    }
                    catch(e) {

                      print('wrong otp');

                    }
                      },
                  child: Text('Verify'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                //increases the height of button
                height: 45.0,

                //makes the button to take all available size in the screen
                width: double.infinity,
              ),

              // we used row
              // to override the main axis alignment
              // of column
              // default row alignment is start
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, 'signup', (route) => false);
                      },
                      child: Text(
                          'Edit Phone Number?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
