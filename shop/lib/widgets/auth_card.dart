import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();

  AnimationController _controller;
  Animation<Size> _heightAnimation;

  // @override
  // void initState() {
  //   super.initState();

  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(
  //       milliseconds: 300
  //     )
  //   );

  //   _heightAnimation = Tween(
  //     begin: Size(double.infinity, 290),
  //     end: Size(double.infinity, 371),
  //   ).animate(
  //     CurvedAnimation(
  //       parent: _controller,
  //       curve: Curves.linear
  //     )
  //   );

  //   _heightAnimation.addListener(() {
  //     setState(() {});
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Map<String, String> _authData = {
    'email': '',
    'password': ''
  };

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('FECHAR'),
          )
        ],
      )
    );
  }

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState.save();

    Auth auth = Provider.of(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await auth.login(_authData['email'], _authData['password']);
      } else {
        await auth.signup(_authData['email'], _authData['password']);
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado.');
    }
    

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    setState(() {
      if (_authMode == AuthMode.Login) {
        _authMode = AuthMode.Signup;
        // _controller.forward();
      } else {
        _authMode = AuthMode.Login;
        // _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.decelerate,
        height: _authMode == AuthMode.Login ? 290 : 372,
        //height: _heightAnimation.value.height,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Informe um e-mail válido';
                  }

                  return null;
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Informe uma senha válida';
                  }

                  return null;
                },
                onSaved: (value) => _authData['password'] = value,
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirmar senha'),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup ? (value) {
                    if (value != _passwordController.text) {
                      return 'As senhas são diferentes';
                    }

                    return null;
                  } : null,
                ),
              Spacer(),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 8.0
                    )
                  ),   
                  child: Text(
                    _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR'
                  ),
                  onPressed: _submit,
                ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  'ALTERNAR PARA ${_authMode == AuthMode.Login ? 'REGISTRAR' : 'LOGIN'}'
                ),
              )
            ],
          ),
        )
      )
    );
  }
}