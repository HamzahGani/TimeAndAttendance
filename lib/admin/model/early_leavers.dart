class EarlyLeavers {
  List<Earlyleavers> earlyleavers;

  EarlyLeavers({this.earlyleavers});

  EarlyLeavers.fromJson(Map<String, dynamic> json) {
    if (json['earlyleavers'] != null) {
      earlyleavers = new List<Earlyleavers>();
      json['earlyleavers'].forEach((v) {
        earlyleavers.add(Earlyleavers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.earlyleavers != null) {
      data['earlyleavers'] = earlyleavers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Earlyleavers {
  String name;
  String shift;
  String timeOut;
  String earlyBy;

  Earlyleavers({this.name, this.shift, this.timeOut, this.earlyBy});

  Earlyleavers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shift = json['shift'];
    timeOut = json['timeOut'];
    earlyBy = json['earlyBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['shift'] = shift;
    data['timeOut'] = timeOut;
    data['earlyBy'] = earlyBy;
    return data;
  }
}
