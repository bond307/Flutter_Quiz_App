import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/pages/Answer/answer.dart';

import '../qustion/qustion.dart';
import 'Scoure/scour_page.dart';
// ignore: unused_import

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names
  AllQustion _allQustion = new AllQustion();

  //local variable
  int qestionIndex = 0;
  int totalResult = 0;
  bool ansWasSelected = false;
  bool ansWasTaped = false;
  final List answerScor = [];
  bool startQuze = false;


  // when user start quiz
  void StartQuze(){
    setState(() {
      startQuze = true;
    });
  }

  //Answer Action function//
  void AnsQusSubmit(){
    setState(() {
      startQuze = true;
      ansWasSelected = false;
      qestionIndex++;
      if(qestionIndex == _allQustion.questions.length){
        List answerScor = [];
        qestionIndex=0;
        //Welcome();
        startQuze = false;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ScourePage(
               result: totalResult,
            )));
      }
    });
  }

  void _QuestionWasSelected(bool rightAns){
      setState(() {
        //ans pick ture
        ansWasSelected = true;
        //add right and wrng icon in top

        answerScor.add(
            rightAns ? Icon(
              Icons.check_circle,
              color: Colors.green,
            ):
          Icon(
            Icons.clear,
            color: Colors.redAccent,
          ),
        );

        ///// Total score count with right ans////
        if(rightAns){
          totalResult++;
        }
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 148, 9),
        title: const Text("Flutter Quiz System "),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------- Start container ---------//
            Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                height: 130,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(300)),
                  color: Color.fromARGB(255, 4, 148, 9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Quze",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "আপনি মোট ১০ টি প্রশ্ন পাবেন, সেখান থেকে আপনার ৮ টী সঠিক উত্তর দিতে হবে। ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                )),
            //----- End container ------------//


            // quiz section -------------------//
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 25, bottom: 30),
              child: Column(children: [

                //live scour show by icons
                GestureDetector(
                  onTap: ()=>StartQuze(),
                  child: Container(
                    height: 35,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.green
                        )
                    ),

                    //if quiz is start then show scour
                    child: startQuze ? Row(
                      children: [
                        if(answerScor.length > 0 )
                          ...answerScor,
                      ],
                    ):Text("Start Quze Now", style: TextStyle(color: Colors.green),),
                  ),
                ),
                const SizedBox(height: 15,),
                //Show question /////////
                startQuze ? Column(
                  children: [

                    //show all question form question/wustion.dart
                    Container(
                   width: MediaQuery.of(context).size.width,
                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                   decoration: BoxDecoration(
                     color: Color.fromARGB(255, 4, 148, 9),
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Qus. ${qestionIndex + 1}/${_allQustion.questions.length}: ",
                               style: TextStyle(
                                 fontSize: 25,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.white,),
                           ),
                           GestureDetector(
                             onTap: (){
                               setState(() {
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context) => HomePage()));
                               });
                             },
                             child: Container(
                               padding: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(100),
                               ),
                               child: Text("Cancle", style: TextStyle(color: Colors.red),),
                             ),
                           ),
                         ],
                       ),

                       SizedBox(height: 10),
                       Text("${_allQustion.questions[qestionIndex]['questions']}",
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.w500,
                             color: Colors.white,
                           )),
                     ],
                   ),
                 ),

                 ///Show answer //////////////////////////////////
                 ...(_allQustion.questions[qestionIndex]["answer"]
                 as List<Map<String, dynamic>>)
                     .map((answers) => Answer(
                   QusetionAnswer: answers["ansterText"],
                    answerTaped :ansWasSelected,
                   AnsColor: ansWasSelected ? answers['rightAns']? Color(0xFFAAFDAE): Color(0xFFFF3747):null,
                   answerTap: (){
                     _QuestionWasSelected(answers["rightAns"]);
                   },
                 ),
                 ),

                 ///End show answer //////////////////////////////////
                 ///
                 ///
                 const SizedBox(height: 20),
                 // next ans button
                 RaisedButton(
                   onPressed: () {
                     //check, question is selected ot not.
                     ansWasSelected ?
                     AnsQusSubmit(): ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text('প্রশ্নের উত্তর দিতে হবে। '),
                       backgroundColor: Colors.red,
                     ));
                   },
                   color: Color.fromARGB(255, 4, 148, 9),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Next Qustion",
                           style: TextStyle(color: Colors.white)),
                       Icon(Icons.arrow_forward_outlined, color: Colors.white),
                     ],
                   ),
                 ),
               ],)

                    : Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                      color: Color(0xFFFE5620),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Waiting for start quize",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                        ),
                      ),
              ]),
            ),

           // Welcome(),
          ],
        ),
      ),
    );
  }
}

