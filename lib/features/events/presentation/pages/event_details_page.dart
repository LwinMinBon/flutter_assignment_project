import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/cubits/app_user_cubit.dart';
import '../../../../core/common/utils/show_snackbar.dart';
import '../../../../core/common/widgets/error_indicator.dart';
import '../../../../core/common/widgets/loading_indicator.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../bloc/event_bloc.dart';
import '../bloc/events_bloc.dart';
import '../widgets/location_picker.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventId;

  const EventDetailsPage({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  void initState() {
    super.initState();
    getEvent();
  }

  void getAllEvents() {
    context.read<EventsBloc>().add(EventsGetAll());
  }

  void getEvent() {
    context.read<EventBloc>().add(EventGet(eventId: widget.eventId));
  }

  void deleteEvent(String eventId) {
    context.read<EventBloc>().add(EventRemove(eventId: eventId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventRemoveSuccess) {
            context.pop();
            getAllEvents();
          }
          if (state is EventRemoveFailure) {
            showSnackBar(context, state.errorMessage);
            getEvent();
          }
        },
        builder: (context, state) {
          if (state is EventLoading) {
            return const Center(
              child: LoadingIndicator(),
            );
          }
          if (state is EventFailure) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ErrorIndicator(
                    errorMessage: state.errorMessage,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    onPressed: () {
                      getEvent();
                    },
                    child: const Text(
                      "Refresh",
                      style: AppFontStyles.buttonMedium,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is EventSuccess) {
            final eventEntity = state.eventEntity;
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 240.0,
                          child: Stack(
                            children: [
                              Image.network(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                eventEntity.imageUrl,
                              ),
                              Positioned(
                                left: 12.0,
                                top: MediaQuery.of(context).viewPadding.top,
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    foregroundColor:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon:
                                      const Icon(Icons.arrow_back_ios_rounded),
                                ),
                              ),
                              Positioned(
                                right: 12.0,
                                top: MediaQuery.of(context).viewPadding.top,
                                child: BlocBuilder<AppUserCubit, AppUserState>(
                                  builder: (context, state) {
                                    if (state is AppUserSignedIn) {
                                      return Visibility(
                                        visible: state.appUserEntity.id ==
                                            eventEntity.userId,
                                        child: IntrinsicWidth(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                style: IconButton.styleFrom(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                  foregroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                ),
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.edit_rounded),
                                              ),
                                              IconButton(
                                                style: IconButton.styleFrom(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                  foregroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                ),
                                                onPressed: () {
                                                  deleteEvent(eventEntity.id);
                                                },
                                                icon: const Icon(
                                                    Icons.delete_rounded),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(
                                  bottom: 12.0,
                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: eventEntity.topics
                                        .map(
                                          (topic) => Container(
                                            margin: const EdgeInsets.only(
                                                right: 4.0),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiaryContainer,
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(100.0),
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0,
                                              vertical: 8.0,
                                            ),
                                            child: Text(
                                              topic,
                                              style: AppFontStyles
                                                  .footnoteSemibold
                                                  .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 12.0,
                          ),
                          color: Theme.of(context).colorScheme.surface,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eventEntity.name,
                                    style: AppFontStyles.headline4.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_today_rounded,
                                            size: 20.0,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            eventEntity.date,
                                            style: AppFontStyles.body1Regular
                                                .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 20.0,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            eventEntity.time,
                                            style: AppFontStyles.body1Regular
                                                .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About this event",
                                    style: AppFontStyles.title.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    eventEntity.description,
                                    style: AppFontStyles.body1Regular.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Location",
                                    style: AppFontStyles.title.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 20.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        "${eventEntity.location}, ${eventEntity.venueName}",
                                        style:
                                            AppFontStyles.body1Regular.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 240.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: LocationPicker(
                                        latitude: double.parse(
                                            eventEntity.coordinates.first),
                                        longitude: double.parse(
                                            eventEntity.coordinates.last),
                                        onCoordinatesChanged: (lat, long) {},
                                        displayOnly: true,
                                        markerColor: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Organizer Info",
                                    style: AppFontStyles.title.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_rounded,
                                        size: 20.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        eventEntity.posterUsername ?? "Unknown",
                                        style:
                                            AppFontStyles.body1Regular.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.email_rounded,
                                        size: 20.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        eventEntity.posterEmail ?? "Unknown",
                                        style:
                                            AppFontStyles.body1Regular.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone_rounded,
                                        size: 20.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        eventEntity.posterPhoneNumber ??
                                            "Unknown",
                                        style:
                                            AppFontStyles.body1Regular.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 120.0,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 80.0,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onTertiary,
                              ),
                              child: const Text(
                                "Register",
                                style: AppFontStyles.buttonLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
