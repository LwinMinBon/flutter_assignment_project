part of 'events_bloc.dart';

@immutable
sealed class EventsEvent {}

class EventsGetAll extends EventsEvent {}