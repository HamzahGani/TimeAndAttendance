class GetDesignations {
  List<Designations> designations;

  GetDesignations({this.designations});

  GetDesignations.fromJson(Map<String, dynamic> json) {
    if (json['designations'] != null) {
      designations = new List<Designations>();
      json['designations'].forEach((v) {
        designations.add(new Designations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.designations != null) {
      data['designations'] = this.designations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Designations {
  String name;
  String status;

  Designations({this.name, this.status});

  Designations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
