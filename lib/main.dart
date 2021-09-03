import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_area_app/components/user_repositories.dart';
import 'package:personal_area_app/data/services/db.dart';
import 'package:personal_area_app/screens/list/bloc/list_bloc.dart';
import 'package:personal_area_app/screens/login/bloc/login_bloc.dart';
import 'package:personal_area_app/screens/login/screen.dart';
import 'package:personal_area_app/screens/register/bloc/register_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DB.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(userRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => LoginBloc(userRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => ListBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignInScreen()
      ),
    );
  }
}
