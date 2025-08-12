import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_search_provider.dart';
import 'package:submission_restaurant_app_1/state/restaurant_search_state.dart';
import 'package:submission_restaurant_app_1/utils/image_urls.dart';

class RestaurantListContent extends StatelessWidget {
  const RestaurantListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, value, child) {
        return switch (value.resultState) {
          RestaurantSearchLoadingState() => SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
          RestaurantSearchLoadedState(data: var restaurantList) => SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final restaurant = restaurantList[index];
              return InkWell(
                onTap:
                    () => Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: restaurant.id,
                    ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Hero(
                          tag: restaurant.pictureId!,
                          child: Image.network(
                            imageGenerator(restaurant.pictureId!, 1),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name!,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium!.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    restaurant.city!,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall!.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
              );
            }, childCount: restaurantList.length),
          ),
          RestaurantSearchErrorState(error: var message) => SliverToBoxAdapter(
            child: Center(
              child: Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          _ => SliverToBoxAdapter(child: const SizedBox()),
        };
      },
    );
  }
}
