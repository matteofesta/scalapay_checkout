import 'package:flutter/material.dart';

class InputField extends StatefulWidget {

  String label, hint;
  TextEditingController controller;

  TextInputType inputType;
  TextCapitalization textCapitalization;
  int maxLength;
  bool isRequired;

  @override
  State createState() => new InputFieldStates();

  InputField(this.label, this.controller, {Key? key, this.hint = "", this.inputType = TextInputType.text, this.textCapitalization = TextCapitalization.sentences, this.maxLength = TextField.noMaxLength, this.isRequired = true}) : super(key: key);
}

class InputFieldStates extends State<InputField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              if(widget.isRequired) Text("*", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red))
            ],
          ),
          TextFormField(
            controller: widget.controller,
            validator: (value) {
              if ((widget.isRequired && (value == null || value.isEmpty))) {
                return 'Please enter the requested value';
              }
              return null;
            },
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.inputType,
            maxLength: widget.maxLength,
            style: TextStyle(fontSize: 14, height: 1.25, color: Colors.black),
            decoration: InputDecoration(
              counterText: "",
              hintText: widget.hint,
              hintStyle: TextStyle(fontSize: 14, height: 1.25, color: Colors.grey.shade400),
            ),
          )
        ],
      ),
    );
  }
}
