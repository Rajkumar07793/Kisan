import '../../../domain/entities/messages.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'groups_chat_event.dart';
import 'groups_chat_state.dart';

class GroupsChatBloc extends Bloc<GroupsChatEvent, GroupsChatState> {
  GroupsChatBloc()
    : super(
        GroupsChatState(
          messages: [
            Message(
              text: """Hi Elena! I'm glad you like it. You're in
luck—there's a wonderful boulangerie
just two blocks away called 'Du Pain
et des Idées'. Their pistachio snails
are famous!""",
              time: DateTime.now(),
              isMe: false,
            ),
            Message(
              text: """I'd love to join! I'm staying in Canggu,
maybe we can share a driver to the
base?""",
              time: DateTime.now(),
              isMe: true,
            ),
          ],
        ),
      ) {
    on<SendGroupsMessageEvent>((event, emit) {
      final newMessage = Message(
        text: event.message,
        time: DateTime.now(),
        isMe: true,
      );

      final reply = Message(
        text: """Hi there! I'm so excited about
my upcoming trip to Paris. Your
place looks absolutely lovely in
the photos. Is it close to any
local bakeries? 🥐""",
        time: DateTime.now(),
        isMe: false,
      );

      final updatedList = List<Message>.from(state.messages)
        ..add(newMessage)
        ..add(reply);

      emit(state.copyWith(messages: updatedList));
    });
  }
}
