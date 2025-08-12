import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/providers/theme_provider.dart';

class AddReviewAppbar extends StatelessWidget {
  const AddReviewAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text("Beri Ulasan", style: TextStyle(color: Colors.white)),
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
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
