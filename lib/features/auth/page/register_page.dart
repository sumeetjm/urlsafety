import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urlsafety/core/util/hex_color.dart';
import 'package:urlsafety/features/auth/bloc/auth_bloc.dart';
import 'package:urlsafety/injection_container.dart';

import '../bloc/auth_event.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';
import '../widget/auth_page_link_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final SharedPreferences sharedPreferences = sl<SharedPreferences>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    return BlocConsumer<RegisterBloc, RegisterState>(
      bloc: registerBloc,
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Registered successfully. Logging in'),
            backgroundColor: Colors.green,
          ));
          authBloc.add(LoggedInEvent());
        } else if (state is RegisterFailure) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message ?? ''),
              backgroundColor: Colors.orange,
            ));
          }
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
              child: ListView(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 72,
                        backgroundColor: Color.fromARGB(249, 197, 34, 34),
                        child: ImageIcon(AssetImage('assets/in_app_logo.png'),
                            size: 100, color: Colors.black),
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
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
                            Icons.person,
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
                        padding: const EdgeInsets.all(8.0),
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
                            content: Text('Username is blank'),
                            backgroundColor: Colors.orange,
                          ));
                          return;
                        }
                        if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Password is blank'),
                            backgroundColor: Colors.orange,
                          ));
                          return;
                        }
                        if (sharedPreferences
                            .containsKey(usernameController.text.trim())) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('User already exists'),
                            backgroundColor: Colors.orange,
                          ));
                          return;
                        }
                        registerBloc.add(RegisterRequestEvent(
                            usernameController.text, passwordController.text));
                      },
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
                      ),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Color.fromARGB(255, 33, 115, 209),
                        ),
                      )),
                  AuthPageLinkButton(
                    text: 'Already signed up? Login',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
