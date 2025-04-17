// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class verProgresso extends StatelessWidget {
  const verProgresso({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     child: Padding(padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
     child: Column(
      children: [
        Center(
        child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
           child: Padding(padding: EdgeInsets.all(20),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Progresso do curso psicossocial", style:  TextStyle(fontSize: 22, color: Colors.grey.shade900, fontWeight: FontWeight.w500),),
              SizedBox(
                height: 15,
              ),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child:LinearProgressIndicator(value: 100, color: Colors.green.shade600, minHeight: 20, borderRadius: BorderRadius.circular(10),semanticsLabel: "Progresso da avaliação psicossocial",),),
                SizedBox(width: 20,),
                Text("100%", style: TextStyle(fontSize: 18),),
                SizedBox(width: 20,),
              ],
             ),
              SizedBox(height: 40           ,),
            Text("Progresso da avaliação psicossocial", style:  TextStyle(fontSize: 22, color: Colors.grey.shade900, fontWeight: FontWeight.w500),),
              SizedBox(
                height: 15,
              ),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child:LinearProgressIndicator(value: 100, color: Colors.green.shade600, minHeight: 20, borderRadius: BorderRadius.circular(10),semanticsLabel: "Progresso da avaliação psicossocial",),),
                SizedBox(width: 20,),
                Text("100%", style: TextStyle(fontSize: 18),),
                SizedBox(width: 20,),
              ],
             ),
            SizedBox(height: 10,)
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