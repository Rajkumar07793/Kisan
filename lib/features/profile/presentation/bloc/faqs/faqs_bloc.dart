import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_faqs_usecase.dart';
import 'faqs_event.dart';
import 'faqs_state.dart';

class FaqsBloc extends Bloc<FaqsEvent, FaqsState> {
  final GetFaqsUseCase getFaqsUseCase;

  FaqsBloc({required this.getFaqsUseCase}) : super(FaqsInitial()) {
    on<FetchFaqs>((event, emit) async {
      emit(FaqsLoading());

      final result = await getFaqsUseCase();

      result.fold(
        (failure) => emit(FaqsError(failure.message)),
        (faqs) => emit(FaqsLoaded(faqs)),
      );
    });
  }
}
