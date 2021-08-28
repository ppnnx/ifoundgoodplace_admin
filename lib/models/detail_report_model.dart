class DetailReportModel {
  int iduser;
  String username;
  int idcontent;
  String title;
  String statuscontent;
  String cause;

  DetailReportModel(
      {this.iduser,
      this.username,
      this.idcontent,
      this.title,
      this.statuscontent,
      this.cause});

  DetailReportModel.fromJson(Map<String, dynamic> json) {
    iduser = json['ID_User'];
    username = json['Username'];
    idcontent = json['ID_Content'];
    title = json['Title'];
    statuscontent = json['Status_Content'];
    cause = json['Cause'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_User'] = this.iduser;
    data['Username'] = this.username;
    data['ID_Content'] = this.idcontent;
    data['Title'] = this.title;
    data['Status_Content'] = this.statuscontent;
    data['Cause'] = this.cause;
    return data;
  }
}
