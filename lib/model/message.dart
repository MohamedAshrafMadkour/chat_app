import 'package:cheat_app/constant.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id);
  factory MessageModel.fromJson(jsondata) {
    return MessageModel(jsondata[kMessage], jsondata[kEmail]);
  }
}
