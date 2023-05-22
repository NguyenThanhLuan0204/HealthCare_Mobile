class GetAnalytic {
  List<BeatAvgs>? beatAvgs;

  GetAnalytic({this.beatAvgs});

  GetAnalytic.fromJson(Map<String, dynamic> json) {
    if (json['beat_avgs'] != null) {
      beatAvgs = <BeatAvgs>[];
      json['beat_avgs'].forEach((v) {
        beatAvgs!.add(new BeatAvgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.beatAvgs != null) {
      data['beat_avgs'] = this.beatAvgs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BeatAvgs {
  String? month;
  double? avg;
  int? bp;
  int? chol;

  BeatAvgs({this.month, this.avg, this.bp, this.chol});

  BeatAvgs.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    avg = json['avg'];
    bp = json['bp'];
    chol = json['chol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['avg'] = this.avg;
    data['bp'] = this.bp;
    data['chol'] = this.chol;
    return data;
  }
}
