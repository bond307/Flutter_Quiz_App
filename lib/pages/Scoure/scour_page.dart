import 'package:flutter/material.dart';
import 'package:quiz/pages/home.dart';

class ScourePage extends StatelessWidget {
final int result;
ScourePage({required this.result});

  @override
  Widget build(BuildContext context) {
    print(result);
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 148, 9),
        title: const Text("Question answer"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${result}/10", style: TextStyle(fontSize: 25, color: Colors.white),),
            SizedBox(height: 20,),
            LinearProgressIndicator(
              minHeight: 10,
              value: result / 10,
              semanticsValue: "25",
              valueColor: AlwaysStoppedAnimation<Color>(
               result <= 4 ? Colors.redAccent : result <= 10 ? Colors.greenAccent : Colors.black,
              ),
            ),
            SizedBox(height: 20,),
            Text("Your Scour is: ${result}/10", style: TextStyle(fontSize: 25, color: Colors.white),),
            SizedBox(height: 50,),
            //if result lass then or == 4 then show this container.
            result <= 4 ? Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Text("Sorry..! You are Fail!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
            ) : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/celebration2.gif", fit: BoxFit.cover, height: 200, width: MediaQuery.of(context).size.width,),

                  Positioned( top: 80, left: 70, child: Text("Congratulations!", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)),
                ],
              ),
            ),
            SizedBox(height: 50,),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
              color: Colors.white,
              child: Text("Go to home page"),

            ),


          ],
        ),
      ),

    );
  }
}

