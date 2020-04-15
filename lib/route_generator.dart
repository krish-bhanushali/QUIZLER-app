import 'package:flutter/material.dart';
import 'main.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name)
    {
      case '/':
        return MaterialPageRoute(builder: (_)=> Quizzler());
      case '/main':
        return MaterialPageRoute(builder: (_)=> Quizzler());
      case '/Quiz1':
        return MaterialPageRoute(builder: (_)=> QuizPage());
      default:
        return _errorRoute();

    }


  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('ERROR'),
        ),
        body: Center(
          child: Text('Error 404 , Sorry',style: TextStyle(color: Colors.white),),
        ),
      );
    });
  }


}