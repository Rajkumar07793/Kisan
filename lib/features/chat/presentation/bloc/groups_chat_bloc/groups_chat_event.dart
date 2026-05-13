abstract class GroupsChatEvent {}

class SendGroupsMessageEvent extends GroupsChatEvent {
  final String message;

  SendGroupsMessageEvent(this.message);
}
