import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth_bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _userData = {'email': '', 'username': '', 'password': ''};
  var _isLogin = true;

  void _submit() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      context.read<AuthBloc>().add(
        _isLogin
            ? SignInEvent(
                email: _userData['email']!,
                password: _userData['password']!,
              )
            : SignUpEvent(
                email: _userData['email']!,
                password: _userData['password']!,
                userName: _userData['username']!,
              ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: const ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Manzil',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return "Iltimos to'g'ri email manzil kiriting";
                        }

                        return null;
                      },
                      onSaved: (newValue) {
                        _userData['email'] = newValue!;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('username'),
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 4) {
                            return "Iltimos 4 elementdan kam bo'lmagan username kiriting";
                          }

                          return null;
                        },
                        onSaved: (newValue) {
                          _userData['username'] = newValue!;
                        },
                      ),
                    TextFormField(
                      key: const ValueKey('password'),
                      decoration: const InputDecoration(labelText: 'Parol'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 7) {
                          return "Iltimos 7 elementdan kam bo'lmagan parol kiriting.";
                        }

                        return null;
                      },
                      onSaved: (newValue) {
                        _userData['password'] = newValue!;
                      },
                    ),
                    const SizedBox(height: 15),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return CircularProgressIndicator();
                        }
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: _submit,
                              child: Text(
                                _isLogin ? 'Kirish' : 'R\'oyxatdan o\'tish',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? 'Ro\'yxatdan o\'tish'
                                    : 'Tizimga kirish',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
