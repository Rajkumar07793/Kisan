import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/message_entity.dart';

part 'chat_messages_event.dart';
part 'chat_messages_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesState> {
  ChatMessagesBloc() : super(ChatMessagesInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  // Current active messages in memory for mock
  final Map<String, List<MessageEntity>> _messagesCache = {};

  void _onLoadMessages(LoadMessages event, Emitter<ChatMessagesState> emit) {
    emit(MessagesLoading());

    if (!_messagesCache.containsKey(event.chatId)) {
      // Create initial mock messages if not exists
      _messagesCache[event.chatId] = [
        MessageEntity(
          id: 'm1',
          senderId: 'host',
          text: 'Hello! Welcome to HerStay. How can I help you today?',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isMe: false,
        ),
        MessageEntity(
          id: 'm2',
          senderId: 'me',
          text: 'Hi! I am interested in the Venice trip.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          isMe: true,
        ),
      ];
    }

    emit(
      MessagesLoaded(
        messages: _messagesCache[event.chatId]!,
        chatId: event.chatId,
      ),
    );
  }

  void _onSendMessage(SendMessage event, Emitter<ChatMessagesState> emit) {
    if (state is MessagesLoaded) {
      final currentMessages = (state as MessagesLoaded).messages;
      final newMessage = MessageEntity(
        id: DateTime.now().toString(),
        senderId: 'me',
        text: event.text,
        timestamp: DateTime.now(),
        isMe: true,
      );

      final updatedMessages = List<MessageEntity>.from(currentMessages)
        ..add(newMessage);
      _messagesCache[event.chatId] = updatedMessages;

      emit(MessagesLoaded(messages: updatedMessages, chatId: event.chatId));
    }
  }
}
