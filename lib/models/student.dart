
class Student {

  int id;
  String name;
  String classRoom ;
  String mobile ;
  int age  ;

  Student(this.name, this.classRoom, this.mobile, this.age);

  Student.map(dynamic obj){
    this.name = obj['student'];
    this.classRoom = obj['class'];
    this.mobile = obj['mobile'];
    this.age = obj['age'];
    this.id = obj['id'];
  }

  String get  _name => name;
  String get  _classRoom => classRoom;
  String get _mobile => mobile;
  int get _age  => age; 
  int get _id  => id; 

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map['student'] = _name;
    map['class'] = _classRoom;
    map['mobile'] = _mobile;
    map['id'] = _id;
    map['age'] = _age;

    if (id != null ) {
      map['id'] = _id;
    }
    return map;
  }

  Student.fromMap(Map<String,dynamic> map){
    this.name = map['student'];
    this.classRoom = map['class'];
    this.mobile = map['mobile'];
    this.age = map['age'];
    this.id = map['id'];
  }

}