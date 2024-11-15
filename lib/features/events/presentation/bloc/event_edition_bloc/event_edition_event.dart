part of 'event_edition_bloc.dart';

@immutable
sealed class EventEditionEvent {}

class EventEdit extends EventEditionEvent {
  final EventEntity eventEntity;
  EventEdit({
    required this.eventEntity,
  });
}
