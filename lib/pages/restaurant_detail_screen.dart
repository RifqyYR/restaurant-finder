// In your restaurant_detail_screen.dart file
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_detail_provider.dart';
import 'package:submission_restaurant_app_1/state/restaurant_detail_result_state.dart';
import 'package:submission_restaurant_app_1/widgets/detail/restaurant_detail_appbar.dart';
import 'package:submission_restaurant_app_1/widgets/detail/restaurant_detail_content.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantDetailProvider>().fetchRestaurantDetail(
          widget.restaurantId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          final resultState = value.resultState;

          return switch (resultState) {
            RestaurantDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantDetailLoadedState(data: var restaurantDetail) =>
              CustomScrollView(
                slivers: [
                  RestaurantDetailAppBar(restaurantDetail: restaurantDetail),
                  RestaurantDetailContent(restaurantDetail: restaurantDetail),
                ],
              ),
            RestaurantDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
