import 'dart:developer';

import 'package:advisor/bloc/chat_bloc.dart';
import 'package:advisor/models/chat_message_model.dart';
import 'package:advisor/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  final ChatBloc chatBloc = ChatBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (BuildContext context, ChatState state) {},
        builder: (context, state) {
          log('building home screen');
          if (state is ChatSuccessState) {
            List<ChatMessageModel> messages = state.messages;
            return Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage("assets/advisor_bg.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // color: Colors.red,
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 40,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 60,
                            width: 60,
                            child: Image(
                                image: AssetImage('assets/app_icon.png'))),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Advisor',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            bottom: 20, left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent.withAlpha(
                            150,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  child: messages[index].role == 'user'
                                      ? const Icon(
                                          Icons.account_circle,
                                          size: 30,
                                        )
                                      : const Image(
                                          image:
                                              AssetImage('assets/bot_icon.png'),
                                        ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  messages[index].role == "user"
                                      ? 'You'
                                      : 'Advisor',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: messages[index].role == "user"
                                          ? Colors.yellow
                                          : Colors.green),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            messages[index].role == "user"
                                ? Text(
                                    messages[index].parts.first.text.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                : buildRichText(messages[index]
                                    .parts
                                    .first
                                    .text
                                    .toString()),
                          ],
                        ),
                      );
                    },
                  )),
                  if (chatBloc.generating)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Text(
                            'Loading...',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: LottieBuilder.asset(
                              'assets/thinking_animation.json'),
                        ),
                      ],
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: "Ask Something..",
                              fillColor: Colors.transparent.withAlpha(100),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            if (textEditingController.text.isNotEmpty) {
                              String text = textEditingController.text;
                              textEditingController.clear();
                              chatBloc.add(ChatGenerateNewTextMessageEvent(
                                  inputMessage: text));
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 26,
                            child: CircleAvatar(
                              backgroundColor: Colors.cyan.shade600,
                              radius: 25,
                              child: const Icon(Icons.send),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ChatLoadingState) {
            return const Center(
              child: Text("loading......"),
            );
          } else {
            return const SizedBox(
              child: Text("Default SizedBox"),
            );
          }
        },
      ),
    );
  }
}
