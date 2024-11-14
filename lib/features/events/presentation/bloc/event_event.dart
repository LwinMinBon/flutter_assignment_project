part of 'event_bloc.dart';

@immutable
sealed class EventEvent {}

class EventCreate extends EventEvent {
  final File imageFile;
  final String userId;
  final String name;
  final String description;
  final List<String> topics;
  final String location;
  final String venueName;
  final List<String> coordinates;
  final String date;
  final String time;

  EventCreate({
    required this.imageFile,
    required this.userId,
    required this.name,
    required this.description,
    required this.topics,
    required this.location,
    required this.venueName,
    required this.coordinates,
    required this.date,
    required this.time,
  });
}

class EventGet extends EventEvent {
  final String eventId;

  EventGet({
    required this.eventId,
  });
}

class EventRemove extends EventEvent {
  final String eventId;

  EventRemove({
    required this.eventId,
  });
}
