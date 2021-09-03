import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_area_app/screens/main/main_navigation.dart';
import 'package:personal_area_app/screens/register/bloc/register_bloc.dart';
import 'package:personal_area_app/components/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSucced) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MainNavigation(email: emailController.text,)));
                  }
                },
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is RegisterFailed) {
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
                hintText: 'Имя',
                textInputType: TextInputType.name,
                obscureText: false,
                controller: nameController,
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
              CustomTextField(
                hintText: 'Подтверждение пароль',
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                controller: confirmationPasswordController,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> data = {
                    'e-mail': emailController.text,
                    'name': nameController.text,
                    'registration_date':
                        DateFormat('dd/MM/yyyy').format(DateTime.now()),
                  };
                  BlocProvider.of<RegisterBloc>(context).add(
                    SignUpButtonPressed(
                      email: emailController.text,
                      password: passwordController.text,
                      confirmationPassword: confirmationPasswordController.text,
                      data: data,
                    ),
                  );
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
