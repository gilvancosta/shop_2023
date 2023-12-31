import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/exceptions/auth_exception.dart';
import '../../../../domain/controllers/auth/auth_controller.dart';

enum AuthMode { signup, login }

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.login;

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  final Map<String, String> _authData = {'email': '', 'password': ''};

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    ));

    // _heightAnimation!.addListener(() => setState(() {}));

    super.initState();
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
        _controller!.forward();
      } else {
        _authMode = AuthMode.login;
        _controller!.reverse();
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreo um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    AuthController auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        // Login
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Registrar
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 360 : 400,
        // height: _heightAnimation!.value.height,
        width: deviceSize.width * 0.8,

        child: Form(
          key: _formKey,
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
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: _passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (passwordValue) {
                  final password = passwordValue ?? '';
                  if (password.isEmpty || password.length < 5) {
                    return 'Informe uma senha válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isSignup() ? 60 : 0,
                  maxHeight: _isSignup() ? 120 : 0,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
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
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      // mudar a cor do botão para vermelho
                      backgroundColor: Colors.deepOrange.shade900.withOpacity(0.8), //finindo a cor vermelha

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    ),
                    child: Text(
                      _authMode == AuthMode.login ? 'ENTRAR' : 'REGISTRAR',
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
