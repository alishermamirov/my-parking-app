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
    // return Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   body: Center(
    //     child: Card(
    //       margin: const EdgeInsets.all(20),
    //       child: SingleChildScrollView(
    //         child: Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Form(
    //             key: _formKey,
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 TextFormField(
    //                   key: const ValueKey('email'),
    //                   keyboardType: TextInputType.emailAddress,
    //                   decoration: const InputDecoration(
    //                     labelText: 'Email Manzil',
    //                   ),
    //                   validator: (value) {
    //                     if (value == null ||
    //                         value.isEmpty ||
    //                         !value.contains('@')) {
    //                       return "Iltimos to'g'ri email manzil kiriting";
    //                     }

    //                     return null;
    //                   },
    //                   onSaved: (newValue) {
    //                     _userData['email'] = newValue!;
    //                   },
    //                 ),
    //                 if (!_isLogin)
    //                   TextFormField(
    //                     key: const ValueKey('username'),
    //                     decoration: const InputDecoration(
    //                       labelText: 'Username',
    //                     ),
    //                     validator: (value) {
    //                       if (value == null ||
    //                           value.isEmpty ||
    //                           value.length < 4) {
    //                         return "Iltimos 4 elementdan kam bo'lmagan username kiriting";
    //                       }

    //                       return null;
    //                     },
    //                     onSaved: (newValue) {
    //                       _userData['username'] = newValue!;
    //                     },
    //                   ),
    //                 TextFormField(
    //                   key: const ValueKey('password'),
    //                   decoration: const InputDecoration(labelText: 'Parol'),
    //                   obscureText: true,
    //                   validator: (value) {
    //                     if (value == null ||
    //                         value.isEmpty ||
    //                         value.length < 7) {
    //                       return "Iltimos 7 elementdan kam bo'lmagan parol kiriting.";
    //                     }

    //                     return null;
    //                   },
    //                   onSaved: (newValue) {
    //                     _userData['password'] = newValue!;
    //                   },
    //                 ),
    //                 const SizedBox(height: 15),

    //                 BlocBuilder<AuthBloc, AuthState>(
    //                   builder: (context, state) {
    //                     if (state is AuthLoading) {
    //                       return CircularProgressIndicator();
    //                     }
    //                     return Column(
    //                       children: [
    //                         ElevatedButton(
    //                           onPressed: _submit,
    //                           child: Text(
    //                             _isLogin ? 'Kirish' : 'R\'oyxatdan o\'tish',
    //                           ),
    //                         ),
    //                         TextButton(
    //                           onPressed: () {
    //                             setState(() {
    //                               _isLogin = !_isLogin;
    //                             });
    //                           },
    //                           child: Text(
    //                             _isLogin
    //                                 ? 'Ro\'yxatdan o\'tish'
    //                                 : 'Tizimga kirish',
    //                           ),
    //                         ),
    //                       ],
    //                     );
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        title: "Registration",
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: const ValueKey('email'),
                  // obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Color(0xFFF5FCF9),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0 * 1.5,
                      vertical: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
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
                    key: const ValueKey('Username'),
                    // obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      filled: true,
                      fillColor: Color(0xFFF5FCF9),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0 * 1.5,
                        vertical: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return "Iltimos 4 elementdan kam bo'lmagan username kiriting";
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      _userData['username'] = newValue!;
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Color(0xFFF5FCF9),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0 * 1.5,
                        vertical: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return "Iltimos 7 elementdan kam bo'lmagan parol kiriting.";
                      }

                      return null;
                    },
                    onSaved: (newValue) {
                      _userData['password'] = newValue!;
                    },
                  ),
                ),
              ],
            ),
          ),

          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF00BF6D),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(_isLogin ? 'Login' : 'Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text.rich(
                      TextSpan(
                        text: _isLogin
                            ? "Don't have an account? "
                            : "Already have an account",
                        children: [
                          TextSpan(
                            text: _isLogin ? "Register" : "Login",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.color!.withOpacity(0.64),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle({
    Key? key,
    required this.title,
    this.subText = '',
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.1),
                Image.asset(
                  "assets/images/—Pngtree—parking gate_8530032.png",
                  fit: BoxFit.cover,
                  height: 130,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                  width: double.infinity,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    subText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.color!.withOpacity(0.64),
                    ),
                  ),
                ),
                ...children,
              ],
            ),
          );
        },
      ),
    );
  }
}
