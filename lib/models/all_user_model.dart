class AllUsers {
  int? iduser;
  String? username;
  String? image;
  String? email;
  String? status;
  int? content;
  int? post;
  int? delete;
  int? report;

  AllUsers(
      {this.iduser,
      this.username,
      this.image,
      this.email,
      this.status,
      this.content,
      this.post,
      this.delete,
      this.report});

  AllUsers.fromJson(Map<String, dynamic> json) {
    iduser = json['ID_User'];
    username = json['Username'];
    image = json['image'];
    email = json['Email'];
    status = json['Status_User'];
    content = json['totalcontent'];
    post = json['totalpost'];
    delete = json['totaldelete'];
    report = json['totalreport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_User'] = this.iduser;
    data['Username'] = this.username;
    data['image'] = this.image;
    data['Email'] = this.email;
    data['Status_User'] = this.status;
    data['totalcontent'] = this.content;
    data['totalpost'] = this.post;
    data['totaldelete'] = this.delete;
    data['totalreport'] = this.report;
    return data;
  }
}
