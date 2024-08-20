import 'package:flutter/material.dart';
import 'package:grocery_p/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String? validateEmail(String? email) {
  RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final isEmailValid = emailRegex.hasMatch(email ?? '');
  if (!isEmailValid) {
    return "Please provide a valid email";
  }
  return null;
}

bool obserText = true;

final _email = TextEditingController();
final _password = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  void dispsose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(50),
              padding: const EdgeInsets.all(20),
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 300,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    //color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextFormField(
                          controller: _email,
                          validator: validateEmail,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          controller: _password,
                          obscureText: obserText,
                          validator: (value) {
                            if (value == "") {
                              return "Please Provide a password!";
                            } else if (value!.length < 8) {
                              return "Password must contain at least 8 letters!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obserText = !obserText;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              child: Icon(
                                obserText == true
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                            ),
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _formKey.currentState?.validate();
                            },
                            child: Text('Login'),
                          ),
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have an account?'),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ));
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
