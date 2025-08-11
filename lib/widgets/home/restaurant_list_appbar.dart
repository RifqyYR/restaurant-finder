import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/providers/theme_provider.dart';

class RestaurantListAppbar extends StatelessWidget {
  const RestaurantListAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo, Selamat datang!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  "Temukan restoran favoritmu di sini.",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(
                      alpha: 0.8,
                    ), // Membuat warna sedikit pudar
                  ),
                ),
              ],
            ),
            Consumer<ThemeProvider>(
              builder:
                  (context, themeProvider, _) => IconButton(
                    icon: Icon(
                      context.watch<ThemeProvider>().isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      final provider = context.read<ThemeProvider>();
                      provider.toggleTheme(!provider.isDarkMode);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
