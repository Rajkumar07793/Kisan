import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeTractorsFetched extends HomeEvent {
  final String? serviceType;
  const HomeTractorsFetched({this.serviceType});

  @override
  List<Object?> get props => [serviceType];
}

class HomeMyTractorsFetched extends HomeEvent {}

class HomeTractorBooked extends HomeEvent {
  final String tractorId;
  final String serviceType;
  final double acreage;
  final DateTime date;

  const HomeTractorBooked({
    required this.tractorId,
    required this.serviceType,
    required this.acreage,
    required this.date,
  });

  @override
  List<Object?> get props => [tractorId, serviceType, acreage, date];
}
