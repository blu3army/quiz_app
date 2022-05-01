import 'package:flutter/material.dart';
import 'quiz_brain.dart';


QuizBrain quizBrain = QuizBrain();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: Scaffold(
        body: SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff253f6f),
                          Color(0xff4669b8),
                        ])),
                child: MyBody())),
      ),
    );
  }
}

class MyBody extends StatefulWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {

  List<Icon> scoreKeeper = [];

  void _check(bool result){
    setState(() {
      bool next = quizBrain.nextQuestion();

      if(next){
        //Correct
        if(result == quizBrain.getAnswer()){
          scoreKeeper.add(Icon( Icons.check, color: Colors.green[300], size: 20));
        }
        //Incorrect
        else{
          scoreKeeper.add(
              Icon( Icons.close, color: Colors.redAccent, size: 20,)
          );
        }
      }



    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 7,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(quizBrain.getText(),
                  style: TextStyle(fontSize: 25, color: Colors.white)),
            ),
          ),
        ),
        SelectButton(
          press: () {
            _check(true);
          },
          text: 'True',
          color: Colors.green.shade400,
        ),
        SelectButton(
            press: () {
              _check(false);
            },
            text: 'False',
            color: Colors.redAccent.shade200
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}



class SelectButton extends StatelessWidget {
  const SelectButton(
      {Key? key, required this.press, required this.text, required this.color})
      : super(key: key);

  final Function press;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: TextButton(
          onPressed: () => press(),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
