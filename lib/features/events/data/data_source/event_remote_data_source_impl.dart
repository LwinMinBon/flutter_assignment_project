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
      final eventData = await supabaseClient.from("events").insert(eventModel.toJson()).select();
      final event = EventModel.fromJson(eventData.first);
      return event;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

}