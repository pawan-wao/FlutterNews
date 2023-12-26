import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Widgets/screen_forgotpassword.dart';
import 'package:news_app/main.dart';
import 'package:news_app/newshome.dart';
import 'screen_SignUp.dart';
import 'widget_textarea.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  String errormsg = "";

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.3,
                child: Image.asset("assets/images/loginimg.png",fit: BoxFit.cover,alignment: Alignment.bottomLeft,)),

            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome Back,",
                          style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Make it work, make it right, made it fast",
                          style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextArea(
                            controller: nameController,
                            icon: Icon(Icons.person),
                            label: 'Name'),
                        SizedBox(
                          height: 15,
                        ),
                        TextArea(
                            controller: emailController,
                            icon: Icon(Icons.alternate_email_rounded),
                            label: 'E-mail'),
                        SizedBox(
                          height: 15,
                        ),
                        TextArea(
                          controller: passwordController,
                          icon: Icon(Icons.fingerprint_rounded),
                          label: 'Password',
                          obscure: true,
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),

                  //forogot password
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: (){
                          // going to forgot password page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  // submit button
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          // login to firebase
                          _auth
                              .signInWithEmailAndPassword(
                            email: emailController.text.toString().trim(),
                            password: passwordController.text.toString().trim(),
                          )
                              .then((value) {
                            //sucess code here
                            //navigate to home page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsHome(user_name: nameController.text.toString().trim()),
                                ));
                            // catching error
                          }).catchError(
                                (error) {
                              //on catch code here
                              setState(() {
                                errormsg = error.toString();
                              });
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
                              "SignIn",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white),
                            )),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  // Text button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account?",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ));
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          )),
                      SizedBox(height: 20,),

                    ],
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Card(
                          elevation: 2.0,
                          child: Text(
                            errormsg.toString(),
                            style: TextStyle(color: Colors.green),
                          ))),
                ],),
            )
          ],
        ),
      ),
    );
  }
}