String imageGenerator(String pictureId, int resolutionType) {
  switch (resolutionType) {
    case 1:
      return "https://restaurant-api.dicoding.dev/images/small/$pictureId";
    case 2:
      return "https://restaurant-api.dicoding.dev/images/medium/$pictureId";
    case 3:
      return "https://restaurant-api.dicoding.dev/images/large/$pictureId";
    default:
      return "https://restaurant-api.dicoding.dev/images/small/$pictureId";
  }
}
