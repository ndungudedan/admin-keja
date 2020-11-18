import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final TextEditingController controller;
  InputFieldArea({this.hint, this.obscure, this.icon,this.controller});
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 5),
      decoration: BoxDecoration(
        
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          border: OutlineInputBorder(),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
          contentPadding: const EdgeInsets.only(
              top: 10.0, right: 30.0, bottom: 10.0, left: 5.0),
        ),
      ),
    ));
  }
}
