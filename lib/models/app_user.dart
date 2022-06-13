class AppUser {
  String? uid;
  String? name;
  String? email;
  String? userName;
  String? status;
  int? state;
  String? profilePhoto;

  AppUser({
    this.uid,
    this.email,
    this.name,
    this.profilePhoto,
    this.state,
    this.status,
    this.userName,
  });

  Map<String,dynamic> toMap(AppUser user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.userName;
    data['status'] = user.status;
    data['state'] = user.state;
    data['profilephoto'] = user.profilePhoto;
    return data;
  }

  AppUser.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    name = map['name'];
    profilePhoto = map['profilephoto'];
    state = map['state'];
    status = map['status'];
    userName = map['username'];
    uid = map['uid'];
  }
}
