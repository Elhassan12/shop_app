class LoginModel {
 late bool status;
 dynamic message;
 UserData? data;
 LoginModel(Map<String,dynamic> model)
 {
   status=model['status'];
   message=model['message'];
   data = (model["data"]!=null ? UserData.formJson(model["data"]): null);

 }
}

class UserData {
   int? id;
   String? name;
   String? email;
   String? phone;
   String? image;
   int? points;
   int? credit;
   String? token;

  UserData.formJson(Map<String, dynamic> json)
  {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
