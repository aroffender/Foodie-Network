import 'package:flutter/material.dart';
import 'package:myapp/authentication/authtentication_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer()
  {
    Timer(const Duration(seconds: 5),() async{
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const Auth()));
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/splash.jpg"),
              const SizedBox(height: 12,),
              const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    "Find Restaurants Near You",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 40,
                      fontFamily: "Sinatra",
                      letterSpacing: 3,
                    ),
                  ),
              )
            ],
          )
        ),
      ),
    );
  }
}



