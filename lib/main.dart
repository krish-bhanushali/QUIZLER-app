import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'route_generator.dart';

QuizBrain quizBrain = new QuizBrain();
void main() => runApp(Quizzler());

//keep records of score,settings to toggle between dark and light
//mainly a online game like Pysch when I learn firebase
//Score page displaying score that was returned from different page
class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        bottomNavigationBar: BottomAppBar(
          elevation: 5.0,
          child: Container(
            height: 40.0,
            child: Center(
              child: Icon(Icons.home),
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: MyHomePage(),
        )),
      ),
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: <Widget>[
            //ROW or TOP Bar
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0))
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50.0),

                    padding: EdgeInsets.all(20.0),

                    //              decoration: BoxDecoration(

                    //                color: Colors.grey.shade800,

                    //                borderRadius: BorderRadius.only(topRight:Radius.elliptical(50.0, 50.0),bottomRight:Radius.elliptical(50.0, 50.0) )

                    //              ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 30.0, color: Colors.grey.shade500),
                        ),
                        Text(
                          'MASTER!',
                          style: TextStyle(
                              color: Colors.grey.shade400, fontSize: 50.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Q',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'uizzler',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical:100.0 ),

          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.white,blurRadius: 2.0,offset: Offset(0.0, 1.0)),]

          ),
          child: Row(
            children: <Widget>[
              Container(
                height: 50,
                  width:50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                    
                ),
                child: Icon(Icons.flag),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('DEFAULT',
                    style: TextStyle(
                      fontSize: 20.0
                    ),),
                    Text('This quiz was already created by App brewlery team',
                    style: TextStyle(
                      fontSize: 10.0
                    ),)
                    
                  ],
                ),
              ),
              Container(
                child: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
                  Navigator.of(context).pushNamed('/Quiz1');
                }),
              )
            ],
          ),
        )
      ],
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int answerScore = 0;
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.questionAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "QUIZ IS COMPLETED! ",
          desc: "You got $answerScore/${quizBrain.quizLength()}",
          buttons: [
            DialogButton(
              child: Text(
                "YAY",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                scoreKeeper = [];
                quizBrain.restart();
                Navigator.of(context).pushNamed('/');
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        if (correctAnswer == userPickedAnswer) {
          print('User picked right answer');
          answerScore+=1;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
//          answerScore-=1;
          print('User picked wrong answer');
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.all(Radius.circular(60.0))
                ),
                child: Center(
                  child: Text(
                    quizBrain.questionTexts(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "satisfy",
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightGreen),
                    borderRadius: BorderRadius.all(Radius.circular(70.0))),
                child: FlatButton(
                  textColor: Colors.white,
                  child: Text(
                    'True',
                    style: TextStyle(
                      fontFamily: "satisfy",
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    //The user picked true.
                    checkAnswer(true);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(70.0))),
                child: FlatButton(
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontFamily: "satisfy",
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    //The user picked false.
                    checkAnswer(false);
                  },
                ),
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      ) ,
    );

  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
