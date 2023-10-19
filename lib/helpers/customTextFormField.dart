import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.labelText,
      this.keyboardType = TextInputType.text,
      this.valdiate = false})
      : super(key: key);
  final TextEditingController controller;
  final bool valdiate;

  final String labelText;
  var keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TextFormField(
            keyboardType: keyboardType,
            smartDashesType: SmartDashesType.enabled,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.go,
            keyboardAppearance: Brightness.light,
            mouseCursor: MouseCursor.uncontrolled,
            textDirection: TextDirection.rtl,
            validator: (val) {
              if (val!.isEmpty && valdiate) return 'هذا الحقل مطلوب';
            },
            controller: controller,
            style: TextStyle(color: Colors.black, fontSize: 20),
            cursorColor: Colors.deepPurple,
            decoration: InputDecoration(
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey.shade200,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                labelText: labelText,
                labelStyle: TextStyle(fontSize: 16),
                hintStyle: TextStyle(fontSize: 16),
                errorStyle: TextStyle(fontSize: 12),
                floatingLabelStyle: TextStyle(fontSize: 22)),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
