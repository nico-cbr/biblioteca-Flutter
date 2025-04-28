// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_local_variable

import 'dart:convert';
import 'package:adotabr/wid/navBar.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// class Preconfiguracao extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//             theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white
//       ),
//       debugShowCheckedModeBanner: false,
//       home: Login(),
//     );
//   }
// }

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginEstado createState() => LoginEstado();
}

class LoginEstado extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FadeInImage(placeholder: AssetImage('assets/carregar.gif'), 
            // image: AssetImage('assets/foto.png'),
            // fadeInDuration: Duration(seconds: 3),
            // fadeOutDuration: Duration(seconds: 3),
            // width: 200,
            // ),
              Image.asset('assets/logo.png', width: 500,),
            SizedBox(
              height: 20,
            ),
            Text("Seja bem vindo ao Adota Brasil! Um aplicativo dedicado à facilitar o processo de adoção para os voluntários cadastrados.", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => navBar()),);},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800, // Cor de fundo
                foregroundColor: Colors.amber.shade50,  // Cor do texto
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0), // Espaçamento interno
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Borda arredondada
    ),
    elevation: 5.0, // Sombra do botão
              ),
  child: Text('Login com Gov.br', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
  ),
            SizedBox(
              height: 25,
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => CadastrarPostagem(Postagens: [],)));
            //   },
            //   child: Text('Não tem uma conta? Cadastre-se', style: TextStyle(color: Colors.grey.shade900),),
            // ),
          ],
        ),
      ),
    );
  }
}

class Postagem{
String id;
String titulo;
String data;
String conteudo;
String imagem;
String autor;


Postagem(this.id, this.titulo,this.data,this.conteudo, this.imagem, this.autor);
}

class CadastrarPostagem extends StatefulWidget{
    final List<Postagem> Postagens;
  // cadastro vai receber Orfanatos
  CadastrarPostagem({required this.Postagens});
  
  @override
  CadastrarPostagemEstado createState() => CadastrarPostagemEstado();
}

class CadastrarPostagemEstado extends State<CadastrarPostagem>{

  final autorControle = TextEditingController();
  final tituloControle = TextEditingController();
  final dataControle = TextEditingController();
  final conteudoControle = TextEditingController();
  final imagemControle = TextEditingController();

  // criando metodo de cadastro
  Future<void> cadastrarPostagem(Postagem Postagem) async {
    if(Postagem.titulo.isNotEmpty && Postagem.conteudo.isNotEmpty){
    final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/Postagem.json");
    final resposta = await http.post(url, body: jsonEncode({
      "titulo": Postagem.titulo,
      "data": Postagem.data,
      "conteudo": Postagem.conteudo,
      "imagem": Postagem.imagem,
      "autor": Postagem.autor
      }));
    }

  }

  @override
  Widget build(BuildContext context){
    // constra o formulario de cadastro de postagem

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de postagens", style: TextStyle(color: Colors.amber[50]),),
         backgroundColor: Colors.indigo[900],
      ),
      body: Padding(padding: EdgeInsets.all(26.0),
    child: Column(
      children: [
        Text("Cadastro de postagens", style: TextStyle(fontSize: 30)),
        SizedBox(
              height: 20,
            ),
                TextField(controller: autorControle, decoration: InputDecoration(labelText:"titulo da postagem", 
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.title_rounded),
        prefixIconColor: Colors.grey,
        ),),
        SizedBox(
              height: 20,
            ),
        TextField(controller: tituloControle, decoration: InputDecoration(labelText:"titulo da postagem", 
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.title_rounded),
        prefixIconColor: Colors.grey,
        ),),
        SizedBox(
              height: 20,
            ),

        TextField(controller: dataControle, decoration: InputDecoration(labelText:"data da postagem",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_month_outlined),
        prefixIconColor: Colors.grey,
        ),),
        SizedBox(
              height: 20,
            ),

        TextField(controller: conteudoControle, decoration: InputDecoration(labelText:"Conteudo da postagem",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.keyboard_alt_outlined),
        prefixIconColor: Colors.grey,
        ),
        maxLines: 4,),
        SizedBox(height: 20,),

        TextField(controller: imagemControle, decoration: InputDecoration(labelText:"Imagem da postagem",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.image_outlined),
        prefixIconColor: Colors.grey,
        ),),
        SizedBox(height: 20,),

        ElevatedButton(onPressed: (){
          setState(() {
            Postagem PostagemNova = Postagem(
              autorControle.text,
              tituloControle.text,
              dataControle.text,
              conteudoControle.text,
              imagemControle.text,
              ""
            );
            widget.Postagens.add(PostagemNova);
            cadastrarPostagem(PostagemNova);
            autorControle.clear();
            tituloControle.clear();
            dataControle.clear();
            conteudoControle.clear();
            imagemControle.clear();
          });
        },style: ElevatedButton.styleFrom(foregroundColor: Colors.amber.shade50, backgroundColor: Colors.indigo.shade900,  ),child: Text("salvar")),
      ],
    ),
    ),
    );
  }
}