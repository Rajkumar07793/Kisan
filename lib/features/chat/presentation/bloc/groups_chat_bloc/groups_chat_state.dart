import '../../../domain/entities/messages.dart';

class GroupsChatState {
  final List<Message> messages;

  GroupsChatState({required this.messages});

  GroupsChatState copyWith({List<Message>? messages}) {
    return GroupsChatState(messages: messages ?? this.messages);
  }
}
