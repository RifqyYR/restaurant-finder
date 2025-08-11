import 'package:flutter/material.dart';

class RestaurantSearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final void Function(String) onSubmitted;

  const RestaurantSearchBar({super.key, required this.searchController, required this.onSubmitted});

  @override
  State<RestaurantSearchBar> createState() => _RestaurantSearchBarState();
}

class _RestaurantSearchBarState extends State<RestaurantSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

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
          focusNode: _focusNode,
          controller: widget.searchController,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: 'Cari resto',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIconColor:
                _isFocused
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
