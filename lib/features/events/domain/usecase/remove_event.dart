import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/event_repository.dart';

class RemoveEvent implements UseCase<Unit, String> {
  final EventRepository eventRepository;

  RemoveEvent({
    required this.eventRepository,
  });

  @override
  Future<Either<Failure, Unit>> call(String eventId) async {
    return await eventRepository.removeEvent(eventId);
  }

}