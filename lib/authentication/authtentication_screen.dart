import 'package:flutter/material.dart';
import 'package:myapp/authentication/login.dart';
import 'package:myapp/authentication/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/screens/home.dart';
//import 'package:myapp/mainScreens/ratings.dart';
import 'package:myapp/seat/seat_selection_controller.dart';
import 'package:myapp/screens/review.dart';



class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.blueGrey,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: const Text(
            'Foodie Network',
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontFamily: "Lobster",
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white10,
            indicatorWeight: 6,
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white),
                text: "Login",
              ),

              Tab(
                icon: Icon(Icons.person, color: Colors.white),
                text: "Register",
              ),
              Tab(
                icon: Icon(Icons.home, color: Colors.white),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.lock_clock, color: Colors.white),
                text: "Booking",
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.cyan,
                Colors.white,
              ],
            ),
          ),
          child: const TabBarView(
            children: [
              LoginPage(),
              SignupPage(),
             // Home,
              bookingpage(),
              reviewp(restaurantID: '12345')


            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Auth(),
  ));
}
