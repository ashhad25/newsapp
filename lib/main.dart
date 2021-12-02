import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

final Future<FirebaseApp> _initialization = Firebase.initializeApp();

   MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // ignore: avoid_print
          print(snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            ); 

        }

      return const Padding(
      padding: EdgeInsets.only(bottom: 10,),
       child: Align(
        alignment: Alignment.bottomCenter,
        child: CircularProgressIndicator(color: Colors.blue,),
        ),
        );
      },
    );
  }
}

