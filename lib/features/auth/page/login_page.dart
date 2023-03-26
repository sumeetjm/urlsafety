import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urlsafety/core/util/hex_color.dart';
import 'package:urlsafety/features/auth/bloc/auth_bloc.dart';

import '../bloc/auth_event.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widget/auth_page_link_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of(context);
    final LoginBloc loginBloc = BlocProvider.of(context);
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully logged in'),
          ));
          authBloc.add(LoggedInEvent());
        } else if (state is LoginFailure) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message ?? ''),
            ));
          }
        } else if (state is LogoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Successfully logged out'),
          ));
          authBloc.add(LoggedOutEvent());
        }
      },
      builder: (context, state) {
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 72,
                        backgroundColor: Color.fromARGB(249, 197, 34, 34),
                        child:
                            Icon(Icons.security, size: 75, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text('Phishing Detector',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                      ),
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: "Username",
                      fillColor: Colors.white.withOpacity(0.5),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.phone_outlined,
                            color: HexColor.fromHex('#16375a'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                      ),
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: "Password",
                      fillColor: Colors.white.withOpacity(0.5),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.lock_outline_rounded,
                            color: HexColor.fromHex('#16375a'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (usernameController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Phone number is blank'),
                          ));
                          return;
                        }
                        if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Password is blank'),
                          ));
                          return;
                        }
                        if (usernameController.text.trim() == 'admin' &&
                            passwordController.text.trim() == 'admin') {
                          loginBloc.add(LoginRequestEvent());
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Username or password incorrect'),
                          ));
                        }
                      },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Color.fromARGB(255, 33, 115, 209),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size.fromHeight(50)),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 61, 122, 214)))),
                      )),
                  Center(
                    child: AuthPageLinkButton(
                      text: "Don't have account yet? Sign up",
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
