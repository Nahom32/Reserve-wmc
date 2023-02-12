import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldmedicalcenter/blocs/auth_bloc.dart';
import 'package:worldmedicalcenter/repository/auth_repository.dart';
import 'package:worldmedicalcenter/ui/Add.dart';
import 'package:worldmedicalcenter/ui/HomePage.dart';
import 'package:worldmedicalcenter/ui/addfile.dart';
import '../ui/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
  MultiBlocProvider(
    providers:[
      BlocProvider(create:(context) => AuthBloc(authRepository: AuthRepository()),)
  ], child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {"/add": (context) => Add()},
      title: 'World Medical App',
      theme: ThemeData(
        primaryTextTheme: const TextTheme(
            bodyText1: TextStyle(fontFamily: "Nunito Sans", fontSize: 10)),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
