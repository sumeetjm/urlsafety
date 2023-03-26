import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_url_check/safe_url_check.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:urlsafety/core/constants/constants.dart';
import 'package:urlsafety/core/util/hex_color.dart';
import 'package:urlsafety/features/auth/bloc/auth_bloc.dart';
import 'package:urlsafety/features/auth/bloc/auth_event.dart';
import 'package:urlsafety/features/auth/bloc/auth_state.dart';
import 'package:urlsafety/features/auth/bloc/login_bloc.dart';
import 'package:urlsafety/features/auth/bloc/register_bloc.dart';
import 'package:urlsafety/features/auth/page/auth.dart';
import 'package:urlsafety/features/auth/page/splash_page.dart';
import 'package:urlsafety/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc authBloc;
  late LoginBloc loginBloc;
  late RegisterBloc registerBloc;

  @override
  void initState() {
    authBloc = sl<AuthBloc>();
    loginBloc = sl<LoginBloc>();
    registerBloc = sl<RegisterBloc>();
    authBloc.add(CheckLoginEvent());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => authBloc,
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => loginBloc,
        ),
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) => registerBloc,
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: authBloc,
        builder: (context, state) {
          const authApp = AuthApp();
          if (state is Unauthenticated) {
            return authApp;
          } else if (state is Authenticated) {
            return FutureBuilder<void>(
                future: Future.delayed(const Duration(seconds: 2)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return const MaterialApp(
                        home: MyHomePage(title: 'Phishing Detector'));
                  } else {
                    return const MaterialApp(
                      home: SplashPage(),
                    );
                  }
                });
          } else {
            return const MaterialApp(
              home: SplashPage(),
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? safe;
  bool? valid;
  bool loading = false;
  String validUrl = '';
  final TextEditingController controller = TextEditingController();

  void _checkUrl(String url) async {
    var uri = Uri.parse(url);
    if (AppConstants.validateUrl) {
      setState(() {
        loading = true;
      });
      final valid = await safeUrlCheck(
        uri,
      );
      if (valid) {
        validUrl = url;
      } else {
        validUrl = '';
      }
      this.valid = valid;
    } else {
      validUrl = url;
    }

    final safe = AppConstants.allowedHosts.contains(uri.host);

    // This call to setState tells the Flutter framework that something has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
    this.safe = safe;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: const Icon(Icons.security,
                    size: 50, color: Color.fromARGB(249, 197, 34, 34)),
              ),
              SizedBox(height: 50),
              Text(
                'PHISHING URL DETECTOR',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    fillColor: Colors.white,
                    labelText: 'Enter url',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _checkUrl(controller.text);
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: Color.fromARGB(255, 33, 115, 209),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size.fromHeight(50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 61, 122, 214)))),
                  )),
              SizedBox(height: 20),
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: controller.text.isNotEmpty
                    ? Builder(
                        builder: (context) {
                          if (loading && AppConstants.validateUrl) {
                            return CircularProgressIndicator();
                          } else {
                            return TextButton(
                                onPressed: () {
                                  if ((valid ?? false) ||
                                      !AppConstants.validateUrl) {
                                    launchUrlString(validUrl);
                                  }
                                },
                                child: AppConstants.validateUrl
                                    ? Text(
                                        'Entered url is ${(valid ?? false) ? 'valid ${(safe ?? false) ? 'and safe' : 'but not safe'} . Tap to visit' : 'not valid'}',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        'Entered url is ${(safe ?? false) ? 'safe' : 'not safe'}. Tap to visit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ((valid ?? false) ||
                                                  !AppConstants.validateUrl)
                                              ? ((safe ?? false)
                                                  ? Colors.green
                                                  : Colors.orange)
                                              : Colors.grey),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size.fromHeight(50)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 61, 122, 214)))),
                                ));
                          }
                        },
                      )
                    : null,
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
