class Rule {
  String? name;
  int? heartRateFrom;
  int? heartRateTo;
  String? createdAt;
  String? updatedAt;

  Rule(
      {this.name,
        this.heartRateFrom,
        this.heartRateTo,
        this.createdAt,
        this.updatedAt});

  Rule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    heartRateFrom = json['heartRateFrom'];
    heartRateTo = json['heartRateTo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['heartRateFrom'] = this.heartRateFrom;
    data['heartRateTo'] = this.heartRateTo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
