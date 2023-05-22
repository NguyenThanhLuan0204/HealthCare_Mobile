class MedRecord {
  int? key;
  String? sId;
  List<int>? vitalSigns;
  Patient? patient;
  Doctor? doctor;
  Hospital? hospital;
  IotId? iotId;
  String? dateStart;
  String? dateEnd;
  double? target;
  int? status;
  String? createdAt;
  String? updatedAt;

  MedRecord(
      {this.key,
        this.sId,
        this.vitalSigns,
        this.patient,
        this.doctor,
        this.hospital,
        this.iotId,
        this.dateStart,
        this.dateEnd,
        this.target,
        this.status,
        this.createdAt,
        this.updatedAt});

  MedRecord.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    sId = json['_id'];
    vitalSigns = json['vital_signs'].cast<int>();
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
    iotId = json['iot_id'] != null ? new IotId.fromJson(json['iot_id']) : null;
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    target = json['target'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['_id'] = this.sId;
    data['vital_signs'] = this.vitalSigns;
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.hospital != null) {
      data['hospital'] = this.hospital!.toJson();
    }
    if (this.iotId != null) {
      data['iot_id'] = this.iotId!.toJson();
    }
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['target'] = this.target;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Patient {
  String? name;
  int? age;
  int? gender;
  String? phone;
  String? cCCD;
  String? hospitalId;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? id;

  Patient(
      {this.name,
        this.age,
        this.gender,
        this.phone,
        this.cCCD,
        this.hospitalId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.id});

  Patient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    phone = json['phone'];
    cCCD = json['CCCD'];
    hospitalId = json['hospital_id'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['CCCD'] = this.cCCD;
    data['hospital_id'] = this.hospitalId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Doctor {
  String? name;
  String? phone;
  String? specialist;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? hospitalId;
  String? id;

  Doctor(
      {this.name,
        this.phone,
        this.specialist,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.hospitalId,
        this.id});

  Doctor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    specialist = json['specialist'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    hospitalId = json['hospital_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['specialist'] = this.specialist;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['hospital_id'] = this.hospitalId;
    data['id'] = this.id;
    return data;
  }
}

class Hospital {
  String? id;
  String? name;
  String? address;
  String? phone;
  String? createdAt;
  String? updatedAt;

  Hospital(
      {this.id,
        this.name,
        this.address,
        this.phone,
        this.createdAt,
        this.updatedAt});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class IotId {
  String? nameDevice;
  String? ipMac;
  bool? status;
  String? hospitalId;
  String? patientCccd;
  String? createdAt;
  String? updatedAt;
  String? id;

  IotId(
      {this.nameDevice,
        this.ipMac,
        this.status,
        this.hospitalId,
        this.patientCccd,
        this.createdAt,
        this.updatedAt,
        this.id});

  IotId.fromJson(Map<String, dynamic> json) {
    nameDevice = json['name_device'];
    ipMac = json['ip_mac'];
    status = json['status'];
    hospitalId = json['hospital_id'];
    patientCccd = json['patient_cccd'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_device'] = this.nameDevice;
    data['ip_mac'] = this.ipMac;
    data['status'] = this.status;
    data['hospital_id'] = this.hospitalId;
    data['patient_cccd'] = this.patientCccd;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
