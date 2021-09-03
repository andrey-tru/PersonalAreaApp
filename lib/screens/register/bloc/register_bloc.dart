import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_area_app/components/user_repositories.dart';
import 'package:personal_area_app/data/services/db.dart';
import 'package:personal_area_app/data/todo_item.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository? userRepository;
  RegisterBloc({this.userRepository}) : super(RegisterInitial());

  List<TodoItem> savedUser = [];

  void _save(login, password) async {
    TodoItem item = TodoItem(login: login, password: password);
    await DB.insert(TodoItem.table, item);
    refresh();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(TodoItem.table);
    _results.map((item) => TodoItem.fromMap(item)).toList();
  }

  void _delete() async {
    DB.delete(TodoItem.table);
    refresh();
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      yield RegisterLoading();

      try {
        var user = await userRepository!
            .signUp(event.password, event.confirmationPassword, event.data);
        _delete();
        _save(event.email, event.password);
        yield RegisterSucced(user: user);
      } catch (e) {
        yield RegisterFailed(message: e.toString());
      }
    }
  }
}
