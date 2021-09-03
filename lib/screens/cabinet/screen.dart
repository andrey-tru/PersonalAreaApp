import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CabinetScreen extends StatefulWidget {
  final String email;
  CabinetScreen({required this.email});

  @override
  _CabinetScreenState createState() => _CabinetScreenState();
}

class _CabinetScreenState extends State<CabinetScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.email)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Что-то пошло не так"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic>? data = snapshot.data!.data();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Имя пользователя: ${data!['name']}"),
                const SizedBox(
                  height: 20,
                ),
                Text("Дата Регистрации: ${data['registration_date']}"),
              ],
            );
          }
          return Center(child: Text("Загрузка..."));
        },
      ),
    );
  }
}
