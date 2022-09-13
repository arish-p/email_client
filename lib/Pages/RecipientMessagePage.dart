import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/MailModel.dart';

class RecipientMessagePage extends StatelessWidget {
   MailModel mailModel;
   RecipientMessagePage({
          required this.mailModel,
          Key? key

        }
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Сообщение', style:
          TextStyle(
              color: Colors.black,
              fontFamily: 'roboto',
              fontStyle: FontStyle.normal,
          ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(mailModel.title),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Row(
                    children:  [
                      const CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(mailModel.personalName.toString()),
                              Text(mailModel.date),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                  child: Text(mailModel.content.toString())),
            ),
          ],
        ),
      ) ,
    );
  }
}
