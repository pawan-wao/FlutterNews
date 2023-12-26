
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Widgets/screen_SignIn.dart';
import 'package:news_app/Widgets/widget_textarea.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/main.dart';
import 'package:news_app/newshome.dart';

class SignUp extends StatefulWidget{

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();


  bool loading = false;

  String errormsg = "";

  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.22,
                  child: Image.asset('assets/images/signup.png',fit: BoxFit.cover,alignment: Alignment.bottomCenter,)),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //top image
                    Text("Get On Board!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    Text("Create your profile to start your journey",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextArea(
                              controller: nameController,
                              icon: Icon(Icons.person),
                              label: 'Name'),
                          SizedBox(height: 15,),
                          TextArea(controller: emailController, icon: Icon(Icons.alternate_email_rounded), label: 'E-mail'),
                          SizedBox(height: 15,),
                          TextArea(controller: phoneController, icon: Icon(Icons.phone), label: 'Phone No'),
                          SizedBox(height: 15,),
                          TextArea(controller: passwordController, icon: Icon(Icons.fingerprint_rounded), label: 'Password',obscure: true),
                          SizedBox(height: 35,),
                        ],
                      ),
                    ),

                    // submit button
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: (){
                          //creating new user on firebase
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              loading = true;
                            });
                            _auth.createUserWithEmailAndPassword(
                              email: emailController.text.toString().trim(),
                              password: passwordController.text.toString().trim(),).then((value){
                              //sucess steps here
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsHome(user_name: nameController.text.toString().trim()),));
                              setState(() {
                                loading = false;
                              });
                            }).catchError((error){
                              //handle or get error here
                              setState(() {
                                loading = false;
                                errormsg = error.toString();

                              });

                              print('${error}');

                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*0.5,
                          decoration: BoxDecoration(borderRadius:
                          BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child:
                            loading == true ?
                            CircularProgressIndicator(color: Colors.white):
                            Text("SignUp",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),
                    // Text button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Already have an Account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context) => SignIn(),));
                            },
                            child: Text("LOGIN",style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.bold,color: Colors.blueAccent),)),
                        SizedBox(height: 20,),
                        //showing error msg
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}