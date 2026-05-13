part of 'chat_messages_bloc.dart';

abstract class ChatMessagesEvent extends Equatable {
  const ChatMessagesEvent();
  @override
  List<Object?> get props => [];
}

class LoadMessages extends ChatMessagesEvent {
  final String chatId;
  const LoadMessages(this.chatId);
  @override
  List<Object?> get props => [chatId];
}

class SendMessage extends ChatMessagesEvent {
  final String chatId;
  final String text;
  const SendMessage({required this.chatId, required this.text});
  @override
  List<Object?> get props => [chatId, text];
}
