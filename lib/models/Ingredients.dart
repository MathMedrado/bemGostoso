class Ingredients{
  int id;
  List<String> name;

  Ingredients({
    required this.id,
    required this.name,
  });

  int get getId{
    return id;
  }

  List<String> get getName{
    return name;
  }

}