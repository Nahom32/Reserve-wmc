import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldmedicalcenter/blocs/auth_event.dart';
import 'package:worldmedicalcenter/ui/HomePage.dart';
import 'package:worldmedicalcenter/ui/reset_password.dart';

import '../blocs/auth_bloc.dart';
import '../blocs/auth_state.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

void _authenticateWithGoogle(context) {
  BlocProvider.of<AuthBloc>(context).add(
    GoogleSignInRequested(),
  );
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigating to the dashboard screen if the user is authenticated
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is Loading) {
          // Showing the loading indicator while the user is signing in
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UnAuthenticated) {
          return Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Login to world Medical Card',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'How would you like to sign-in?',
                style: TextStyle(color: Colors.black54),
              ),
              Container(
                width: 300,
                height: 40,
                decoration: const BoxDecoration(color: Colors.black12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: Container(
                          child: const Image(
                        image: AssetImage(
                            'assets/google-icon-removebg-preview.png'),
                        // fit: BoxFit.cover,
                        width: 20,
                      )),
                      onTap: () {
                        _authenticateWithGoogle(context);
                        // BlocProvider.of<AuthBloc>(context)
                        // .add(GoogleSignInRequested());
                      },
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text('Sign-in with Google')
                  ],
                ),
              ),

              Row(children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),
                const Text("OR"),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 50,
                      )),
                ),
              ]),
              Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                    obscureText: _isObscure,
                  ),
                ]),
              ),
              //SizedBox(height: 130,),
              Expanded(
                  child: Column(
                children: [
                  GestureDetector(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PasswordReset();
                        }));
                      }),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        },
                        child: Container(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 130),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.blue,
                          ),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.all(Radius.circular(30))
                          // ),
                        )
                        // ,
                        ),
                  )
                ],
              ))
            ],
          );
        }
        return Container();
      }),
    ));
  }
}