import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urlsafety/core/util/hex_color.dart';
import 'package:urlsafety/injection_container.dart';

import '../../../main.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferences sharedPreferences = sl<SharedPreferences>();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Welcome ${sharedPreferences.getString('loggedUser')}'),
          backgroundColor: Colors.green,
        ));
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const MyHomePage(title: 'Phishing Detector');
          },
        ));
      },
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            HexColor.fromHex('#0c566f'),
            HexColor.fromHex('#4a5d7e'),
          ],
        )),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.transparent,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.transparent,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Hero(
                      tag: 'in_app_logo',
                      child: CircleAvatar(
                        radius: 72,
                        backgroundColor: Color.fromARGB(249, 197, 34, 34),
                        child: ImageIcon(AssetImage('assets/in_app_logo.png'),
                            size: 100, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Phishing Detector',
                    style: TextStyle(color: Colors.white, fontSize: 20))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
