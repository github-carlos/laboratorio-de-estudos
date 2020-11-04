import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signup');
            },
            child: Text('CRIAR CONTA', style: TextStyle(color: Colors.white, fontSize: 14),),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Consumer<UserManager>(builder: (_, userManager, __) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                      ),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (emailValid(email)) {
                          return null;
                        }
                        return 'E-mail invalido';
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                      ),
                      enabled: !userManager.loading,
                      autocorrect: false,
                      obscureText: true,
                      validator: (password) {
                        if (password.isEmpty || password.length < 6) {
                          return 'Senha invalida';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        child: Text('Esqueci minha senha'),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState.validate()) {
                                  final email = emailController.value.text;
                                  final password =
                                      passwordController.value.text;
                                  userManager.signIn(
                                      userData: UserData(email: email, password: password),
                                      onSuccess: () {
                                        print('sucesso');
                                      },
                                      onFail: (error) {
                                        scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text(error),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      });
                                }
                              },
                        child: userManager.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
