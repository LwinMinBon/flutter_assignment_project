part of 'event_removal_bloc.dart';

@immutable
sealed class EventRemovalEvent {}

class EventRemove extends EventRemovalEvent {
  final String eventId;

  EventRemove({
    required this.eventId,
  });
}
