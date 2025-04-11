import 'package:flutter/material.dart';

class verPosicao extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
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
                      Text("Clique para ver sua posição na fila de espera.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700 ),),
                    ],
                  ),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      child: Text("Sua posição é: 12º",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500 )),
                    ),
                  SizedBox(height: 10)
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