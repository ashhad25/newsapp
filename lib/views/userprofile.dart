import 'package:flutter/material.dart';
import 'package:newsapp/auth/login.dart';
// ignore: use_key_in_widget_constructors
class Profile extends StatelessWidget {
    final TextEditingController usernameController = TextEditingController(text:,);

  @override
  Widget build(BuildContext context) {

    Login log = const Login();
    usernameController.text = log.login(snao),
    return Scaffold(
      appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Flutter",style: TextStyle(color: Colors.black26),),
                Text("News",style: TextStyle(color: Colors.blue),)
              ],
            ),
          ),
        body: Column(
          children: [
            Container(
            padding: const EdgeInsets.only(top: 30,left: 10,),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
            "http://www.clker.com/cliparts/d/L/P/X/z/i/no-image-icon-md.png",width: 120,height: 120,fit: BoxFit.cover,)
            ),
            ),
            const TextField(
            controller: ,
            )
          ],
        ),
    );
  }
}