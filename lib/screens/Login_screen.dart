import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../OTPController.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {

  String dialCodeDigits = "+00";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.pinkAccent.shade700,
                      title: const Center(
                        child: Text(
                            'Keep Challenging!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(),
                    Image.asset(
                      "images/Plank Challenger (1).png",
                      height: 340,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Center(
                        child: Text(
                          "Enter your phone number ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ),
                    const SizedBox(height: 50,),
                    SizedBox(
                      width: 400,
                      height: 40,
                      child: CountryCodePicker(
                        onChanged: (country){
                          setState(() {
                            dialCodeDigits = country.dialCode!;
                          }
                          );
                        },
                        initialSelection: "IT",
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: const ["+2", "Egypt"],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 10,
                        left: 10
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "010********",
                          prefix: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(dialCodeDigits),
                          ),
                        ),
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        controller: _controller,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      width: double.infinity,
                      child: Center(
                        child: RaisedButton(
                          onPressed: (){
                            Navigator.of(context).
                            push(MaterialPageRoute(
                                builder: (c) => OTPControllerScreen(
                                phone: _controller.text,
                                codeDigits: dialCodeDigits,
                            ),
                            ),
                            );
                          },
                          child: const Text('Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          color: Colors.pinkAccent.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.only(right: 550, left: 10, bottom: 1),
              child: SizedBox(
                height: 50,
                width: 150.0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children:  [
                      Expanded(
                        child: Text('@Powered by DotPy',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: Colors.blue.shade800
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}