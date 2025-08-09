import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/providers/theme_provider.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_list_provider.dart';
import 'package:submission_restaurant_app_1/state/restaurant_list_result_state.dart';
import 'package:submission_restaurant_app_1/utils/image_urls.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantListProvider>().fetchRestaurantList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:
            () => context.read<RestaurantListProvider>().fetchRestaurantList(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text(
                "Restaurant Finder",
                style: TextTheme.of(context).titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    context.watch<ThemeProvider>().isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    final provider = context.read<ThemeProvider>();
                    provider.toggleTheme(!provider.isDarkMode);
                  },
                ),
              ],
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => SliverToBoxAdapter(
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height - kToolbarHeight,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  RestaurantListLoadedState(data: var restaurantList) =>
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final restaurant = restaurantList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: GestureDetector(
                            onTap:
                                () => Navigator.pushNamed(
                                  context,
                                  '/detail',
                                  arguments: restaurant.id,
                                ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Hero(
                                        tag: restaurant.pictureId!,
                                        child: Image.network(
                                          imageGenerator(
                                            restaurant.pictureId!,
                                            1,
                                          ),
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: SizedBox(
                                        height: 80,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  restaurant.name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onSurface,
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  restaurant.city!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onSurface,
                                                      ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.orangeAccent,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  restaurant.rating.toString(),
                                                  style: TextStyle(
                                                    color:
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.onSurface,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }, childCount: restaurantList.length),
                    ),
                  RestaurantListErrorState(error: var message) =>
                    SliverToBoxAdapter(child: Center(child: Text(message))),
                  _ => SliverToBoxAdapter(child: const SizedBox()),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
