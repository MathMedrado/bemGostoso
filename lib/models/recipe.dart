class Recipe{
  int id;
  String title;
  String description;
  String preparationTime;
  String numberOfPortion;
  String preparationMethod;
  String categoryId;
  String author;
  String image;

  Recipe({
  required this.id,
  required this.title,
  required this.description,
  required this.preparationMethod,
  required this.numberOfPortion,
  required this.author,
  required this.categoryId,
  required this.preparationTime,
  required this.image
  });

  int get getId{
    return id;
  }

  String get getTitle{
    return title;
  }

  String get getDescription{
    return description;
  }
  String get getPreparationMethod{
    return preparationMethod;
  }
  String get getNumberOfPortion{
    return numberOfPortion;
  }
  String get getAuthor{
    return author;
  }
  String get getCategoryId{
    return categoryId;
  }
  String get getImage{
    return image;
  }
String get getPreparationTime{
  return preparationTime;
}

 


}