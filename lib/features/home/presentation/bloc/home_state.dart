import 'package:equatable/equatable.dart';
import '../../domain/entities/tractor_entity.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<TractorEntity> tractors;
  final List<TractorEntity> myTractors;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.tractors = const [],
    this.myTractors = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<TractorEntity>? tractors,
    List<TractorEntity>? myTractors,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      tractors: tractors ?? this.tractors,
      myTractors: myTractors ?? this.myTractors,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, tractors, myTractors, errorMessage];
}
