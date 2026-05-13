import 'package:equatable/equatable.dart';

class AppContentEntity extends Equatable {
  final String slug;
  final String title;
  final String contentHtml;

  const AppContentEntity({
    required this.slug,
    required this.title,
    required this.contentHtml,
  });

  @override
  List<Object?> get props => [slug, title, contentHtml];
}
