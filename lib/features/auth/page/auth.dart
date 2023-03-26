import 'package:flutter/material.dart';
import 'package:urlsafety/features/auth/page/login_page.dart';
import 'package:urlsafety/features/auth/page/register_page.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      onGenerateRoute: (RouteSettings settings) {
        final routes = <String, WidgetBuilder>{
          '/register': (context) => const RegisterPage(),
          '/login': (context) => const LoginPage(),
          /*'/forgot-password': (context) =>
              ForgotPasswordPage(settings.arguments),
          '/resend-verification': (context) =>
              ResendVerificationPage(settings.arguments),*/
        };
        WidgetBuilder builder =
            routes[settings.name] ?? (context) => const LoginPage();
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
