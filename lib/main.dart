import 'package:email_client/Pages/RecipientMessagePage.dart';
import 'package:email_client/Pages/SendMessagePage.dart';
import 'package:email_client/Pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'Models/MailModel.dart';
import 'Pages/MainPanel.dart';
import 'functions/functions.dart';

void main() {
  return runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'loginPage',
      // routes: {
      //   '/mainPanel': (context) => MainPanel(),
      //   '/detailPage': (context) => RecipientMessagePage()
      // },
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          //'/': (context) => MainPanel(),
          'loginPage': (context) => LoginPage(),
          'mainPanel': (context) => MainPanel(nameBox: 'inbox'),
          'detailPage': (context) => RecipientMessagePage(mailModel: settings.arguments as MailModel),
          'sendMessage': (context) => SendMessagePage(),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (context) => builder(context));
      }
    )
  );
}