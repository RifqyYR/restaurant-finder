import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/providers/restaurant_detail_provider.dart';
import 'package:submission_restaurant_app_1/providers/theme_provider.dart';
import 'package:submission_restaurant_app_1/state/restaurant_detail_result_state.dart';
import 'package:submission_restaurant_app_1/utils/image_urls.dart';

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
      body: CustomScrollView(
        slivers: [
          Consumer<RestaurantDetailProvider>(
            builder: (context, value, child) {
              return switch (value.resultState) {
                RestaurantDetailLoadingState() => SliverFillRemaining(
                  child: const Center(child: CircularProgressIndicator()),
                ),

                RestaurantDetailLoadedState(data: var restaurantDetail) =>
                  SliverAppBar(
                    expandedHeight: 250,
                    pinned: true,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          context.watch<ThemeProvider>().isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          final provider = context.read<ThemeProvider>();
                          provider.toggleTheme(!provider.isDarkMode);
                        },
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        restaurantDetail.name ?? 'Tanpa Nama',
                        style: const TextStyle(color: Colors.white),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Hero(
                            tag: restaurantDetail.pictureId ?? '',
                            child: Image.network(
                              imageGenerator(restaurantDetail.pictureId!, 2),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.0, -1.0),
                                end: Alignment(0.0, 0.6),
                                colors: <Color>[
                                  Color(0x00000000),
                                  Color(0x75000000),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                RestaurantDetailErrorState(error: var message) =>
                  SliverFillRemaining(child: Center(child: Text(message))),

                _ => SliverFillRemaining(child: const SizedBox()),
              };
            },
          ),
          Consumer<RestaurantDetailProvider>(
            builder: (context, value, child) {
              if (value.resultState is RestaurantDetailLoadedState) {
                final restaurantDetail =
                    (value.resultState as RestaurantDetailLoadedState).data;
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurantDetail.name ?? 'Tanpa Nama',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              restaurantDetail.city ?? 'Tidak Diketahui',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurantDetail.rating?.toString() ??
                                  'Tidak ada penilaian',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Deskripsi',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          restaurantDetail.description ?? 'Tidak ada deskripsi',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
