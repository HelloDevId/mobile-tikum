import 'package:tikum_mobile/models/user.dart';

class Reservasi {
  int? id;
  int? idUser;
  int? idMeja;
  String? tanggal;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  Meja? meja;

  Reservasi(
      {this.id,
      this.idUser,
      this.idMeja,
      this.tanggal,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.meja});

  Reservasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idMeja = json['id_meja'];
    tanggal = json['tanggal'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    meja = json['meja'] != null ? new Meja.fromJson(json['meja']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_meja'] = this.idMeja;
    data['tanggal'] = this.tanggal;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.meja != null) {
      data['meja'] = this.meja!.toJson();
    }
    return data;
  }
}

class Meja {
  int? id;
  int? noMeja;
  String? createdAt;
  String? updatedAt;

  Meja({this.id, this.noMeja, this.createdAt, this.updatedAt});

  Meja.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noMeja = json['no_meja'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_meja'] = this.noMeja;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
