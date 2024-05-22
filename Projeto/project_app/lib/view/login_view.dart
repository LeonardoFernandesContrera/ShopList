// ignore_for_file: prefer_const_constructors
 
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:project_app/model/login.dart';
 
class LoginView extends StatefulWidget {
  const LoginView({super.key});
 
  @override
  State<LoginView> createState() => _LoginViewState();
}
 
class _LoginViewState extends State<LoginView> {
 
  var formkey = GlobalKey<FormState>();
 
  var txtlogin = TextEditingController();
  var txtsenha = TextEditingController();
 
  bool _isObscure = true;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopList', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue.shade500,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Form(
          key: formkey,
          child: Column(
            children: [

              SizedBox(
                child: 
                  Image.network('https://static.vecteezy.com/system/resources/previews/000/355/589/original/vector-shopping-cart-icon.jpg'),
                height: 150,
                width: 150,
              ),
             
             SizedBox(height: 20,),

            Text('Login',style: TextStyle(fontSize: 20),),

             SizedBox(height: 20,),

              TextFormField(
                controller: txtlogin,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Login',
                  prefixIcon: Icon(Icons.account_circle),
                ),
 
                validator: (value){
                  if(EmailValidator.validate(value.toString())){
                    if(Logins.contains(value))
                    return null;
                  }
                  else{
                    return "Informe um email correto";
                  }
                   
                },
              ),
 
              SizedBox(height: 20),
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

              SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(200, 50),
                  shadowColor: Colors.black,
                ),
                onPressed: (){
                if(formkey.currentState!.validate()){
                  String email = txtlogin.text;
                  String senha = txtsenha.text;
                  Login login = Login(email: email, senha: senha);
                  
                  bool loginEncontrado = false;
                  for (Login l in Logins) {
                    if (l.email == login.email && l.senha == login.senha) {
                      loginEncontrado = true;
                      break;
                    }
                  }
                  
                  if (loginEncontrado) {
                    Navigator.pushNamed(
                      context,
                      'shopList_view',
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login ou senha incorretos'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
                },
                child: Text('Login', style: TextStyle(color: Colors.white),),
              ),

              SizedBox(height: 20,),

              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Esqueceu a senha, clique'),
                    TextButton(
                      onPressed: (){Navigator.pushNamed(context, 'forgetPassword_view');}, child: Text('aqui')),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Não possui login? registre-se'),
                    TextButton(
                      onPressed: (){Navigator.pushNamed(context, 'register_view');}, child: Text('aqui')),
                  ],
                ),
              ),
            ],
          )
        )
      )
    );
  }
}