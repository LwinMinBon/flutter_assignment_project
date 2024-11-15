import '../../data/model/event_model.dart';

class EventEntity {
  final String id;
  final DateTime updatedAt;
  final String userId;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> topics;
  final String location;
  final String venueName;
  final List<String> coordinates;
  final String date;
  final String time;
  final String? posterEmail;
  final String? posterUsername;
  final String? posterPhoneNumber;

  EventEntity({
    required this.id,
    required this.updatedAt,
    required this.userId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.topics,
    required this.location,
    required this.venueName,
    required this.coordinates,
    required this.date,
    required this.time,
    this.posterEmail,
    this.posterUsername,
    this.posterPhoneNumber,
  });

  factory EventEntity.fromModel(EventModel model) {
    return EventEntity(
      id: model.id,
      updatedAt: model.updatedAt,
      userId: model.userId,
      name: model.name,
      description: model.description,
      imageUrl: model.imageUrl,
      topics: model.topics,
      location: model.location,
      venueName: model.venueName,
      coordinates: model.coordinates,
      date: model.date,
      time: model.time,
      posterEmail: model.posterEmail,
      posterUsername: model.posterUsername,
      posterPhoneNumber: model.posterPhoneNumber
    );
  }

  EventEntity copyWith({
    String? id,
    DateTime? updatedAt,
    String? userId,
    String? name,
    String? description,
    String? imageUrl,
    List<String>? topics,
    String? location,
    String? venueName,
    List<String>? coordinates,
    String? date,
    String? time,
    String? posterEmail,
    String? posterUsername,
    String? posterPhoneNumber,
  }) {
    return EventEntity(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      location: location ?? this.location,
      venueName: venueName ?? this.venueName,
      coordinates: coordinates ?? this.coordinates,
      date: date ?? this.date,
      time: time ?? this.time,
      posterEmail: posterEmail,
      posterUsername: posterUsername,
      posterPhoneNumber: posterPhoneNumber,
    );
  }
}
