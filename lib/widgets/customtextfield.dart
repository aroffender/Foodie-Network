import 'package:flutter/material.dart';

class MyAppText extends StatelessWidget {

  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObserce= true;
  bool? enabled= true;
  MyAppText({
    this.controller,
    this.data,
    this.hintText,
    this.isObserce,
    this.enabled
  });


  @override
  Widget build(BuildContext context) {
    return Container(
        design: const BoxDecoration(
            color:Colors.white,
            borderRadius; BorderRadius.all(Radius.circular(10)),

    ),
    padding: const EdgeInsets.all(8.0),
    margin: const EdgeInsets.all(10),
    child: TextFormField(
    enabled: enabled,
    controller: controller,
    obscureText: isObserce!,
    cursorColor: theme.of(context).primaryColor,
    decoration: InputDecoration(
    border:  InputBorder.none,
    prefixIcon: Icon(
    data
    color:colors.cyan,

    ),
    focusColor: Theme.of(context).primaryColor,
    hintText: hintText,
    )



    )

    );
  }
}

void main() {
  runApp(const MyApp());
}