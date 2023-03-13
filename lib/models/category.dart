class Category{
  int id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image
  });

  int get getId{
    return id;
  }

  String get getName{
    return name;
  }

  String get getImage{
    return image;
  }

}