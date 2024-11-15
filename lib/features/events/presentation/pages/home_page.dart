import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../core/common/utils/show_dialog.dart';
import '../../../../core/common/utils/show_snackbar.dart';
import '../../../../core/common/widgets/error_indicator.dart';
import '../../../../core/common/widgets/loading_indicator.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/events_bloc/events_bloc.dart';
import '../widgets/event_card.dart';
import '../widgets/options_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getAllEvents();
  }

  void getAllEvents() {
    context.read<EventsBloc>().add(EventsGetAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        leading: IconButton(
          onPressed: () {
            showCustomDialog(
              context: context,
              alignment: Alignment.topLeft,
              content: const OptionsDialog(),
            );
          },
          icon: const Icon(Icons.more_vert_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed("/create_event");
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Eventify",
          style: AppFontStyles.headline4,
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showSnackBar(context, "Signing out from the account...");
          }
          if (state is AuthSignOutSuccess) {
            showSnackBar(context, "Successfully signed out from the account.");
          }
          if (state is AuthFailure) {
            showSnackBar(context, state.errorMessage);
          }
        },
        child: BlocConsumer<EventsBloc, EventsState>(
          listener: (context, state) {
            if (state is EventsFailure) {
              showSnackBar(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is EventsLoading) {
              return const Center(
                child: LoadingIndicator(),
              );
            }
            if (state is EventsFailure) {
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
                        getAllEvents();
                      },
                      child: const Text(
                        "Refresh",
                        style: AppFontStyles.buttonMedium,
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is EventsSuccess) {
              return Column(
                children: [
                  Expanded(
                    child: state.eventEntities.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "This place will be filled with events...",
                                  style: AppFontStyles.body1Regular.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                  onPressed: () {
                                    getAllEvents();
                                  },
                                  child: const Text(
                                    "Refresh",
                                    style: AppFontStyles.buttonMedium,
                                  ),
                                )
                              ],
                            ),
                          )
                        : LiquidPullToRefresh(
                            onRefresh: () async {
                              context.read<EventsBloc>().add(EventsGetAll());
                            },
                            showChildOpacityTransition: false,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: state.eventEntities.length,
                              itemBuilder: (context, index) {
                                final event = state.eventEntities[index];
                                return EventCard(
                                  event: event,
                                  onTap: (eventId) {
                                    context.pushNamed(
                                      "/event_details",
                                      pathParameters: {
                                        "event_id": eventId,
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
