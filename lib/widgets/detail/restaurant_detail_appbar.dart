import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/data/models/restaurant.dart';
import 'package:submission_restaurant_app_1/providers/theme_provider.dart';
import 'package:submission_restaurant_app_1/utils/image_urls.dart';

class RestaurantDetailAppBar extends StatelessWidget {
  final Restaurant restaurantDetail;

  const RestaurantDetailAppBar({super.key, required this.restaurantDetail});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
                  colors: <Color>[Color(0x00000000), Color(0x75000000)],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
