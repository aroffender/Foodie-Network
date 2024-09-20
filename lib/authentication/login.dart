import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/global/global.dart';
import 'package:myapp/mainScreens/homescreen.dart';
import 'package:myapp/mainScreens/hs2.dart';
import 'package:myapp/widgets/error_dialouge.dart';
import 'package:myapp/widgets/loading.dart';

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

  formvalidation(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      loginNow();
    }
    else{
      showDialog(
          context: context,
          builder: (c)
          {
              return ErrorDialouge(message: "Please fill email and password",);
          }

      );
    }
  }


  Future readsavelocal(User currentUser) async //readDataAndSetDataLocally= readsavelocal
  {
    await FirebaseFirestore.instance.collection('Users1')
        .doc(currentUser.uid).get().then((snapshot) async{
          await sharedPreferences!.setString("uid", currentUser.uid);
          await sharedPreferences!.setString("email",snapshot.data()!["email"]);
          await sharedPreferences!.setString("name", snapshot.data()!["name"]);
          await sharedPreferences!.setString("photoUrl", snapshot.data()!["useravatarurl"]);

    });
  }  

  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return loading(
            message: "Checking Credentials" ,
          );
        }
        );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialouge(
              message: error.message.toString(),
            );
          }

      );
    } );
    if (currentUser!= null)
    {
        readsavelocal(currentUser!).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> hs2()));
        });
    }
  }





  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(15),
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
                  data: Icons.email ,
                  controller: emailController,
                  hintText: "Email",
                  isObscure: false,

                ),
                CustomTextField(
                  data: Icons.key ,
                  controller: passwordController,
                  hintText: "Password",
                  isObscure: true,

                ),


              ],
            ),
          ),




          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 80, vertical: 20
                )
            ),
            onPressed: (){

              formvalidation();

            },
            child: const Text(
              "Login",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 80, vertical: 20
                )
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const hs2()));
            },
            child: const Text(
              "Skip",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold
              ),
            ),
          )


        ],
      )
    );
  }
}
