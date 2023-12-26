import 'package:flutter/material.dart';

class TextArea extends StatelessWidget{
  String label;
  Icon icon;
  TextEditingController controller;
  bool obscure;

  TextArea({required this.controller, required this.icon, required this.label, this.obscure=false });

  @override
  Widget build(BuildContext context){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)),
        label: Text("${label}"),
        prefixIcon: icon,
      ),
      obscureText: obscure,
      controller: controller,

      //checking input
      validator: (value) {
        if ( label == "Password" && value!.length<5) {
          return 'Password is less than 5 characters';
        }
        if (label== 'E-mail' && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
          return 'Please enter a valid e-mail';
        }
        if (value==null || value!.isEmpty) {
          return 'Please enter ${label}';
        }
        return null;
      },
    );
  }
}