import 'package:bemgostoso/models/Ingredients.dart';


class Recipe{
  int id;
  String title;
  String preparationTime;
  String numberOfPortion;
  String preparationMethod;
  int categoryId;
  String categoryName;
  int authorId;
  String author;
  String image;
  List<String> Ingredients;

  Recipe({
  required this.id,
  required this.title,
  required this.preparationMethod,
  required this.numberOfPortion,
  required this.author,
  required this.authorId,
  required this.categoryId,
  required this.categoryName,
  required this.preparationTime,
  required this.image,
  required this.Ingredients
  });

  int get getId{
    return id;
  }

  String get getTitle{
    return title;
  }

  String get getCategoryName{
    return categoryName;
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
  int get getCategoryId{
    return categoryId;
  }
  String get getImage{
    return image;
  }
String get getPreparationTime{
  return preparationTime;
}
List<String> get getIngredients {
  return Ingredients;
}
int get getAuthorId{
  return authorId;
}

 
}