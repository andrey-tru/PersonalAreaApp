import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<User?> signUp(
    String password,
    String confirmationPassword,
    dynamic data,
  ) async {
    try {
      if (password == confirmationPassword) {
        var auth = await firebaseAuth.createUserWithEmailAndPassword(
          email: data['e-mail'],
          password: password,
        );
        await firebaseFirestore.collection('users').doc(data['e-mail']).set(data);
        return auth.user;
      } else {
        throw ('Пароли не совпадают');
      }
    } catch (e) {
      switch (e.hashCode) {
        case 432069392:
          throw ("заполните поля");
        case 265778269:
          throw ("пароль должен состоять из 6 символов");
        case 34618382:
          throw ("емайл уже используется");
        case 360587416:
          throw ("неправильный формат e-mail");
        default:
          throw (e);
      }
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return auth.user;
    } catch (e) {
      switch (e.hashCode) {
        case 432069392:
          throw ("заполните поля");
        case 505284406:
          throw ("Пользователя не существует");
        case 185768934:
          throw ("Неверный пароль");
        default:
          throw (e.hashCode);
      }
    }
  }

  Future<void> updateUser(dynamic data, dynamic elem) async {
    await firebaseFirestore.collection('users').doc(data['e-mail']).update(elem);
  }
}
