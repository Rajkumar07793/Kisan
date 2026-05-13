import 'package:equatable/equatable.dart';

enum MessageType { text, image, file }

class MessageEntity extends Equatable {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final MessageType type;
  final bool isMe;

  const MessageEntity({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.type = MessageType.text,
    required this.isMe,
  });

  @override
  List<Object?> get props => [id, senderId, text, timestamp, type, isMe];
}
