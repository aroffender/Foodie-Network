import 'package:flutter/material.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController anyController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
       child: Column(
         mainAxisSize: MainAxisSize.max,
         children: [
           InkWell(
             child: CircleAvatar(
                radius: MediaQuery.of(context).size.width*0.20,
               backgroundColor: Colors.white,
               backgroundImage: ,

             )
           )
         ],
         )
       ),
      ),
    )
  }
}
