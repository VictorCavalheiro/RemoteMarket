import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_market/Models/UserModel.dart';
import 'package:simple_market/UI/Register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text(
                  "Criar conta",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                    validator: (value) {
                      if (value.isEmpty || !value.contains("@")) {
                        return "Email invalido";
                      }
                    },
                  ),
                  TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) {
                          return "Senha invalida";
                        }
                      }),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(

                        padding: EdgeInsets.zero,
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          if(_emailController.text.isEmpty){
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Preencha seu email"),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 3)));



                          }
                          else{
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Verifique seu email"),
                                backgroundColor: Colors.greenAccent,
                                duration: Duration(seconds: 3)));

                            _emailController.text="";
                            _passwordController.text="";
                            model.recoveryPassword(_emailController.text);
                          }
                        }),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                      height: 44.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userData = {
                              "email": _emailController.text,
                            };
                            model.signIn(
                                userData: userData,
                                pass: _passwordController.text,
                                onSuccess: onSuccess,
                                onFail: onFail);
                          }
                        },
                        child: Text("Entrar",
                            style: TextStyle(color: Colors.white)),
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              ));
        }));
  }

  void onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Credenciais inválidas!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3)));

    _emailController.text = "";
    _passwordController.text = "";
  }

  void onSuccess() {
    Navigator.of(context).pop();
  }
}
