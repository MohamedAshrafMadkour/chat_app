import 'package:cheat_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:cheat_app/constant.dart';
import 'package:cheat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:cheat_app/helper/snake_bar_show.dart';
import 'package:cheat_app/pages/chat.dart';
import 'package:cheat_app/pages/register.dart';
import 'package:cheat_app/widgets/container_text.dart';
import 'package:cheat_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  static String loginId = 'LoginView';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginFailure) {
          snakeBarShow(context, state.errorMessage);
          isLoading = false;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.chatId, arguments: email);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 76,
                    ),
                    const Image(
                      height: 170,
                      image: AssetImage(kPrimaryImage),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login Page',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 76,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'SIGN',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFieldCustom(
                        onChanged: (data) {
                          email = data;
                        },
                        titleFiled: 'Email'),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFieldCustom(
                        secure: true,
                        onChanged: (data) {
                          password = data;
                        },
                        titleFiled: 'Password'),
                    const SizedBox(
                      height: 32,
                    ),
                    ContainerLogin(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .signData(email: email!, password: password!);
                          } else {}
                        },
                        title: 'Sign In'),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account ? ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterView.id);
                          },
                          child: const Text(
                            'Sign Up ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 76,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
