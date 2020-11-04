import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onSaved: (name) => userData.name = name,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    if (email.isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    if (emailValid(email)) {
                      return null;
                    }
                    return 'E-mail invalido';
                  },
                  onSaved: (email) => userData.email = email,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (password) {
                    if (password.isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    if (password.length < 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (password) => userData.password = password,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Repita a Senha'),
                  obscureText: true,
                  validator: (password) {
                    if (password.isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    if (password.length < 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (confirmPassword) =>
                      userData.confirmPassword = confirmPassword,
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        if (userData.password != userData.confirmPassword) {
                          showError('Senhas nao coincidem');
                        }
                        // user manager
                        context.read<UserManager>().signUp(
                            userData: userData,
                            onFail: (message) {
                              showError(message);
                            },
                            onSuccess: (message) {
                              print('sucesso');
                            });
                      }
                    },
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showError(String message) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
