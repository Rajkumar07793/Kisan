import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const HomeState()) {
    on<HomeTractorsFetched>(_onTractorsFetched);
    on<HomeMyTractorsFetched>(_onMyTractorsFetched);
    on<HomeTractorBooked>(_onTractorBooked);
  }

  Future<void> _onTractorsFetched(
    HomeTractorsFetched event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final tractors = await _homeRepository.getTractors(
        serviceType: event.serviceType,
      );
      emit(state.copyWith(
        status: HomeStatus.success,
        tractors: tractors,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onMyTractorsFetched(
    HomeMyTractorsFetched event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final tractors = await _homeRepository.getMyTractors();
      emit(state.copyWith(
        status: HomeStatus.success,
        myTractors: tractors,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onTractorBooked(
    HomeTractorBooked event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await _homeRepository.bookTractor(
        tractorId: event.tractorId,
        serviceType: event.serviceType,
        acreage: event.acreage,
        date: event.date,
      );
      emit(state.copyWith(status: HomeStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
