part of 'event_bloc.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}

final class EventLoading extends EventState {}

final class EventFailure extends EventState {
  final String errorMessage;

  EventFailure({
    required this.errorMessage,
  });
}

final class EventSuccess extends EventState {
  final EventEntity eventEntity;

  EventSuccess({
    required this.eventEntity,
  });
}