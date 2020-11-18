import 'package:flutter/material.dart';

class TextFieldArea extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final FocusNode currentfocus;
  final FocusNode nextfocus;
  final TextEditingController controller;
  TextFieldArea(
      {this.hint, this.currentfocus, this.nextfocus,this.inputType, this.controller});
  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 20, 20),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'value cannot be empty';
            }
            return null;
          },
          keyboardType: inputType,
          textInputAction: TextInputAction.next,
          controller: controller,
          focusNode: currentfocus,
          onFieldSubmitted: (term) {
            _fieldFocusChange(context, currentfocus, nextfocus);
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
              fillColor: Colors.green,
              labelText: hint),
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
