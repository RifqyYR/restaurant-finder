import 'package:flutter/material.dart';

class RestaurantSearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final void Function(String) onSubmitted;

  const RestaurantSearchBar({
    super.key,
    required this.searchController,
    required this.onSubmitted,
  });

  @override
  State<RestaurantSearchBar> createState() => _RestaurantSearchBarState();
}

class _RestaurantSearchBarState extends State<RestaurantSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 55,
        child: TextField(
          controller: widget.searchController,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: 'Cari resto',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}
