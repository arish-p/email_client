import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions/functions.dart';
import 'MainPanel.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  Widget boxDivider =  const SizedBox(
    height: 20,
  );

  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Авторизация',
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'roboto',
              fontStyle: FontStyle.normal
          ),),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email,size: 120,color: Colors.grey.shade300,),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:  BorderRadius.all(Radius.circular(20))
                        ),
                        hintText: 'email',
                        hintStyle: TextStyle(fontSize: 13),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Введите email';
                        }
                        return null;
                      },
                      onSaved: (value){
                        email = value!;
                      },
                    ),
                    boxDivider,
                    TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:  BorderRadius.all(Radius.circular(20))
                        ),
                        hintText: 'пароль',
                        hintStyle: TextStyle(fontSize: 13),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Введите пароль';
                        }
                        return null;
                      },
                      onSaved: (value){
                        password = value!;
                      },
                    ),
                boxDivider,
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade300,
                    ),

                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        print('$email   $password');
                        showDialog(context: context,
                            builder: (BuildContext context) =>  AlertDialog(
                              content:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children:const <Widget> [
                                      SizedBox(
                                        height: 10,
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                        width: 10,
                                      )
                                    ],
                                  ),
                                  const Text('Вход...', style: TextStyle(
                                      fontSize: 20
                                  ),)
                                ],
                              ),
                            )
                        );
                        connect(email,password).then((value)
                            {
                              if(value){
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Вход выполнен'))
                                );
                                Navigator.pushNamedAndRemoveUntil(context, 'mainPanel', (route) => false);
                              }else{
                                Navigator.pop(context);
                                showDialog(context: context,
                                    builder: (BuildContext context) => const AlertDialog(
                                  content: Text('Не удалось подключиться'),
                                ));
                              }
                            });

                      }
                    },
                    child: const Text('Войти',
                        style: TextStyle(color: Colors.black)),
                  ),)

                  ],
                ),
              ),
            )

          ),
        ),
      ),
    );
  }
}
