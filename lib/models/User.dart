class User {
  final String username;
  final String email;
  final String imagePath;
  final String location;
  final String firstName;

  var imageDownloadUrl;

  User(
      {required this.username,
      required this.email,
      required this.imagePath,
      required this.location,
      required this.firstName,
      String? imageDownloadUrl});
}
