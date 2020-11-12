import 'package:admin_keja/common/styles.dart';
import 'package:flutter/material.dart';

class ShowTextArea extends StatelessWidget {
  final String hint;
  final bool enabled;
  final FocusNode currentfocus;
  final FocusNode nextfocus;
  final TextEditingController controller;
  ShowTextArea(
      {this.hint,
      this.enabled,
      this.controller,
      this.currentfocus,
      this.nextfocus});
  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        children: [
          Text(hint,style: TextStyle(color: Styles.primaryFontColor),),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: TextFormField(
              enabled: enabled,
              textInputAction: TextInputAction.next,
              controller: controller,
              focusNode: currentfocus,
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, currentfocus, nextfocus);
              },
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.green, style: BorderStyle.solid, width: 5.0),
                ),
                contentPadding: const EdgeInsets.only(
                    top: 10.0, right: 30.0, bottom: 10.0, left: 5.0),
              ),
            ),
          ),
        
        ],
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
