import 'package:email_client/Models/MailModel.dart';
import 'package:email_client/Widgets/MessageBoxList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


class MainPanel extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String nameBox = 'inbox';
  MainPanel({Key? key, required this.nameBox }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
         _scaffoldKey.currentState?.openDrawer();
        }, icon: Icon(Icons.menu, color: Colors.black,),),
        title: /*(nameBox == 'inbox')? Text('Входящие'): (nameBox=='sendbox')? Text('Отправленные'):(nameBox == 'trashbox')? Text('Корзина'): Text('Спам'),*/
        Text((nameBox == 'inbox')? ('Входящие'): (nameBox=='sendbox')? ('Отправленные'):(nameBox == 'trashbox')? ('Корзина'): ('Спам'),
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'roboto',
          fontStyle: FontStyle.normal
        ),),
        centerTitle: true,
      ),
      body: MessageBoxList(box: nameBox),

      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.grey,
        child: const Icon(Icons.send_outlined),
        onPressed: (){

          Navigator.pushNamed(context, 'sendMessage');

        },
      ),

      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget> [
              const DrawerHeader(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text('MAILER'),
              ),
              ListTile(
                title: Text('Входящие'),
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      MainPanel(nameBox: 'inbox')
                  ), (route) => false);
                },
              ),
              ListTile(
                title: const Text('Отправленные'),
                onTap: (){

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  MainPanel(nameBox: 'sendbox')
                  ), (route) => false);
                },
              ),
              ListTile(
                title: const Text('Спам'),
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      MainPanel(nameBox: 'spam')
                  ), (route) => false);
                },
              ),
              ListTile(
                title: const Text('Корзина'),
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      MainPanel(nameBox: 'trashbox')
                  ), (route) => false);
                },
              ),
              ListTile(
                title: const Text('Выйти'),
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, 'loginPage', (route) => false);
                  MailModel.mailClient.disconnect();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
