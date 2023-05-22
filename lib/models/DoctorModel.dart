class Doctor {
  String? key;
  int? stt;
  String? sId;
  String? name;
  String? phone;
  String? specialist;
  String? email;
  String? createdAt;
  String? updatedAt;
  HospitalId? hospitalId;

  Doctor(
      {this.key,
        this.stt,
        this.sId,
        this.name,
        this.phone,
        this.specialist,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.hospitalId});

  Doctor.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    stt = json['stt'];
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    specialist = json['specialist'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    hospitalId = json['hospital_id'] != null
        ? new HospitalId.fromJson(json['hospital_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['stt'] = this.stt;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['specialist'] = this.specialist;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.hospitalId != null) {
      data['hospital_id'] = this.hospitalId!.toJson();
    }
    return data;
  }
}

class HospitalId {
  String? name;
  String? address;
  String? phone;

  HospitalId({this.name, this.address, this.phone});

  HospitalId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}
