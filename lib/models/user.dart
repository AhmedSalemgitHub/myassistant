
class User {

  int id;
  String username;
  String password ;
  String email ;
  int age  ;

  User(this.username, this.password, this.email, this.age);

  User.map(dynamic obj){
    this.username = obj['username'];
    this.password = obj['password'];
    this.email = obj['email'];
    this.age = obj['age'];
    this.id = obj['id'];
  }

  String get  _username => username;
  String get  _password => password;
  String get _email => email;
  int get _age  => age; 
  int get _id  => id; 

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map['username'] = _username;
    map['password'] = _password;
    map['email'] = _email;
    map['id'] = _id;
    map['age'] = _age;

    if (id != null ) {
      map['id'] = _id;
    }
    return map;
  }

  User.fromMap(Map<String,dynamic> map){
    this.username = map['username'];
    this.password = map['password'];
    this.email = map['email'];
    this.age = map['age'];
    this.id = map['id'];
  }

}