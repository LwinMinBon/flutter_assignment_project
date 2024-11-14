import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/event_entity.dart';
import '../../domain/usecase/create_event.dart';
import '../../domain/usecase/get_event.dart';
import '../../domain/usecase/remove_event.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final CreateEvent _createEvent;
  final GetEvent _getEvent;
  final RemoveEvent _removeEvent;

  EventBloc({
    required CreateEvent createEvent,
    required GetEvent getEvent,
    required RemoveEvent removeEvent,
  })  : _createEvent = createEvent,
        _getEvent = getEvent,
        _removeEvent = removeEvent,
        super(EventInitial()) {
    on<EventCreate>(_onEventCreate);
    on<EventGet>(_onEventGet);
    on<EventRemove>(_onEventRemove);
  }

  void _onEventCreate(EventCreate event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final result = await _createEvent(
      UploadEventParams(
        imageFile: event.imageFile,
        userId: event.userId,
        name: event.name,
        description: event.description,
        topics: event.topics,
        location: event.location,
        venueName: event.venueName,
        coordinates: event.coordinates,
        date: event.date,
        time: event.time,
      ),
    );
    result.fold(
      (error) {
        emit(EventFailure(errorMessage: error.message));
      },
      (eventEntity) {
        emit(EventSuccess(eventEntity: eventEntity));
      },
    );
  }

  void _onEventGet(EventGet event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final result = await _getEvent(event.eventId);
    result.fold(
      (error) {
        emit(EventFailure(errorMessage: error.message));
      },
      (eventEntity) {
        emit(EventSuccess(eventEntity: eventEntity));
      },
    );
  }

  void _onEventRemove(EventRemove event, Emitter<EventState> emit) async {
    emit(EventLoading());
    final result = await _removeEvent(event.eventId);
    result.fold((error) {
      emit(EventRemoveFailure(errorMessage: error.message));
    }, (unit) {
      emit(EventRemoveSuccess());
    });
  }
}
