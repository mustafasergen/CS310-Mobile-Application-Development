import 'package:flutter/material.dart';
import 'package:projedeneme/services/auth.dart';
import 'package:projedeneme/services/db.dart';

class FeedView extends StatelessWidget {

  AuthService auth = AuthService();
  DBService db = DBService();

  @override
  Widget build(BuildContext context) {

    db.addUser('name', 'surname', 'mail', 'token');
    db.addUserAutoID('nameAuto', 'surnameAuto', 'mail@auto', 'token');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            auth.signOutFromGoogle();
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: Center(
        child: Text(
          'FEED VIEW',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}