import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toiletmap_staff/app/blocs/checkin/checkin_event.dart';
import 'package:toiletmap_staff/app/blocs/checkin/checkin_state.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';

class CheckinBloc extends Bloc<CheckinEvent, CheckinState> {
  final CheckinRepository _repository;

  CheckinBloc(this._repository) : super(CheckinCreatingState()) {
    on<CreateCheckinEvent>((event, emit) async {
      emit(CheckinCreatingState());
      try {
        final model = await _repository.postCheckin(event.toiletId, event.userId, event.serviceType, event.dateTime);
        emit(CheckinCreatedState());
      } catch (e) {
        emit(CheckinErrorState(e.toString()));
      }
    });
  }
}