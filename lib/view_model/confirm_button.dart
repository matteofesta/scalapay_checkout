import 'package:flutter/material.dart';

//Posso anche creare una classe per un widget che devo riutilizzare diverse volte, senza dover duplicare ogni volta il codice
class ConfirmButton extends StatelessWidget {
  String label;
  VoidCallback onPressed;

  ConfirmButton(this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 170, maxHeight: 200),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                  side: const BorderSide(color: Colors.green)
              ),
            ),
            onPressed: onPressed,
            child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.25), textAlign: TextAlign.center),
          ),
        )
      ],
    );
  }
}
