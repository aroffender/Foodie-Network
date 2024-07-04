import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../widgets/custom_text_field.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset(
                    "images/seller.png",height: 270,
                ),


            )
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.person ,
                  controller: emailController,
                  hintText: "Email",
                  isObscure: false,

                ),
                CustomTextField(
                  data: Icons.person ,
                  controller: passwordController,
                  hintText: "Password",
                  isObscure: false,

                ),


              ],
            ),
          ),
          ElevatedButton(
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold
              ),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: 20
                )
            ),
            onPressed: ()=> print("clicked"),
          )


        ],
      )
    );
  }
}
