import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:navegacao/Detalhes.dart';
import 'package:navegacao/tela1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class TabelaPai extends StatefulWidget{

  @override
  Tabela createState() => Tabela();
}

class Tabela extends State<TabelaPai>{
  final List<Orfanato> orfanatos = [];

  Future<void> excluirOrfanato(String id) async{
    final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/Orfanato/$id.json");
    final resposta = await http.delete(url);

    if(resposta.statusCode == 200){
      setState(() {
        orfanatos.clear();
        buscarOrfanatos();
      });
    }
  }

@override  
void initState(){
  super.initState();
  buscarOrfanatos();
  }
  // Tabela({required this.orfanatos})

  Future<void> buscarOrfanatos() async {
     final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/Orfanato.json");
    final resposta = await http.get(url);
    // deecodificando o json
    final Map<String, dynamic> ? dados = jsonDecode(resposta.body);
    if(dados != null){
      dados.forEach((id, dadosOrfanato){
        setState(() {
          Orfanato pessoaNova = Orfanato(
            id,
            dadosOrfanato["nome"] ?? '',
            dadosOrfanato["cnpj"] ?? '',
            dadosOrfanato["email"] ?? '',
            dadosOrfanato["telefone"] ?? '',
            dadosOrfanato["endereco"] ?? '',
            dadosOrfanato["cidade"] ?? '',
          );
          orfanatos.add(pessoaNova);
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
        itemCount: orfanatos.length, // quantidade de itens na lista
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.people_alt, color: Colors.indigo.shade900),
            title: Text(orfanatos[index].nome, style: TextStyle(fontWeight: FontWeight.w900)),
            subtitle: Text(
              "Email: " + orfanatos[index].email,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
            IconButton(onPressed: () => abrirWhats(orfanatos[index].telefone), icon: Icon(Icons.message_outlined, color: Colors.indigo.shade900)),
            IconButton(onPressed: () => excluirOrfanato(orfanatos[index].id), icon: Icon(Icons.delete_outline_rounded, color: Colors.redAccent.shade700))

              ],
            ), 
          // quando clicar no item da lista (onTap)
          onTap:(){
            Navigator.push(context,
            MaterialPageRoute(builder: (context)=>Detalhes(orfanato:orfanatos[index])));
          } ,
          );
        },
       )
       )
    );
  }
}