import 'package:flutter/material.dart';

class ErrorDialouge extends StatelessWidget {

  final String? message;
  ErrorDialouge({this.message});


  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          child: Center(
            child: Text("OK"),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red
          ),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        )
      ],
      
    );
  }
}

