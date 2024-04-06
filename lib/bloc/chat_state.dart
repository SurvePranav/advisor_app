part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

final class ChatInitial extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<ChatMessageModel> messages;
  const ChatSuccessState({required this.messages});
}

class ChatLoadingState extends ChatState {}

class ChatErrorState extends ChatState {}
