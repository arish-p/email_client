import 'package:email_client/Models/MailModel.dart';
import 'package:email_client/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendMessagePage extends StatelessWidget {
  SendMessagePage({Key? key}) : super(key: key);
  var _formKey = GlobalKey<FormState>();

  String? email;
  String? text;
  String? subject;

  Widget boxDivider =  const SizedBox(
    height: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Отправить', style:
          TextStyle(
            color: Colors.black,
            fontFamily: 'roboto',
            fontStyle: FontStyle.normal,
          ),),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius:  BorderRadius.all(Radius.circular(20))
                      ),
                      hintText: 'email',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Введите email";
                      }
                    },
                    onSaved: (value){
                      email = value;
                    },
                  ),
                  boxDivider,
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius:  BorderRadius.all(Radius.circular(20))
                      ),
                      hintText: 'Тема',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    ),

                    onSaved: (value){
                      if(value!.isEmpty){
                        subject = '';
                      }else{
                        subject = value;
                      }
                    },
                  ),
                  boxDivider,
                  TextFormField(
                    maxLines: null,
                    minLines: 10,
                    textAlignVertical:  TextAlignVertical.top,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                     /* contentPadding: EdgeInsets.symmetric(vertical: 20),*/
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide( color: Colors.black),
                          borderRadius:  BorderRadius.all(Radius.circular(20))
                      ),
                      hintText: 'Введите сообщение',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Введите сообщение";
                      }
                    },
                    onSaved: (value){
                      text = value;
                    },
                  ),
                  boxDivider,
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            send(email!, MailModel.mailClient.account.email.toString(), text!, subject!)
                            .then((value) => {
                              if(value){
                                showDialog(
                                  barrierDismissible: true,
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      content: Row(
                                        children: const [
                                          Icon(Icons.check, color: Colors.green, size: 20,),
                                          Text('Сообщение отправлено')
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              Navigator.pushNamedAndRemoveUntil(context, 'mainPanel', (route) => false);
                                            },
                                            child: const Text('ок'))
                                      ],
                                    )
                                )
                              }else{
                                showDialog(
                                  barrierDismissible: true,
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      content: Row(
                                        children: const [
                                          Icon(Icons.close, color: Colors.black, size: 20,),
                                          Text('Сообщение не отправлено, проблема с подключением к клиенту')
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            child: const Text('назад'))
                                      ],
                                    )
                                )
                              }
                            });
                          }

                        },
                        child: const Text('Отправить'),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
