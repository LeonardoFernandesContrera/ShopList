import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:project_app/model/login.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  var formkey = GlobalKey<FormState>();
 
  // Controlador dos textbox
  var txtregister = TextEditingController();
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

              // Adicionando imagens

              SizedBox(
                child: 
                  Image.network('https://static.vecteezy.com/system/resources/previews/000/355/589/original/vector-shopping-cart-icon.jpg'),
                height: 150,
                width: 150,
              ),
             
             SizedBox(height: 20,),

            Text('Registro',style: TextStyle(fontSize: 20),),

             SizedBox(height: 20,),
              //Textfield login
 
              TextFormField(
                controller: txtregister,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.account_circle),
                ),
 
                validator: (value){
                  if(EmailValidator.validate(value.toString())){
                    return null;
                  }
                  else{
                    return "Informe um email valido";
                  }
                   
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
                    return 'Insira uma senha valida!';
                  }
                  else if(value.isEmpty){
                    return 'Insira uma senha valida!';
                  }
 
                  return null;
                },
              ),

              // Login button

              SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(200, 50),
                  shadowColor: Colors.black,
                ),
                // onPressed: (){
                //   if(formkey.currentState!.validate()){
                //     Navigator.pushNamed(
                //       context,
                //       'shopList_view',
                //     );
                //   }
                // },
                onPressed: (){
                if(formkey.currentState!.validate()){
                  String email = txtregister.text;
                  String senha = txtsenha.text;
                  Login login = Login(email: email, senha: senha);
                  
                  bool loginEncontrado = false;
                  for (Login l in Logins) {
                    if (l.email == login.email && l.senha == login.senha) {
                      loginEncontrado = false;
                      break;
                    }
                  }
                  
                  if (loginEncontrado == false) {
                    Logins.add(login);
                    Navigator.pushNamed(
                      context,
                      'login_view',
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login já existente'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
                },
                child: Text('Registrar-se', style: TextStyle(color: Colors.white),),
              ),

              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}