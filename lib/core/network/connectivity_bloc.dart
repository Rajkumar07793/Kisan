import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// --- Events ---
abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object?> get props => [];
}

class ConnectivityStarted extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final List<ConnectivityResult> results;
  const ConnectivityChanged(this.results);

  @override
  List<Object?> get props => [results];
}

// --- States ---
abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object?> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityOnline extends ConnectivityState {}

class ConnectivityOffline extends ConnectivityState {}

// --- Bloc ---
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _subscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<ConnectivityStarted>(_onStarted);
    on<ConnectivityChanged>(_onChanged);
  }

  Future<void> _onStarted(
    ConnectivityStarted event,
    Emitter<ConnectivityState> emit,
  ) async {
    final results = await _connectivity.checkConnectivity();
    _handleConnectivity(results, emit);

    _subscription?.cancel();
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      add(ConnectivityChanged(results));
    });
  }

  void _onChanged(ConnectivityChanged event, Emitter<ConnectivityState> emit) {
    _handleConnectivity(event.results, emit);
  }

  void _handleConnectivity(
    List<ConnectivityResult> results,
    Emitter<ConnectivityState> emit,
  ) {
    if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      emit(ConnectivityOffline());
    } else {
      emit(ConnectivityOnline());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
