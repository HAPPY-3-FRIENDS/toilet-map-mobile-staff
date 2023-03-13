abstract class CheckinEvent {}

class CreateCheckinEvent extends CheckinEvent {
  final int toiletId;
  final int userId;
  final String serviceType;
  final DateTime dateTime;

  CreateCheckinEvent(this.toiletId, this.userId, this.serviceType, this.dateTime);
}