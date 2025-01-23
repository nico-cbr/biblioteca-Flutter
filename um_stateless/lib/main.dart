import 'package:flutter/material.dart';

// função principal que inicia o app
void main(){
  runApp(Aplicativo());
}
// criando minha classe própria
class Aplicativo extends StatelessWidget{
  
  // apenas para dar identidade ao aplicativo
  const Aplicativo({super.key});

  // @override vai dizer que vai sobrescrever a tela
  //build é widget que vai construir toda tela
  // MaterialApp é o que personaliza o tema
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.ac_unit_rounded, color:  Colors.blueGrey[800]),
          title: Text('Flutter é divertido!.', style: TextStyle(color: Colors.blueGrey[800]), ),
          backgroundColor: Colors.amber[50],
        ),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Children serve para colocar varios widgets um atras do outro
            children: [ 
              Container(
              color: const Color.fromARGB(255, 30, 36, 39),
              height: 200,
              width: 200,
              padding: EdgeInsets.only(top: 75),
              child: Text("Olá mundo!",  style: TextStyle(color: Colors.amber[50], fontSize: 30), textAlign: TextAlign.center,),
              )
            ]   
          )
        ),
      ),
    );
  }
}