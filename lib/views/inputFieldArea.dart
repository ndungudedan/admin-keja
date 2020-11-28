import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
    final FocusNode currentfocus;
  final FocusNode nextfocus;
  final TextEditingController controller;
  InputFieldArea({this.hint, this.obscure, this.icon,this.controller,this.currentfocus,this.nextfocus});
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 5),
      decoration: BoxDecoration(
        
      ),
      child: TextFormField(
        controller: controller,
        focusNode: currentfocus,
          onFieldSubmitted: (term) {
            _fieldFocusChange(context, currentfocus, nextfocus);
          },
        obscureText: obscure,
        style: TextStyle(fontSize: 16.0,
              fontWeight: FontWeight.w700,),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          border: OutlineInputBorder(),
          hintText: hint,
          hintStyle: const TextStyle(color: LightColors.kDarkBlue, fontSize: 15.0),
          contentPadding: const EdgeInsets.only(
              top: 10.0, right: 30.0, bottom: 10.0, left: 5.0),
        ),
      ),
    ));
  }
    _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (currentFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}
