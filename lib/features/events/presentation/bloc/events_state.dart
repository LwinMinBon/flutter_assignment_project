part of 'events_bloc.dart';

@immutable
sealed class EventsState {}

final class EventsInitial extends EventsState {}

final class EventsLoading extends EventsState {}

final class EventsFailure extends EventsState {
  final String errorMessage;

  EventsFailure({
    required this.errorMessage,
  });
}

final class EventsSuccess extends EventsState {
  final List<EventEntity> eventEntities;

  EventsSuccess({
    required this.eventEntities,
  });
}
