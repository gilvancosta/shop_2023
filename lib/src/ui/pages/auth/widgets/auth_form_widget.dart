import 'package:flutter/material.dart';

enum AuthMode { signup, login }

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  AuthMode _authMode = AuthMode.login;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isloading = false;

  final Map<String, String> _authData = {'email': '', 'password': ''};

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;

  void _switchAuthMode() {
    if (_isLogin()) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  void _submit() {
    final isvalid = _formKey.currentState?.validate() ?? false;
    if (!isvalid) {
      return;
    }

    setState(() => _isloading = true);

    _formKey.currentState?.save();

    if (_isLogin()) {
      // Login
    } else {
      // Signup
    }

    setState(() => _isloading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.9,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (emailValue) {
                  final email = emailValue ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Informe um e-mail válido!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onSaved: (password) => _authData['email'] = password ?? '',
                validator: (passwordValue) {
                  final password = passwordValue ?? '';
                  if (password.trim().isEmpty || password.length >= 5) {
                    return 'Informe um e-mail válido!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_isSignup())
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: _isLogin()
                      ? null
                      : (password) {
                          if (password != _passwordController.text) {
                            return 'Senhas são diferentes!';
                          }
                          return null;
                        },
                ),
              const SizedBox(height: 20),
              if (_isloading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      // mudar a cor do botão para vermelho
                      backgroundColor: Colors.red, // Definindo a cor vermelha

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    ),
                    child: Text(
                      _isLogin() ? 'Entrar' : 'Cadastrar',
                    )),
              const Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _isLogin() ? 'Criar uma nova conta?' : 'Já possui uma conta?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
