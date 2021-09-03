import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_area_app/screens/login/bloc/login_bloc.dart';
import 'package:personal_area_app/screens/main/main_navigation.dart';
import 'package:personal_area_app/screens/register/screen.dart';
import 'package:personal_area_app/components/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSucced) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MainNavigation(
                                  email: emailController.text,
                                )));
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is LoginFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              CustomTextField(
                hintText: 'Логин (E-mail)',
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: 'Пароль',
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  loginBloc.add(
                    SignInButtonPressed(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                },
                child: Text('Войти'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
                child: Text('Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
