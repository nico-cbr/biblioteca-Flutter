import 'package:flutter/material.dart';

// ignore: camel_case_types
class verPosicao extends StatelessWidget{
  const verPosicao({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  expansionAnimationStyle: AnimationStyle(curve: Easing.standardAccelerate,
                  reverseCurve: Easing.standardAccelerate,
                  duration: Duration(milliseconds: 500 )
                  ),

                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),

                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                      child: Text("Clique para ver sua posição na fila de espera.", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700 ),),
                      )
                    ],
                  ),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                      child: Text("Sua posição é: 12º",style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500 )),
                    ),
                  SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}