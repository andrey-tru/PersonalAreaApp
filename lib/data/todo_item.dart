class TodoItem extends Model {
  static String table = 'login';

  final String login;
  final String password;

  TodoItem({required this.login, required this.password});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'login': login,
      'password': password,
    };
    return map;
  }

  static TodoItem fromMap(Map<String, dynamic> map) {
    return TodoItem(
      login: map['login'],
      password: map['password'].toString(),
    );
  }
}

abstract class Model {
  static fromMap() {}
  toMap() {}
}
