import 'package:flutter/material.dart';
import 'package:navegacao/tela1.dart';
import 'package:url_launcher/url_launcher.dart';

class Detalhes extends StatelessWidget{
  final Orfanato orfanato;

  // passando parâmetro da orfanato especifica
  Detalhes({required this.orfanato});

  ligar(String telefone) async{
    final Uri telefoneUrl = Uri(scheme: "tel", path: telefone);
    if(await canLaunchUrl(telefoneUrl)){
      await launchUrl(telefoneUrl);
    }
  }

mandarE(String email) async{
    final Uri emailUrl = Uri(scheme: "mailto", path: email);
    if(await canLaunchUrl(emailUrl)){
      await launchUrl(emailUrl);
    }
  }

mandarW(String telefone) async{
    final Uri whatsUrl = Uri.parse("https://wa.me/$telefone");
    if(await canLaunchUrl(whatsUrl)){
      await launchUrl(whatsUrl);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes do contato", style: TextStyle(color: Colors.amber.shade50),),
      backgroundColor: Colors.indigo.shade900,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Icon(Icons.person, size: 100, color: Colors.indigo.shade600 ),
              SizedBox(height: 20),
              Text(orfanato.nome, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("Nome: ${orfanato.nome}", style: TextStyle(fontSize: 18)),
              Text("Cnpj: ${orfanato.cnpj}", style: TextStyle(fontSize: 18)),
              Text("Email: ${orfanato.email}", style: TextStyle(fontSize: 18)),
              Text("Telefone: ${orfanato.telefone}", style: TextStyle(fontSize: 18)),
              Text("Endereço: ${orfanato.endereco}", style: TextStyle(fontSize: 18)),
              Text("Cidade: ${orfanato.cidade}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 30,),
              Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(onPressed: () => ligar(orfanato.telefone), icon: Icon(Icons.phone), label: Text("Ligar"), style: ElevatedButton.styleFrom(foregroundColor: Colors.amber.shade50, backgroundColor: Colors.indigo.shade900,  ), ),
                  SizedBox(width: 10,),
                  ElevatedButton.icon(onPressed: () => mandarE(orfanato.email), icon: Icon(Icons.email), label: Text("E-mail"), style: ElevatedButton.styleFrom(foregroundColor: Colors.amber.shade50, backgroundColor: Colors.indigo.shade900,  ),),
                  SizedBox(width: 10,),
                  ElevatedButton.icon(onPressed: () => mandarW(orfanato.telefone), icon: Icon(Icons.phone_iphone), label: Text("Whatsapp"), style: ElevatedButton.styleFrom(foregroundColor: Colors.amber.shade50, backgroundColor: Colors.indigo.shade900,  ),),
                  SizedBox(width: 10,)
                ],
              )
            ],
          ),
        ),
      )
    );
  }}