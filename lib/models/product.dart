class Product {
  int? id;
  String? nama;
  String? image;
  String? deskripsi;
  String? harga;
  int? idKategori;
  String? jumlahTerjual;
  double? rating;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.nama,
      this.image,
      this.deskripsi,
      this.harga,
      this.idKategori,
      this.jumlahTerjual,
      this.rating,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    image = json['image'];
    deskripsi = json['deskripsi'];
    harga = json['harga'];
    idKategori = json['id_kategori'];
    jumlahTerjual = json['jumlah_terjual'];
    // if (json['rating'] != null) {
    //   rating = double.tryParse(json['rating']);
    // }
    rating = json['rating'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['image'] = this.image;
    data['deskripsi'] = this.deskripsi;
    data['harga'] = this.harga;
    data['id_kategori'] = this.idKategori;
    data['jumlah_terjual'] = this.jumlahTerjual;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
