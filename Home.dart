import 'dart:core';
import 'package:flutter/material.dart';
import 'package:qz/answer.dart';




class Home extends StatefulWidget {
   const Home({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _questionIndex = 0;
 int _totalscore = 0;
 List<Icon> _markscalculate = [];
 bool endofquiz = false;
 bool answerWasSelected = false;
 bool correctAnswerSelected = false;
 void _questionsAnswered(bool answerScore) {
   setState(() {
     // answer was selected
     answerWasSelected = true;
     //check if was corret
     if (answerScore == true) {
       _totalscore++;
       correctAnswerSelected =true;
     }
     // add track
     _markscalculate.add(
       answerScore ?  const Icon(
         Icons.check_circle,
         color: Colors.green,
       ) :  const Icon(
         Icons.clear,
         color: Colors.red,
       ),
     );
     //when the quiz ends
     if (_questionIndex + 1 == _questions.length) {
       endofquiz = true;
     }
   }
   );
 }
 void _nextquestion(){
   setState(() {
     _questionIndex++;
     answerWasSelected = false;
     correctAnswerSelected =false;
   });
   //what happens at end
   if(_questionIndex>=_questions.length){
     _resetQuiz();

   }
 }
 void _resetQuiz(){
   setState(() {
     _questionIndex = 0;
     _totalscore = 0;
     _markscalculate = [];
     endofquiz = false;

   });
 }









  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QUIZZLAND',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_markscalculate.isEmpty)
                const SizedBox(
                 height: 25.0,
               ),
                if(_markscalculate.isNotEmpty) ..._markscalculate
              ],
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin:   const EdgeInsets.only(bottom:10.0,left: 30.0,right: 30.0),
              padding:  const EdgeInsets.symmetric(horizontal: 50.0,vertical:20.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Center(
                child: Text(
                  (_questions[_questionIndex]['question'].toString()),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if(answerWasSelected && !endofquiz)
            Container(
              height: 100,
              width: double.infinity,
              color: correctAnswerSelected ? Colors.green:Colors.red,
              child: Center(
                child: Text(correctAnswerSelected?'yea you got the right one':'wrong answer:/'),
              ),
            ),
            if(endofquiz){
              Container(
             height: 100,
             width: double.infinity,
             color: Colors.black,
             child: Center(
             child : Text(_totalscore>0?'your score is $_totalscore':'blnt')
    ),

    )
            },

            ...(_questions[_questionIndex]['Answers'] as List<Map<String, Object>>).map(
                  (answer)=>Answer(
                    answerText: answer['answerText'].toString(),
                    answerColor: answer['score'] != null ? Colors.green : Colors.red,
                    answerTap: ()
                    {
                      // if answer selected othing happened on tap
                      if(answerWasSelected){
                        return;
                      };

                      _questionsAnswered(answer['score'] as bool);
                    },
            ),
            ),

                 ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize:  const Size(double.infinity, 40.0),

                ),


                onPressed: () {
                  if(!answerWasSelected){
                    ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('plz select an answer before going to next question'),)
                    );
                    return;
                  }
                  _nextquestion();
                }, child:  Text(endofquiz ?'Restart':'Next ques'))
            ,
            Container(
              padding:  const EdgeInsets.all(20.0),
              child:  Text('${_totalscore.toString()}/${_questions.length}',style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),
            ),
          ],

        ),
      ),
    );
  }
}




 //List<Map<String,dynamic>> _questions
  final _questions = [

      {
        'question': 'Physics Consider the nuclear fission\nNe(20) →2He(4) + C(12)\nGiven that the binding energy/ nucleon of Ne(20), He(4) and C(12) are 8.03 MeV, 7.07 MeV and 7.86 MeV respectively. Identify the correct statement.',

        'Answers' : [
          {
            'answerText': 'energy of 9.72 MeV has to be supplied','score': true},
          {'answerText': 'energy of 12.4 MeV will be supplied', 'score': false},
          {'answerText': '8.3 MeV energy will be released', 'score': false},

        ],
      },
      {
        'question': 'Physics\nIf the kinetic energy of an electron is increased four times, \nwavelength of the de-broglie wave associated with it would become',

        'Answers': [
          {'answerText': 'Two times', 'score': false},
          {'answerText': ' Half', 'score': true},

        ],
      },

  ];



