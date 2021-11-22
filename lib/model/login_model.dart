class LoginResponseModelLogin {
  final String first;
  final String last;
  final String role;
  final String email;
  final String mobileNumber;
  final String designation;
  final String department;
  final String company;
  final String photo;
  final String error;

  LoginResponseModelLogin({this.first,this.last,this.email, this.mobileNumber,this.role,this.designation,this.department,this.company,this.photo, this.error});

  factory LoginResponseModelLogin.fromJson(Map<String, dynamic> json) {
    return LoginResponseModelLogin(

      first: json["FirstName"] != null ? json["FirstName"] : "",
      last: json["LastName"] != null ? json["LastName"] : "",
      email: json["Email"] != null ? json["Email"] : "",
      mobileNumber: json["MobileNumber"] != null ? json["MobileNumber"] : "",
      role: json["Role"] != null ? json["Role"] : "",
      designation: json["Designation"] != null ? json["Designation"] : "",
      department: json["Department"] != null ? json["Department"] : "",
      company: json["CompanyName"] != null ? json["CompanyName"] : "",
      photo: json["Photo"] != null ? json["Photo"] : "",
      error: json["Error"] != null ? json["Error"] : "",
    );
  }
}

class LoginRequestModelLogin {
  String email;
  String password;

  LoginRequestModelLogin({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password":password.trim(),
    };

    return map;
  }
}


