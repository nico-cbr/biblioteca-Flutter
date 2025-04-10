import 'dart:math';

import 'package:flutter/material.dart';

class verPosicao extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade900,
            blurRadius: 2,
            offset: Offset(0, 5)
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 20),
       child: Text("Sua posição na\ntela de espera:",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 38,
          fontWeight: FontWeight.bold
        ),
        ),
        ),
      Padding(padding: EdgeInsets.only(top:40, left:40),
      child: Text("12º", 
       style: TextStyle(
          color: Colors.black87,
          fontSize: 48,
          fontWeight: FontWeight.bold
        ),
      ),
       )
        ]
      ),

    );


  }
}