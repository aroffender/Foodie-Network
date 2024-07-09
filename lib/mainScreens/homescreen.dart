import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../authentication/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
        ElevatedButton(
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(
                horizontal: 50, vertical: 20
            )
        ),
        onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (c) => const Auth()));
        }
        ,
        child: const Text(
          "Sign Out",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      )
          ],
        ),

      ),
    );
  }
}
