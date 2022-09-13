import 'package:enough_mail/enough_mail.dart';


class MailModel{
  static late MailClient mailClient;
  static late List<MimeMessage> messages;
  String title;
  String? content;
  String? personalName;
  String avatar;
  String date;

  MailModel(
      {required this.title,
        required this.content,
        required this.personalName,
        required this.avatar,
        required this.date,

      }){
    title = normalizeTitle(title);
  }


  String normalizeTitle(String string){
    string.replaceAll('\n', ' ');
    
    return  string;
  }
}