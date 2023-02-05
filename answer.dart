import 'package:flutter/material.dart';
class Answer extends StatelessWidget {
  final String answerText;
  final Color answerColor;
  final Function answerTap;


  const Answer({super.key, required this.answerText,required this.answerColor,required this.answerTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: (){
        answerTap();
      },

      child: Container(
        padding:  const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: answerColor,
          border: Border.all(color:Colors.indigoAccent),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child:  Text(
          answerText,
          style:  const TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }

}
