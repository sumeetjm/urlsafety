import 'package:flutter/material.dart';

class AuthPageLinkButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const AuthPageLinkButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: TextButton(
          onPressed: () => onPressed(),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
