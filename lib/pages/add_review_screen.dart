import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restaurant_app_1/providers/add_review_provider.dart';
import 'package:submission_restaurant_app_1/state/add_review_state.dart';
import 'package:submission_restaurant_app_1/widgets/add%20review/add_review_appbar.dart';

class AddReviewScreen extends StatelessWidget {
  final String restaurantId;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  AddReviewScreen({super.key, required this.restaurantId});

  void _submitReview(BuildContext context) {
    final String name = _nameController.text;
    final String review = _reviewController.text;

    if (name.isEmpty || review.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Nama dan Review tidak boleh kosong!'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    context.read<AddReviewProvider>().addReview(restaurantId, name, review);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AddReviewAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Anda',
                      hintText: 'Masukkan nama Anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    maxLines: 5,
                    controller: _reviewController,
                    decoration: InputDecoration(
                      labelText: 'Review',
                      hintText: 'Tuliskan review Anda',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.maxFinite,
                    child: Consumer<AddReviewProvider>(
                      builder: (context, provider, child) {
                        final resultState = provider.resultState;

                        if (resultState is AddReviewLoadingState) {
                          return ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          );
                        } else if (resultState is AddReviewLoadedState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _nameController.clear();
                            _reviewController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(resultState.message),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                            provider.resetState();
                          });
                          return ElevatedButton(
                            onPressed: () => _submitReview(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              "Kirim",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          );
                        } else if (resultState is AddReviewErrorState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(resultState.error),
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            provider.resetState();
                          });
                          return ElevatedButton(
                            onPressed: () => _submitReview(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              "Kirim",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          );
                        } else {
                          return ElevatedButton(
                            onPressed: () => _submitReview(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              "Kirim",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
