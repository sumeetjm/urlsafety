import 'dart:io';

import 'package:flutter/material.dart';
import 'package:urlsafety/core/util/hex_color.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    width: 75,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.security,
                          size: 50, color: Color.fromARGB(249, 197, 34, 34)),
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
