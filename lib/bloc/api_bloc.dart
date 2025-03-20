import 'package:aicaptions/models/generated_captions_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../api_service.dart';

// Events
abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends ApiEvent {
  final String prompt;

  const FetchDataEvent(this.prompt);

  @override
  List<Object> get props => [prompt];
}

// States
abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final GeneratedCaptionModel data;

  const ApiLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ApiError extends ApiState {
  final String message;

  const ApiError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiService apiService;

  ApiBloc(this.apiService) : super(ApiInitial()) {
    on<FetchDataEvent>((event, emit) async {
      emit(ApiLoading());
      try {
        final response = await apiService.fetchData(event.prompt);
        emit(ApiLoaded(GeneratedCaptionModel.fromJson(response.data)));
      } catch (e) {
        emit(const ApiError("Some Error occured, please try again"));
      }
    });
  }
}
