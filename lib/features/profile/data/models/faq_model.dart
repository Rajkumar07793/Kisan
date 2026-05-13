import '../../domain/entities/faq_entity.dart';

class FaqModel extends FaqEntity {
  const FaqModel({
    required super.id,
    required super.question,
    required super.answer,
    required super.displayOrder,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'].toString(),
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      displayOrder: json['display_order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'display_order': displayOrder,
    };
  }
}
