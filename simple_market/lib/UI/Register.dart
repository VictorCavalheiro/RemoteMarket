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

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(title: Text("Sign up"), centerTitle: true),
        body: ScopedModelDescendant<UserModel>(builder: (context,child,model){
          if(model.isLoading){
            return Center(child:CircularProgressIndicator());
          }
          return Form(key: _formKey,
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
                    controller: _emailController
                ),
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
                    onPressed: (){
                      if(_formKey.currentState.validate()){

                        Map<String,dynamic> userData = {
                          "name":_nameController.text,
                          "email":_emailController.text
                        };

                        model.signUp(userData: userData,
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

  void onSucess(){

  }

  void onFail(){

  }
}


