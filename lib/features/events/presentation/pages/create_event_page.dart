import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/cubits/app_user_cubit.dart';
import '../../../../core/common/utils/pick_image_file_from_gallery.dart';
import '../../../../core/common/utils/show_snackbar.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../../../../core/common/widgets/loading_indicator.dart';
import '../bloc/event_bloc.dart';
import '../widgets/location_picker.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final formKey = GlobalKey<FormState>();
  List<String> selectedEventTopics = [];
  double locationLatitude = 16.8409;
  double locationLongitude = 96.1735;
  File? imageFile;

  final nameTextEditingController = TextEditingController();
  final descriptionTextEditingController = TextEditingController();
  final locationTextEditingController = TextEditingController();
  final venueTextEditingController = TextEditingController();
  final dateTextEditingController = TextEditingController();
  final timeTextEditingController = TextEditingController();

  @override
  void dispose() {
    nameTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    locationTextEditingController.dispose();
    venueTextEditingController.dispose();
    dateTextEditingController.dispose();
    timeTextEditingController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    File? pickedImageFile = await pickImageFileFromGallery();
    if (pickedImageFile != null) {
      setState(() {
        imageFile = pickedImageFile;
      });
    }
  }

  Future<void> selectDate() async {
    DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

  void createEvent() {
    if (formKey.currentState!.validate()) {
      if (selectedEventTopics.isEmpty) {
        showSnackBar(context, "Please select at least one event topic.");
        return;
      }
      if (imageFile == null) {
        showSnackBar(context, "Please pick an image for event.");
        return;
      }
      final userId = (context.read<AppUserCubit>().state as AppUserSignedIn)
          .appUserEntity
          .id;
      context.read<EventBloc>().add(
            EventCreate(
              imageFile: imageFile!,
              userId: userId,
              name: nameTextEditingController.text.trim(),
              description: descriptionTextEditingController.text.trim(),
              topics: selectedEventTopics,
              location: locationTextEditingController.text.trim(),
              venueName: venueTextEditingController.text.trim(),
              coordinates: [
                locationLatitude.toString(),
                locationLongitude.toString()
              ],
              date: dateTextEditingController.text.trim(),
              time: timeTextEditingController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        centerTitle: true,
        title: const Text(
          "Create Event",
          style: AppFontStyles.headline4,
        ),
        actions: [
          IconButton(
            onPressed: createEvent,
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventFailure) {
              showSnackBar(context, state.message);
            }
            if (state is EventSuccess) {
              showSnackBar(context,
                  "Successfully created an event on ${state.eventEntity.date}.");
              context.pushReplacementNamed("/home");
            }
          },
          builder: (context, state) {
            if (state is EventLoading) {
              return const Center(
                child: LoadingIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: pickImage,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: (imageFile != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      size: 80,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "Click to upload image.",
                                      style:
                                          AppFontStyles.body2SemiBold.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
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
                          "Virtual",
                        ]
                            .map(
                              (eventTopic) => Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (!selectedEventTopics
                                          .contains(eventTopic)) {
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
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                    ),
                                    labelStyle:
                                        AppFontStyles.body2Regular.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    side: BorderSide(
                                      color: selectedEventTopics
                                              .contains(eventTopic)
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            style: AppFontStyles.body1Regular.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            controller: nameTextEditingController,
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
                            style: AppFontStyles.body1Regular.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            controller: descriptionTextEditingController,
                            cursorColor: Theme.of(context).colorScheme.primary,
                            keyboardType: TextInputType.text,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Event Description",
                              hintStyle: AppFontStyles.body1Regular.copyWith(
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
                            style: AppFontStyles.body1Regular.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            controller: locationTextEditingController,
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
                            style: AppFontStyles.body1Regular.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            controller: venueTextEditingController,
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
                                return "Please enter event venue name.";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Please pick location in map.",
                            style: AppFontStyles.body2SemiBold.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 400,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: LocationPicker(
                                latitude: locationLatitude,
                                longitude: locationLongitude,
                                onCoordinatesChanged: (latitude, longitude) {
                                  setState(() {
                                    locationLatitude = latitude;
                                    locationLongitude = longitude;
                                  });
                                },
                                zoomLevel: 12,
                                displayOnly: false,
                                markerColor:
                                    Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Please select date and time.",
                            style: AppFontStyles.body2SemiBold.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
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
                            height: 12,
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
