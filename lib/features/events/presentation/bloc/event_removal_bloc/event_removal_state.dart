part of 'event_removal_bloc.dart';

@immutable
sealed class EventRemovalState {}

final class EventRemovalInitial extends EventRemovalState {}

class EventRemovalLoading extends EventRemovalState {}

class EventRemovalFailure extends EventRemovalState {
  final String errorMessage;

  EventRemovalFailure({
    required this.errorMessage,
  });
}

class EventRemovalSuccess extends EventRemovalState {}