import 'package:cheat_app/constant.dart';
import 'package:cheat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:cheat_app/widgets/bubble_chat_friend.dart';
import 'package:cheat_app/widgets/bubble_chat_myself.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  static String chatId = 'ChatPage';
  const ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _controller = ScrollController();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kPrimaryImage,
              height: 50,
            ),
            const Text(
              'Chat',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 27),
            )
          ],
        ),
        actions: const [
          Icon(
            Icons.notifications,
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? BubbleChatMyself(
                            message: messagesList[index],
                          )
                        : BubbleChatFriend(
                            message: messagesList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email.toString());
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: const Icon(Icons.send),
                suffixIconColor: kPrimaryColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
