part of 'chat_messages_bloc.dart';

abstract class ChatMessagesState extends Equatable {
  const ChatMessagesState();
  @override
  List<Object?> get props => [];
}

class ChatMessagesInitial extends ChatMessagesState {}

class MessagesLoading extends ChatMessagesState {}

class MessagesLoaded extends ChatMessagesState {
  final List<MessageEntity> messages;
  final String chatId;
  const MessagesLoaded({required this.messages, required this.chatId});
  @override
  List<Object?> get props => [messages, chatId];
}

class ChatMessagesError extends ChatMessagesState {
  final String message;
  const ChatMessagesError(this.message);
  @override
  List<Object?> get props => [message];
}
