import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:navegacao/tela1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class TabelaPai extends StatefulWidget{

  @override
  Tabela createState() => Tabela();
}

class Tabela extends State<TabelaPai>{
  final List<Pessoa> pessoas = [];

  Future<void> excluirPessoa(String id) async{
    final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/pessoa/$id.json");
    final resposta = await http.delete(url);

    if(resposta.statusCode == 200){
      setState(() {
        pessoas.clear();
        buscarPessoas();
      });
    }
  }

@override  
void initState(){
  super.initState();
  buscarPessoas();
  }
  // Tabela({required this.pessoas})

  Future<void> buscarPessoas() async {
     final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/pessoa.json");
    final resposta = await http.get(url);
    // deecodificando o json
    final Map<String, dynamic> ? dados = jsonDecode(resposta.body);
    if(dados != null){
      dados.forEach((id, dadosPessoa){
        setState(() {
          Pessoa pessoaNova = Pessoa(
            id,
            dadosPessoa["nome"] ?? '',
            dadosPessoa["email"] ?? '',
            dadosPessoa["telefone"] ?? '',
            dadosPessoa["endereco"] ?? '',
            dadosPessoa["cidade"] ?? '',
          );
          pessoas.add(pessoaNova);
        });
      });
    }
  }

 Future<void> abrirWhats(String telefone) async {
  final Uri url = Uri.parse('https://wa.me/$telefone');
  if (!await launchUrl(url)){
    throw Exception('Não pode iniciar $url');
  }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de contatos", style: TextStyle(color: Colors.amber[50]),), 
        backgroundColor: Colors.indigo[900],

      ),
      body: Padding(padding: EdgeInsets.all(16.0),
       child: 
       ListView.builder(
        itemCount: pessoas.length, // quantidade de itens na lista
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.people_alt, color: Colors.indigo.shade900),
            title: Text(pessoas[index].nome, style: TextStyle(fontWeight: FontWeight.w900)),
            subtitle: Text(
              "Email: " + pessoas[index].email,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
            IconButton(onPressed: () => abrirWhats(pessoas[index].telefone), icon: Icon(Icons.message_outlined, color: Colors.indigo.shade900)),
            IconButton(onPressed: () => excluirPessoa(pessoas[index].id), icon: Icon(Icons.delete_outline_rounded, color: Colors.redAccent.shade700))

              ],
            ), 

          onTap:(){
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=>Detalhes(pessoas:pessoas)));
          } ,
          );
        },
       )
       )
    );
  }
}