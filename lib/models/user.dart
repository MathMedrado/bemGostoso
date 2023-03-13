
class User{
  int id;
  String? username;
  String? perfilImage;
  String? email;
  String? password;
  String? phone;
  DateTime? birthDate;

  User({
    required this.id, 
    required this.username,
    required this.perfilImage, 
    required this.email, 
    required this.password, 
    required this.phone, 
    required this.birthDate,
  });

  // User.empty(){
  //   this.id = 0;
  //   this.email = "";
  //   this.username = "";
  //   this.perfilImage = "";
  //   this.email ="";
  //   this.password = "";
  //   this.phone = "";
  //   this.birthDate = DateTime.now();
  // };


  factory User.fromJson(Map json){
    return User(
      id: json['id'], 
      username: json['username'], 
      perfilImage: json['perfilImage'], 
      email: json['email'], 
      password: json['password'], 
      phone: json['phone'],
      birthDate: json['birthDate'], 
    );
  }

  Map toJson(){
    return {
      'id': id,
      'username' : username,
      'perfilImage' : perfilImage,
      'email' : email,
      'password' : password,
      'phone' : phone,
      'birthDate' : birthDate,
    };
  }
  int get getId{
    return id;
  }

  String? get getUsername{
    return username;
  }

  String? get getEmail{
    return email;
  }

  String? get getPassword{
    return password;
  }


  String? get getPhone{
    return phone;
  }

  String? get getPerfilImage{
    return perfilImage;
  }
 
  DateTime? get getBirthDate{
    return birthDate;
  }

}