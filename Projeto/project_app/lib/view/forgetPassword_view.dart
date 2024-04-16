import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_app/model/login.dart';
 
class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});
 
  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}
 
class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  var formkey = GlobalKey<FormState>();
 
  // Controlador dos textbox
  var txtlogin = TextEditingController();
  var txtsenha = TextEditingController();
  var txtNovaSenha = TextEditingController();
  var txtConfirmaSenha = TextEditingController();

 
  // Ocultar - Mostrar senha
  bool _isObscure = true;
  bool _isObscure2 = true;


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

            Text('Esqueceu Senha',style: TextStyle(fontSize: 20),),

             SizedBox(height: 20,),
              //Textfield login
 
              TextFormField(
                controller: txtlogin,
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
                  labelText: 'Senha atual',
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
                    return 'Insira uma senha!';
                  }
                  else if(value.isEmpty){
                    return 'Insira uma senha!';
                  }
 
                  return null;
                },
              ),

              //Textfield senha
 
              SizedBox(height: 20),
              
              TextFormField(
                controller: txtNovaSenha,
                style: TextStyle(fontSize: 18),
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Nova senha',
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
                    return 'Insira uma senha!';
                  }
                  else if(value.isEmpty){
                    return 'Insira uma senha!';
                  }
 
                  return null;
                },
              ),

               SizedBox(height: 20),
              TextFormField(
                controller: txtConfirmaSenha,
                style: TextStyle(fontSize: 18),
                obscureText: _isObscure2,
                decoration: InputDecoration(
                  labelText: 'Confirme nova senha',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure2 = !_isObscure2;
                      });
                    },
                  )
                ),
 
                validator: (value){
                  if(value == null){
                    return 'Insira uma senha!';
                  }
                  else if(value.isEmpty){
                    return 'Insira uma senha!';
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
                onPressed: () {
                  if(txtNovaSenha == txtConfirmaSenha){
                    if (formkey.currentState!.validate()) {
                      String email = txtlogin.text;
                      String senha = txtsenha.text;
                      Login novoLogin = Login(email: email, senha: senha);
                      
                      bool loginEncontrado = false;
                      for (int i = 0; i < Logins.length; i++) {
                        if (Logins[i].email == email) {
                          loginEncontrado = true;
                          // Atualizar a senha do login encontrado
                          Logins[i].senha = txtNovaSenha.text;
                          break;
                        }
                      }
                      
                      if (loginEncontrado) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Senha trocada com sucesso'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login não encontrado'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Senhas não são iguais'),
                            duration: Duration(seconds: 2),
                          ),
                    );
                  }
                },

                child: Text('Redefinir Senha', style: TextStyle(color: Colors.white),),
              ),
        ]),
      )
      )
    );
  }
}