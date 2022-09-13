import 'package:email_client/Models/MailModel.dart';
import 'package:enough_mail/enough_mail.dart';


Future<bool> connect(String email,String password) async {

  //Автоматическое обнаружение конфигурации
  final config = await Discover.discover(email, isLogEnabled: false);


  try {
    var account =  MailAccount.fromDiscoveredSettings('my account', email, password, config!);
    MailModel.mailClient = MailClient(account, isLogEnabled: false);
    await MailModel.mailClient.connect();
    print('connected');
    return  true;
  } on MailException catch (e) {
    print('High level API failed with $e');
    return false;
  } on MailAccount catch(e){
    print('Неверный логин или пароль');
    return false;
  }

}

Future<List<MailModel>> getMails(String nameBox) async{
  final mailboxes =  MailModel.mailClient.mailboxes;
  var  _mailboxes = await MailModel.mailClient.listMailboxes();
  var inbox;
  if(nameBox == 'inbox'){
    inbox = _mailboxes.firstWhere((box) => box.isInbox);
  }
  else if (nameBox == 'sendbox'){
    inbox = _mailboxes.firstWhere((box) => box.isSent);
  }
  else if(nameBox == 'trashbox'){
    inbox = _mailboxes.firstWhere((box) => box.isTrash);
  }
  else if(nameBox == 'spam'){
    inbox = _mailboxes.firstWhere((box) => box.isJunk);
  }
  else{
    print('Ошибка');
  }
  print( 'name BOX ----> ${inbox.name}');
  await MailModel.mailClient.selectMailbox(inbox);
   MailModel.messages = await MailModel.mailClient.fetchMessages();

  List<MailModel> mails = [];
  MailModel.messages.forEach((message) {
    String title = message.decodeSubject().toString();
    String? personalName = message.from!.first.personalName;
    String? date = '${message.decodeDate()!.day}/${message.decodeDate()!.month}/${message.decodeDate()!.year}';
    String? content = message.decodeTextPlainPart();
    content ??= message.decodeContentText();
    mails.add(
      MailModel(
          title: title,
          content: content,
          personalName: personalName,
          avatar: personalName![0],
          date: date,
      ));
  });
  return mails;
}

Future<bool> send(String emailTo, String emailFrom, String text, String subject) async{
  try {
    List<MailAddress>  emails = [];
    emails.add(
      MailAddress(emailTo,text),
    );
    MimeMessage mimeMessage = MessageBuilder.buildSimpleTextMessage(
        MailAddress(emailFrom,emailFrom),
        emails,
        text,
        subject: subject,
    );
    await MailModel.mailClient.sendMessage(mimeMessage);
    return true;
  } on Exception catch (e) {
    return false;
  }
}