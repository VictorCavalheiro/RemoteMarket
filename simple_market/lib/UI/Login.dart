import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_market/Models/UserModel.dart';
import 'package:simple_market/UI/Register.dart';

class Login extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Register())
                  );
                },
                child: Text(
                  "Criar conta",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: ScopedModelDescendant<UserModel>(builder: (context,child,model){
            if(model.isLoading){
              return Center(child:CircularProgressIndicator());
            }
            return Form(
                key: key,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (value) {
                        if (value.isEmpty || !value.contains("@")) {
                          return "Email invalido";
                        }
                      },
                    ),
                    TextFormField(

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
                          onPressed: () {}),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (key.currentState.validate()) {

                            }
                            model.signIn();
                          },
                          child: Text(
                              "Entrar", style: TextStyle(color: Colors.white)),
                          color: Theme
                              .of(context)
                              .primaryColor,
                        ))
                  ],
                ));
        }));
  }
}
