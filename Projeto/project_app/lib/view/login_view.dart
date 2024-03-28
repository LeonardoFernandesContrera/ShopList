// ignore_for_file: prefer_const_constructors
 
import 'package:flutter/material.dart';
 
class LoginView extends StatefulWidget {
  const LoginView({super.key});
 
  @override
  State<LoginView> createState() => _LoginViewState();
}
 
class _LoginViewState extends State<LoginView> {
 
  // Chave identificador Form
  var formkey = GlobalKey<FormState>();
 
  // Controlador dos textbox
  var txtlogin = TextEditingController();
  var txtsenha = TextEditingController();
 
  // Ocultar - Mostrar senha
  bool _isObscure = true;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Form(
          key: formkey,
          child: Column(
            children: [

              // Adicionando imagens

              Image.asset(
                'lib/imagens/carrinho.png',
                width: 200,
                height: 200,
              ),
             
              //Textfield login
 
              TextFormField(
                controller: txtlogin,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Login',
                  prefixIcon: Icon(Icons.account_circle),
                ),
 
                validator: (value){
                  if(value == null){
                    return 'Informe o login!';
                  }
                  else if(value.isEmpty){
                    return 'Informe o login!';
                  }
                   
                  return null;
                },
              ),

              //Textfield senha
 
              SizedBox(height: 30),
              TextFormField(
                controller: txtsenha,
                style: TextStyle(fontSize: 18),
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                ),
 
                validator: (value){
                  if(value == null){
                    return 'Insira sua senha!';
                  }
                  else if(value.isEmpty){
                    return 'Insira sua senha!';
                  }
 
                  return null;
                },
              ),

              // Login button

              SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.green.shade900,
                  minimumSize: Size(200, 50),
                  shadowColor: Colors.red,
                ),
                onPressed: (){
                  if(formkey.currentState!.validate()){
                    Navigator.pushNamed(
                      context,
                      'main_view',
                    );
                  }
                },
                child: Text('Login'),
              )

            ],
          )
        )
      )
    );
  }
}