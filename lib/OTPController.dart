import 'package:firebase_auth/firebase_auth.dart';
import  'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'screens/choice_screen.dart';

class OTPControllerScreen extends StatefulWidget {
  final String phone;
  final String codeDigits;
  const OTPControllerScreen({Key? key, required this.phone, required this.codeDigits}) : super(key: key);
  @override
  State<OTPControllerScreen> createState() => _OTPControllerScreenState();
}

class _OTPControllerScreenState extends State<OTPControllerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
      color: Colors.pinkAccent.shade700,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.grey,
      )
  );


  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.codeDigits + widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential)
            .then((value) {
          //if(value.user != null){
          //Navigator.of(context).
          //push(MaterialPageRoute(
          //  builder: (c) => CamRenderer()));
          //}//here
        }
        );
      },

      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
      },

      codeSent: (String vID, int? resendToken) {
        setState(() {
          verificationCode = vID;
        }
        );
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {
          verificationCode = vID;
        }
        );
      },
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade700,
        title: const Text(' '),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/plank2.png"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  verifyPhoneNumber();
                },
                child: Text(
                  "Verifying: ${widget.codeDigits}-${widget.phone}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Pinput(
              errorTextStyle: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),

              focusNode: _pinOTPCodeFocus,
              controller: _pinOTPCodeController,
              pinAnimationType: PinAnimationType.rotation,
              onSubmitted: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider
                      .credential(verificationId: verificationCode!,
                      smsCode: pin)
                  )
                      .then((value) {
                    if (value.user != null) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                          builder: (c) => const choice_screen(),
                          ),
                      );
                    }
                  });
                }

                catch (e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Invalid OTP"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),
          ),

          SafeArea(
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).
                    push(MaterialPageRoute(builder: (c) => choice_screen()
                    )
                    );
                  },
                  color: Colors.pinkAccent.shade700,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.only(right: 550, left: 10, bottom: 1),
                  child: SizedBox(
                    height: 50,
                    width: 150.0,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children:  [
                          Text('@Powered by DotPy',
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: Colors.blue.shade800
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],

      ),
    );
  }
}