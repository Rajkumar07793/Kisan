import 'package:equatable/equatable.dart';

abstract class FaqsEvent extends Equatable {
  const FaqsEvent();

  @override
  List<Object?> get props => [];
}

class FetchFaqs extends FaqsEvent {}
