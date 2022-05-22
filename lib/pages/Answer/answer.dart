import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  late String QusetionAnswer;
  final Color? AnsColor;
  final VoidCallback  answerTap;
  final bool answerTaped;

  Answer({
    required this.QusetionAnswer,
    this.AnsColor,
     required this.answerTap,
    required this.answerTaped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 10),
          GestureDetector(
            onTap: answerTaped ? null: answerTap,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:AnsColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(QusetionAnswer),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
