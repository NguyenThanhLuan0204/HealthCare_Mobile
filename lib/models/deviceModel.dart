class Device {
  int? key;
  int? stt;
  String? sId;
  String? nameDevice;
  String? ipMac;
  bool? status;
  HospitalId? hospitalId;
  String? createdAt;
  String? updatedAt;
  PatientCccd? patientCccd;

  Device(
      {this.key,
        this.stt,
        this.sId,
        this.nameDevice,
        this.ipMac,
        this.status,
        this.hospitalId,
        this.createdAt,
        this.updatedAt,
        this.patientCccd});

  Device.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    stt = json['stt'];
    sId = json['_id'];
    nameDevice = json['name_device'];
    ipMac = json['ip_mac'];
    status = json['status'];
    hospitalId = json['hospital_id'] != null
        ? new HospitalId.fromJson(json['hospital_id'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    patientCccd = json['patient_cccd'] != null
        ? new PatientCccd.fromJson(json['patient_cccd'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['stt'] = this.stt;
    data['_id'] = this.sId;
    data['name_device'] = this.nameDevice;
    data['ip_mac'] = this.ipMac;
    data['status'] = this.status;
    if (this.hospitalId != null) {
      data['hospital_id'] = this.hospitalId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.patientCccd != null) {
      data['patient_cccd'] = this.patientCccd!.toJson();
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

class PatientCccd {
  String? name;
  int? age;
  String? phone;
  String? cCCD;
  String? hospitalId;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? gender;
  String? id;

  PatientCccd(
      {this.name,
        this.age,
        this.phone,
        this.cCCD,
        this.hospitalId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.gender,
        this.id});

  PatientCccd.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    phone = json['phone'];
    cCCD = json['CCCD'];
    hospitalId = json['hospital_id'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    gender = json['gender'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['CCCD'] = this.cCCD;
    data['hospital_id'] = this.hospitalId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['gender'] = this.gender;
    data['id'] = this.id;
    return data;
  }
}
