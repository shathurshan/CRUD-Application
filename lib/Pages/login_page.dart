import 'package:crud_app/Pages/login_register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _uidFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _uidFocusNode.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 24.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.network(
                              "https://cdn1.iconfinder.com/data/icons/social-black-buttons/512/telegram-512.png",
                              height: 160.0,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            "CRUD APP",
                            style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                   const SizedBox(
                      height: 10.0,
                    ),
                    FutureBuilder(
                        future: _initializeFirebase(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Error Initializing Firebse");
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return LoginForm(
                              focusNode: _uidFocusNode,
                            );
                          }
                          return const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.redAccent,
                            ),
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
