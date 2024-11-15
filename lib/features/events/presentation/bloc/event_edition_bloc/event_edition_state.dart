part of 'event_edition_bloc.dart';

@immutable
sealed class EventEditionState {}

final class EventEditionInitial extends EventEditionState {}

final class EventEditionLoading extends EventEditionState {}

final class EventEditionFailure extends EventEditionState {
  final String errorMessage;

  EventEditionFailure({
    required this.errorMessage,
  });
}

final class EventEditionSuccess extends EventEditionState {}
