import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Widgets/widget_textarea.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String emailSent = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.22,
                    child: Image.asset('assets/images/signup.png',fit: BoxFit.cover,alignment: Alignment.bottomCenter,)),
                Padding(
                  padding: const EdgeInsets.only(top: 30,right: 25),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                          ))),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25,right: 25),
              child: Column(
                  children: [
                    SizedBox(
                    ),

                    Text(
                      "Reset Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.blueAccent),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // text field
                    Form(
                        key: _formKey,
                        child: TextArea(
                            controller: emailController,
                            icon: Icon(Icons.alternate_email_rounded),
                            label: "E-mail")),

                    SizedBox(
                      height: 30,
                    ),
                    //send email button
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // login to firebase
                            _auth
                                .sendPasswordResetEmail(
                                email: emailController.text.toString().trim())
                                .then((value) {
                              //sucess code here
                              //navigate to home page
                              setState(() {
                                emailSent =
                                "Done! Please check you e-mail for Password reset link";
                              });
                              // catching error
                            }).catchError(
                                  (error) {
                                //on catch code here
                                print('${error}');
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Send Link",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Card(
                            elevation: 2.0,
                            child: Text(
                              emailSent.toString(),
                              style: TextStyle(color: Colors.green),
                            ))),
                  ],

              ),
            )
          ],
        ),
      ),
    );
  }
}
