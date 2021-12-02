import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newsapp/auth/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 8),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login())));
  }

  @override
  Widget build(BuildContext context) {
    var url =
        'https://media4.s-nbcnews.com/i/newscms/2019_01/2705191/nbc-social-default_b6fa4fef0d31ca7e8bc7ff6d117ca9f4.png';
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          )),
          child: const Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
