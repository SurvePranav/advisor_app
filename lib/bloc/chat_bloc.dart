import 'dart:async';
import 'dart:developer';

import 'package:advisor/models/chat_message_model.dart';
import 'package:advisor/repos/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<ChatMessageModel> messages = [];
  bool generating = false;

  ChatBloc() : super(const ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }

  FutureOr<void> chatGenerateNewTextMessageEvent(
    ChatGenerateNewTextMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    log('generating new response');
    // adding user text to messages
    messages.add(
      ChatMessageModel(
        role: "user",
        parts: [
          ChatPartModel(text: event.inputMessage),
        ],
      ),
    );

    // making loading true
    generating = true;

    // emmiting chat success state
    emit(ChatSuccessState(messages: messages));

    // making api call and getting response
    String modelResponse = await ChatRepo.chatTextGenerationRepo(messages);

    log(messages.length.toString());
    final newMessages = messages;
    // adding generated response to messages
    if (modelResponse.isNotEmpty) {
      newMessages.add(
        ChatMessageModel(
          role: 'model',
          parts: [
            ChatPartModel(text: modelResponse),
          ],
        ),
      );
      messages = newMessages;
      log(messages.length.toString());

      // making loading stop
      generating = false;

      // emmiting chat success state
      emit(ChatSuccessState(messages: newMessages));
    } else {
      // emiting error state
      emit(ChatErrorState());
    }
  }
}
