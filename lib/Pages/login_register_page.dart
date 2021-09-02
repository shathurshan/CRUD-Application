import 'package:crud_app/validations/custom_form_field.dart';
import 'package:crud_app/validations/db.dart';
import 'package:crud_app/validations/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginForm extends StatefulWidget {
  final FocusNode focusNode;
  const LoginForm({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _uidController = TextEditingController();

  String getId = '';
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: MediaQuery.of(context).size.height * .3,
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  bottom: 10.0,
                ),
                child: Column(
                  children: [
                    CustomFormField(
                      isObscure: true,
                      initialValue: "",
                      controller: _uidController,
                      focusNode: widget.focusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      label: "Unique User Id",
                      hint: "Enter your unique Identifier",
                      validator: (value) {
                        Validator.validateFiels(
                          value: value,
                        );
                        getId = value;
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 0.0,
                  right: 0.0,
                ),
                child: Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.orangeAccent,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.focusNode.unfocus();
      
                      if (_loginFormKey.currentState!.validate()) {
                        DataBase.userId = getId;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 20.0,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
