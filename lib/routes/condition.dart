import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projedeneme/routes/welcome.dart';
import 'package:projedeneme/routes/WalkThrough.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

class Condition extends StatefulWidget {
  @override
  _ConditionState createState() => _ConditionState();
}

class _ConditionState extends State<Condition> with AfterLayoutMixin<Condition>  {


  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Welcome()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new WalkThrough()));
    }
  }


  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}