import 'package:flutter/material.dart';

class AppNavigator{
  static Future openPage(context,Widget child)async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>child));
  }

  static Future openAndRemoveUntil(context,Widget child)async{
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>child),(route) => false,);
  }
  static Future closePage(context)async{
    Navigator.pop(context);
  }
}