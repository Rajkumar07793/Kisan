import 'package:equatable/equatable.dart';
import 'package:kisan_app/features/profile/domain/entities/faq_entity.dart';

abstract class FaqsState extends Equatable {
  const FaqsState();

  @override
  List<Object?> get props => [];
}

class FaqsInitial extends FaqsState {}

class FaqsLoading extends FaqsState {}

class FaqsLoaded extends FaqsState {
  final List<FaqEntity> faqs;

  const FaqsLoaded(this.faqs);

  @override
  List<Object?> get props => [faqs];
}

class FaqsError extends FaqsState {
  final String message;

  const FaqsError(this.message);

  @override
  List<Object?> get props => [message];
}
