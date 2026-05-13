import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final String otherUserName;
  final String otherUserImageUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  const ChatEntity({
    required this.id,
    required this.otherUserName,
    required this.otherUserImageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  @override
  List<Object?> get props => [
    id,
    otherUserName,
    otherUserImageUrl,
    lastMessage,
    lastMessageTime,
    unreadCount,
    isOnline,
  ];
}
