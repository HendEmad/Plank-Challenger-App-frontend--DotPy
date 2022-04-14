import 'dart:html';
import 'package:flutter/material.dart';
import '../camera_page.dart';

class choice_screen extends StatefulWidget {
  const choice_screen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<choice_screen> createState() => _choice_screen_State();
}

class _choice_screen_State extends State<choice_screen> {

  late File imageFile;
  late File videoFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade700,
        title: const Text(' '),
      ),
      body: SingleChildScrollView(
          child: Stack(
            children: [ Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
            ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 70,
                    child: Center(
                      child: Text(
                        'Ready?',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                  Center(child: Image.asset("images/plank1.jpg", height: 400,)
                  ),

                  const SizedBox(height: 10,),

                  RaisedButton(
                    onPressed: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                          builder: (c) => CameraPage())
                      );
                    },
                    color: Colors.pinkAccent.shade700,
                    child: const Text(
                      'Challenge yourself',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),

                  RaisedButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) =>  const CameraPage())
                      );
                    },
                    color: Colors.pinkAccent.shade700,
                    child: const Text(
                      'Challenge someone',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 550, left: 10, bottom: 1),
                    child: SizedBox(
                      height: 90,
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
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}