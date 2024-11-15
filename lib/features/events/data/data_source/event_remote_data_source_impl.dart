import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exception/exceptions.dart';
import '../model/event_model.dart';
import 'event_remote_data_source.dart';

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final SupabaseClient supabaseClient;
  EventRemoteDataSourceImpl({
    required this.supabaseClient,
  });

  @override
  Future<String> uploadEventImage(EventModel eventModel, File imageFile) async {
    try {
      await supabaseClient.storage.from("event_images").upload(eventModel.id, imageFile);
      return supabaseClient.storage.from("event_images").getPublicUrl(eventModel.id);
    } on StorageException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EventModel> createEvent(EventModel eventModel) async {
    try {
      final events = await supabaseClient.from("events").insert(eventModel.toJson()).select();
      final eventModelReturned = EventModel.fromJson(events.first);
      return eventModelReturned;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<EventModel>> getAllEvents() async {
    try {
      final events  = await supabaseClient.from("events").select("*, profiles (email, username, phone_number)");
      final eventModels =  events.map((event) => EventModel.fromJson(event).copyWith(
        posterEmail: event["profiles"]["email"],
        posterUsername: event["profiles"]["username"],
        posterPhoneNumber: event["profiles"]["phone_number"]
      )).toList();
      return eventModels;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EventModel> getEvent(String id) async {
    try {
      final events = await supabaseClient.from("events").select("*, profiles (email, username, phone_number)").eq("id", id);
      final eventModel =  events.map((event) => EventModel.fromJson(event).copyWith(
          posterEmail: event["profiles"]["email"],
          posterUsername: event["profiles"]["username"],
          posterPhoneNumber: event["profiles"]["phone_number"]
      )).toList().first;
      return eventModel;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> removeEvent(String id) async {
    try {
      await supabaseClient.from("events").delete().eq("id", id);
      await supabaseClient.storage.from("event_images").remove([id]);
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateEvent(EventModel eventModel) async {
    try {
      await supabaseClient.from("events").update(eventModel.toJson()).eq("id", eventModel.id);
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

}