class Hospital {
  String? key;
  int? stt;
  String? sId;
  String? name;
  String? address;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? id;

  Hospital(
      {this.key,
        this.stt,
        this.sId,
        this.name,
        this.address,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.id});

  Hospital.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    stt = json['stt'];
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['stt'] = this.stt;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
class HospitalName {
  String? value;
  String? label;


  HospitalName.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}

