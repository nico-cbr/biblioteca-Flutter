import 'package:flutter/material.dart';

// função principal que inicia o app
void main(){
  runApp(Aplicativo());
}
// criando minha classe própria
class Aplicativo extends StatelessWidget{
  
  // apenas para dar identidade ao aplicativo
  const Aplicativo({super.key});
  
  get widget => null;

  // @override vai dizer que vai sobrescrever a tela
  //build é widget que vai construir toda tela
  // MaterialApp é o que personaliza o tema
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.ac_unit_rounded, color:  Colors.blueGrey[800]),
          title: Text('Flutter é divertido!.', style: TextStyle(color: Colors.blueGrey[800]), ),
          backgroundColor: Colors.amber[50],
        ),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // Children serve para colocar varios widgets um atras do outro
            children: [ 
              Container(
             
              height: 200,
              width: 200,
              padding: EdgeInsets.only(top: 75),
              decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 30, 36, 39),
                 borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Text("Olá mundo!",  style: TextStyle(color: Colors.amber[50], fontSize: 30), textAlign: TextAlign.center,),
              ),

              Row(
                // tipo de espaçamento
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                // widget com filhos
                children: [
                  Icon(Icons.leaderboard, color: Colors.amber[50], size: 50),
                  Icon(Icons.person, color: Colors.amber[50], size: 50),

                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              FloatingActionButton(
                backgroundColor: Colors.amber[50],
                child: Icon(Icons.abc, color:  Colors.blueGrey[800], size: 40,),
                onPressed:() {
                  print("Parabens, funcionou!");
                },
              ),
              ],
              ),
            ]   
          )
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.construction_rounded), label:"Config"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label:"Escola"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label:"Buscar"),
        ]),

        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 30, 36, 39),
          child: ListView(
            padding: EdgeInsets.zero, //zerar padding
            children: [
              DrawerHeader(
                child: Text('Texto de Cabeçalho')
                ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Perfil"),
                onTap: () {print("entrou no perfil");},
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Página Inicial"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Configurações"),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}