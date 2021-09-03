import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_area_app/components/user_repositories.dart';
import 'package:personal_area_app/data/services/db.dart';
import 'package:personal_area_app/data/todo_item.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository? userRepository;
  LoginBloc({this.userRepository}) : super(LoginInitial()) {
    add(LoginInitialEvent());
  }

  List<TodoItem> savedUser = [];

  void _save(login, password) async {
    TodoItem item = TodoItem(login: login, password: password);
    await DB.insert(TodoItem.table, item);
    refresh();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(TodoItem.table);
    savedUser = _results.map((item) => TodoItem.fromMap(item)).toList();
  }

  void _delete() async {
    DB.delete(TodoItem.table);
    refresh();
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    refresh();
    if (event is LoginInitialEvent && savedUser.isNotEmpty) {
      yield LoginLoading();
      try {
        var user = await userRepository!
            .signIn(savedUser.first.login, savedUser.first.password);
        yield LoginSucced(user: user);
      } catch (e) {
        yield LoginFailed(message: e.toString());
      }
    }
    if (event is SignInButtonPressed) {
      yield LoginLoading();
      try {
        var user = await userRepository!.signIn(event.email, event.password);
        _delete();
        _save(event.email, event.password);
        yield LoginSucced(user: user);
      } catch (e) {
        yield LoginFailed(message: e.toString());
      }
    }
  }
}
