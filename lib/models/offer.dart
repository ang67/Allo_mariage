class Offer {
  final String id;
  final String name;
  final String providerId;
  final String description;
  final String srvCategory;
  final List<String> listPhotoURL;
  final DateTime publishedDate;

  Offer(
      {this.id,
      this.name,
      this.providerId,
      this.description,
      this.srvCategory,
      this.listPhotoURL,
      this.publishedDate});
}
