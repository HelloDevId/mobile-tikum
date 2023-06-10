class User {
  int? id;
  String? nama;
  String? email;
  // int? idRole;
  String? noHp;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.nama,
      this.email,
      // this.idRole,
      this.noHp,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    // idRole = int.parse(json['id_role']);
    noHp = json['no_hp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['email'] = this.email;
    // data['id_role'] = this.idRole;
    data['no_hp'] = this.noHp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
