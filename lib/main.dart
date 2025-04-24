import 'package:cheat_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:cheat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:cheat_app/firebase_options.dart';
import 'package:cheat_app/pages/chat.dart';
import 'package:cheat_app/pages/login.dart';
import 'package:cheat_app/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CheatApp());
}

class CheatApp extends StatelessWidget {
  const CheatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          RegisterView.id: (context) => const RegisterView(),
          LoginView.loginId: (context) => const LoginView(),
          ChatPage.chatId: (context) => const ChatPage(),
        },
        initialRoute: 'LoginView',
      ),
    );
  }
}
