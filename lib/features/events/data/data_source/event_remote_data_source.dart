import 'dart:io';

import '../model/event_model.dart';

abstract interface class EventRemoteDataSource {
  Future<String> uploadEventImage(EventModel eventModel, File imageFile);
  Future<EventModel> createEvent(EventModel eventModel);
  Future<List<EventModel>> getAllEvents();
  Future<EventModel> getEvent(String id);
  Future<void> removeEvent(String id);
}