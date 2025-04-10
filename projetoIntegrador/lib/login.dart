import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:navegacao/main.dart';

void main() {
  runApp(Preconfiguracao());
}

class Preconfiguracao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Aplicativo(nomeUsuario: 'Usuário')),);},
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
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cadastro()));
              },
              child: Text('Não tem uma conta? Cadastre-se', style: TextStyle(color: Colors.grey.shade900),),
            ),
          ],
        ),
      ),
    );
  }
}

class Cadastro extends StatefulWidget {
  @override
  CadastroEstado createState() => CadastroEstado();
}

class CadastroEstado extends State<Cadastro> {
  final nomeControle = TextEditingController();
  final emailControle = TextEditingController();
  final senhaControle = TextEditingController();
  bool estaCarregando = false;
  bool ocultado = true;

  Future<void> cadastrar() async {
    setState(() {
      estaCarregando = true;
    });

    final nome = nomeControle.text;
    final email = emailControle.text;
    final senha = senhaControle.text;

    final url = Uri.parse(
        'https://finan-4854e-default-rtdb.firebaseio.com/usuario.json');
    final resposta = await http.post(
      url,
      body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
      headers: {'Content-Type': 'aplication/json'},
    );
    if (resposta.statusCode == 200) {
      Navigator.pop(context);
    } else {
      erro = "Erro ao cadastrar usuário";
    }
    setState(() {
      estaCarregando = false;
    });
  }

  String erro = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crie sua Conta'),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.perm_contact_calendar,
              size: 100,
              color: Colors.indigo.shade900,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: nomeControle,
              decoration: InputDecoration(
                labelText: 'Seu nome',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo.shade900, width: 2.0)
                ),
                prefixIcon: Icon(Icons.person_2_rounded),
                prefixIconColor: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailControle,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo.shade900, width: 2.0)
                ),
                prefixIcon: Icon(Icons.email_rounded),
                prefixIconColor: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: senhaControle,
              obscureText: ocultado,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo.shade900, width: 2.0)
                ),
                prefixIcon: Icon(Icons.lock_rounded),
                prefixIconColor: Colors.grey,
                suffixIcon: IconButton(
                  icon:
                      Icon(ocultado ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      ocultado = !ocultado;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            estaCarregando
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: cadastrar,
                    child: Text('Cadastrar', style: TextStyle(color: Colors.indigo.shade900),),
                  ),
            erro.isNotEmpty
                ? Text(erro, style: TextStyle(color: Colors.red))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
