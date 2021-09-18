class TotalAboutContent {
  int? iduser;
  String? username;
  int? content;
  int? post;
  int? delete;
  int? report;

  TotalAboutContent(
      {this.iduser,
      this.username,
      this.content,
      this.post,
      this.delete,
      this.report});

  TotalAboutContent.fromJson(Map<String, dynamic> json) {
    iduser = json['ID_User'];
    username = json['Username'];
    content = json['totalcontent'];
    post = json['totalpost'];
    delete = json['totaldelete'];
    report = json['totalreport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_User'] = this.iduser;
    data['Username'] = this.username;
    data['totalcontent'] = this.content;
    data['totalpost'] = this.post;
    data['totaldelete'] = this.delete;
    data['totalreport'] = this.report;
    return data;
  }
}
