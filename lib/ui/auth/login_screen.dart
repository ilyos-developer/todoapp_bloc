import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_trello/bloc/auth/auth_bloc.dart';
import 'package:todo_trello/ui/auth/user_register_screen.dart';
import 'package:todo_trello/ui/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthBloc _bloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kanban"),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print("adad");
          if (state is LoginedUserState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _loginController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Введите логин";
                        }
                        if (value.length < 4) {
                          return "минимум 4 символа";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Логин',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Введите пароль";
                        }
                        if (value.length < 8) {
                          return "минимум 8 символа";
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("user login validate");
                          _bloc.add(
                            LoginUserEvent(
                              _loginController.text,
                              _passwordController.text,
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: Center(child: Text("Log In")),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("У вас нет аккаунта?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserRegister(),
                              ),
                            );
                          },
                          child: Text("Регистрация"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
