import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  // static var to pass the verfication id
  static String verify = "";


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  // var to store country code
  TextEditingController countrycode =  TextEditingController();

  // var to store phone number
  var phoneNumber = " ";


  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Please enter your phone number!',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10.0,),

                Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                    // giving the border to the text fields
                    border: Border.all(width: 1.0, color: Colors.grey),

                    // to make the border circular
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.0,),

                      SizedBox(
                        child: TextField(
                          controller: countrycode,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        width: 40.0,
                      ),



                       Text(
                           "|",
                       style: TextStyle(
                         fontSize: 33.0,
                         color: Colors.grey,
                       ),
                       ),

                      SizedBox(width: 10.0,),

                      // expand takes the all left over size
                      // in the row
                      Expanded(
                        child: TextField(

                          // keyboard type numerical
                          keyboardType: TextInputType.phone,

                          // onchange set phoneNumber var
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                        decoration: InputDecoration(
                          border: InputBorder.none,

                          //placeholder text
                          hintText: "Phone Number"
                        ),

                      ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.0,),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () async{

                        // code to send OTP
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${countrycode.text + phoneNumber}',
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {
                            print(e.toString());
                          },

                          // actin=on after the code is sent
                          codeSent: (String verificationId, int? resendToken) {

                            //storing the verification id
                            SignUp.verify = verificationId;

                            // action to take after code is sent
                             Navigator.pushNamed(context, 'otp');
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );

                      },
                      child: Text('Send OTP'),
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
                )
              ],
            ),
          ),
        ),
    );
  }
}
