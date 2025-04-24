import 'package:bloc/bloc.dart';
import 'package:cheat_app/constant.dart';
import 'package:cheat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessage);
  List<MessageModel> messagesList = [];
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessageField: message,
        kTime: DateTime.now(),
        kEmail: email,
      });
    } catch (e) {}
  }

  void getMessage() {
    messages.orderBy(kTime, descending: true).snapshots().listen(
      (event) {
        messagesList.clear();
        for (var doc in event.docs) {
          messagesList.add(MessageModel.fromJson(doc));
        }
        emit(ChatSuccess(message: messagesList));
      },
    );
  }
}
