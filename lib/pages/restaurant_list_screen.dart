import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_list_provider.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_search_provider.dart';
import 'package:submission_restaurant_app_1/widgets/home/restaurant_list_appbar.dart';
import 'package:submission_restaurant_app_1/widgets/home/restaurant_list_content.dart';
import 'package:submission_restaurant_app_1/widgets/home/restaurant_search_bar.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantSearchProvider>().fetchSearchedRestaurantList(
          '',
        );
      }
    });
  }

  void Function(String) _searchRestaurant() {
    return (String value) {
      context.read<RestaurantSearchProvider>().fetchSearchedRestaurantList(
        value,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh:
              () =>
                  context.read<RestaurantListProvider>().fetchRestaurantList(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              RestaurantListAppbar(),
              RestaurantSearchBar(
                searchController: _searchController,
                onSubmitted: _searchRestaurant(),
              ),
              RestaurantListContent(),
            ],
          ),
        ),
      ),
    );
  }
}
