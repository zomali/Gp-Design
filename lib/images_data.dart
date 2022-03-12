class Image {
  final String title;
  final String source;
  final String imageURL;
  //Constructor
  const Image({
    required this.title,
    required this.source,
    required this.imageURL
  });
}
var Images = [
  new Image(
      title: 'Variable in C++',
      source: 'geeksforgeeks',
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2F1.1.2.jpg?alt=media&token=d703e865-5f01-40ef-a493-9bb3bce9cf21'
),
  new Image(
      title: 'Namespaces in C++',
     source: 'Neso Academy',
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2F1.1.1.jpg?alt=media&token=4234d183-67b4-4ecf-b49b-c6f536f85c91'
  ),
  new Image(
      title: 'Constant in C++',
      source: 'masterofcplusplus',
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2F1.1.3.png?alt=media&token=5772aa10-16e7-4fc7-a16b-e7abb82e0629'
  ),
];