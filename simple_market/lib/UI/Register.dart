import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_market/Models/UserModel.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKeyRegister = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("Sign up"), centerTitle: true),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formKeyRegister,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: "Name"),
                  controller: _nameController,
                ),
                Divider(),
                TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return "Erro";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                    controller: _emailController),
                Divider(),
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Erro";
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Senha"),
                  controller: _passwordController,
                ),
                SizedBox(height: 30.0),
                SizedBox(
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKeyRegister.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passwordController.text,
                            onFail: onFail,
                            onSuccess: onSucess);
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Registrar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }

  void onSucess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Usuario criado com sucesso!"),
        backgroundColor: Colors.greenAccent,
        duration: Duration(seconds: 3)));
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.of(context).pop();
    });
  }

  void onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Credenciais inválidas!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3)));
    _nameController.text="";
    _emailController.text="";
    _passwordController.text="";
  }
}
