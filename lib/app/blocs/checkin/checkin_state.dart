
import 'package:toiletmap_staff/app/models/checkin/checkin_model.dart';

abstract class CheckinState {}

class CheckinCreatingState extends CheckinState {}

class CheckinErrorState extends CheckinState {
  final String message;
  CheckinErrorState(this.message);
}

class CheckinCreatedState extends CheckinState {
  CheckinCreatedState();
}

