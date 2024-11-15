import 'package:flutter/material.dart';

import '../../../../core/theme/app_font_styles.dart';
import '../../domain/entity/event_entity.dart';
import '../widgets/location_picker.dart';

class EditEventBottomSheet extends StatefulWidget {
  final EventEntity eventEntity;
  final Function(EventEntity) onEditEvent;

  const EditEventBottomSheet({
    super.key,
    required this.eventEntity,
    required this.onEditEvent,
  });

  @override
  State<EditEventBottomSheet> createState() => _EditEventBottomSheetState();
}

class _EditEventBottomSheetState extends State<EditEventBottomSheet> {
  final formKey = GlobalKey<FormState>();

  final nameTextEditingController = TextEditingController();
  final descriptionTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final venueNameTextEditingController = TextEditingController();
  final dateTextEditingController = TextEditingController();
  final timeTextEditingController = TextEditingController();

  List<String> selectedEventTopics = [];
  double locationLatitude = 0.0;
  double locationLongitude = 0.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      nameTextEditingController.text = widget.eventEntity.name;
      descriptionTextEditingController.text = widget.eventEntity.description;
      locationTextEditingController.text = widget.eventEntity.location;
      venueNameTextEditingController.text = widget.eventEntity.venueName;
      dateTextEditingController.text = widget.eventEntity.date;
      selectedEventTopics = widget.eventEntity.topics;
      locationLatitude = double.parse(widget.eventEntity.coordinates.first);
      locationLongitude = double.parse(widget.eventEntity.coordinates.last);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (timeTextEditingController.text.isEmpty) {
      timeTextEditingController.text = widget.eventEntity.time;
    }
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    locationTextEditingController.dispose();
    venueNameTextEditingController.dispose();
    dateTextEditingController.dispose();
    timeTextEditingController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(dateTextEditingController.text),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDateTime != null) {
      setState(() {
        dateTextEditingController.text =
        selectedDateTime.toString().split(" ")[0];
      });
    }
  }

  Future<void> selectTime() async {
    TimeOfDay? selectedTimeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (selectedTimeOfDay != null) {
      setState(() {
        timeTextEditingController.text = selectedTimeOfDay.format(context);
      });
    }
  }

  void updateEvent() {
    if (formKey.currentState!.validate()) {
      final name = nameTextEditingController.text.trim();
      final description =
      descriptionTextEditingController.text.trim();
      final location = locationTextEditingController.text.trim();
      final venueName = venueNameTextEditingController.text.trim();
      final date = dateTextEditingController.text.trim();
      final time = timeTextEditingController.text.trim();
      final editedEvent = widget.eventEntity.copyWith(
        name: name,
        description: description,
        topics: selectedEventTopics,
        location: location,
        venueName: venueName,
        coordinates: [
          locationLatitude.toString(),
          locationLongitude.toString(),
        ],
        date: date,
        time: time,
      );
      Navigator.pop(context);
      widget.onEditEvent(editedEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewPadding.top,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    "Community",
                    "Social",
                    "Corporate",
                    "Entertainment",
                    "Cultural",
                    "Educational",
                    "Sports",
                    "Charity",
                  ]
                      .map(
                        (eventTopic) => Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedEventTopics.contains(eventTopic)) {
                                  selectedEventTopics.add(eventTopic);
                                } else {
                                  selectedEventTopics.remove(eventTopic);
                                }
                              });
                            },
                            child: Chip(
                              color: WidgetStatePropertyAll(
                                selectedEventTopics.contains(eventTopic)
                                    ? Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer
                                    : Theme.of(context).colorScheme.surface,
                              ),
                              labelStyle: AppFontStyles.body2Regular.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              side: BorderSide(
                                color: selectedEventTopics.contains(eventTopic)
                                    ? Colors.transparent
                                    : Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                              ),
                              label: Text(eventTopic),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameTextEditingController,
                style: AppFontStyles.body1Regular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                cursorColor: Theme.of(context).colorScheme.primary,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Event Name",
                  hintStyle: AppFontStyles.body1Regular.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20.0),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter event name.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionTextEditingController,
                style: AppFontStyles.body1Regular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                maxLines: null,
                cursorColor: Theme.of(context).colorScheme.primary,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Event Description",
                  hintStyle: AppFontStyles.body1Regular.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20.0),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter event description.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: locationTextEditingController,
                style: AppFontStyles.body1Regular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                cursorColor: Theme.of(context).colorScheme.primary,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Event Location",
                  hintStyle: AppFontStyles.body1Regular.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20.0),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter event location.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: venueNameTextEditingController,
                style: AppFontStyles.body1Regular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                cursorColor: Theme.of(context).colorScheme.primary,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Event Venue Name",
                  hintStyle: AppFontStyles.body1Regular.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20.0),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter venue name.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 240.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: LocationPicker(
                    latitude: locationLatitude,
                    longitude: locationLongitude,
                    onCoordinatesChanged: (lat, long) {
                      setState(() {
                        locationLatitude = lat;
                        locationLongitude = long;
                      });
                    },
                    displayOnly: false,
                    markerColor: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                onTap: selectDate,
                style: AppFontStyles.body1Regular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                controller: dateTextEditingController,
                decoration: InputDecoration(
                  labelText: "Select Event Date",
                  labelStyle: AppFontStyles.body1Regular.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color:
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .errorContainer,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .errorContainer,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20.0),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please select event date.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                onTap: selectTime,
                style: AppFontStyles.body1Regular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                controller: timeTextEditingController,
                decoration: InputDecoration(
                  labelText: "Select Event Time",
                  labelStyle: AppFontStyles.body1Regular.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color:
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .errorContainer,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .errorContainer,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20.0),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please select event time.";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: updateEvent,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    foregroundColor: Theme.of(context).colorScheme.onTertiary),
                child: const Text(
                  "Save",
                  style: AppFontStyles.buttonLarge,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
