import 'package:email_client/Pages/RecipientMessagePage.dart';
import 'package:email_client/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enough_mail/enough_mail.dart';
import '../Data/MailData.dart';
import '../Models/MailModel.dart';
import 'dart:math' as math;

late Future <List<MailModel>> items;

class  MessageBoxList extends StatefulWidget {
  String box;
  MessageBoxList({Key? key, required this.box}) : super(key: key);

  @override
  State<MessageBoxList> createState() => _MessageBoxListState();
}

class _MessageBoxListState extends State<MessageBoxList> {




  @override
  void initState() {
    items = getMails(widget.box);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: items,
        builder: (BuildContext context, snapshot) {
          if(snapshot.hasData){
            List<MailModel> items = snapshot.data as List<MailModel>;
            items = items.reversed.toList();
            return ListView.separated(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  minVerticalPadding: 0,
                  title: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'detailPage', arguments: items[index]);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            flex: 25,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                    radius: 20,
                                    child: Text(items[index].avatar, style:
                                    const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                    ),),
                                  ),
                                  PopupMenuButton(
                                      icon: Icon(Icons.menu, color: Colors.grey,),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    items.removeAt(index);
                                                    MailModel.mailClient.deleteMessage(MailModel.messages[index]);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text('Удалить', style: TextStyle(color: Colors.grey),),
                                              )),
                                          PopupMenuItem(
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    items.removeAt(index);
                                                    MailModel.mailClient.moveMessageToFlag(MailModel.messages[index], MailboxFlag.junk);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text('В спам', style: TextStyle(color: Colors.grey)),
                                              ))
                                        ];
                                      })
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: double.infinity, height: 25,
                                    child: Text(items[index].personalName.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey, fontSize: 14),
                                    )),
                                Container(width: double.infinity, height: 30,
                                    child: Text(items[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.black, fontSize: 18)
                                    )),
                                Container(width: double.infinity, height: 70,
                                  child: Text(items[index].content.toString(),
                                    overflow: TextOverflow.fade,
                                      style: TextStyle(color: Colors.grey, fontSize: 14)
                                  ), ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 25,
                            child: Column(
                              mainAxisAlignment:  MainAxisAlignment.start,
                              children: [
                                Text((items[index].date).toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 0,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black12,
                );
              },
            );
          }
          else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }

    );
  }
}



