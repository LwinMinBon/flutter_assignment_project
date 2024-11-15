import '../../domain/entity/event_entity.dart';

class EventModel extends EventEntity {
  EventModel({
    required super.id,
    required super.updatedAt,
    required super.userId,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.topics,
    required super.location,
    required super.venueName,
    required super.coordinates,
    required super.date,
    required super.time,
    super.posterEmail,
    super.posterUsername,
    super.posterPhoneNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "updated_at": updatedAt.toIso8601String(),
      "user_id": userId,
      "name": name,
      "description": description,
      "image_url": imageUrl,
      "topics": topics,
      "location": location,
      "venue_name": venueName,
      "coordinates": coordinates,
      "date": date,
      "time": time,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"] as String,
      updatedAt: DateTime.parse(json["updated_at"]),
      userId: json["user_id"] as String,
      name: json["name"] as String,
      description: json["description"] as String,
      imageUrl: json["image_url"] as String,
      topics: List<String>.from(json["topics"]),
      location: json["location"] as String,
      venueName: json["venue_name"] as String,
      coordinates: List<String>.from(json["coordinates"]),
      date: json["date"] as String,
      time: json["time"] as String,
    );
  }

  EventModel copyWith({
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
    return EventModel(
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

  factory EventModel.fromEntity(EventEntity model) {
    return EventModel(
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
}
