class PatientTreated {
  int? key;
  int? stt;
  String? sId;
  String? name;
  int? age;
  String? phone;
  String? cCCD;
  HospitalId? hospitalId;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? gender;

  PatientTreated(
      {this.key,
        this.stt,
        this.sId,
        this.name,
        this.age,
        this.phone,
        this.cCCD,
        this.hospitalId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.gender});

  PatientTreated.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    stt = json['stt'];
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    phone = json['phone'];
    cCCD = json['CCCD'];
    hospitalId = json['hospital_id'] != null
        ? new HospitalId.fromJson(json['hospital_id'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['stt'] = this.stt;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['CCCD'] = this.cCCD;
    if (this.hospitalId != null) {
      data['hospital_id'] = this.hospitalId!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['gender'] = this.gender;
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
