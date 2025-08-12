sealed class AddReviewState {}

class AddReviewNoneState extends AddReviewState {}

class AddReviewLoadingState extends AddReviewState {}

class AddReviewErrorState extends AddReviewState {
  final String error;

  AddReviewErrorState({required this.error});
}

class AddReviewLoadedState extends AddReviewState {
  final String message;

  AddReviewLoadedState({required this.message});
}
