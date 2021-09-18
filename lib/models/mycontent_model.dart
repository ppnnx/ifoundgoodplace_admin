class MyContentModel {
  int? iduser;
  String? username;
  String? display;
  String? statuspost;
  String? statuscontent;
  String? statusreport;
  String? statement;
  int? idcontent;
  String? datecontent;
  String? title;
  String? category;
  String? content;
  String? link;
  double? latitude;
  double? longitude;
  int? read;
  String? images01;
  String? images02;
  String? images03;
  String? images04;
  int? favorite;
  int? comment;
  int? save;
  int? share;

  MyContentModel(
      {this.iduser,
      this.username,
      this.display,
      this.statuspost,
      this.statuscontent,
      this.statusreport,
      this.statement,
      this.idcontent,
      this.datecontent,
      this.title,
      this.category,
      this.content,
      this.link,
      this.latitude,
      this.longitude,
      this.read,
      this.images01,
      this.images02,
      this.images03,
      this.images04,
      this.favorite,
      this.comment,
      this.save,
      this.share});

  MyContentModel.fromJson(Map<String, dynamic> json) {
    iduser = json['ID_User'];
    username = json['Username'];
    display = json['Image'];
    statuspost = json['Status_Post'];
    statuscontent = json['Status_Content'];
    statusreport = json['Status_Report'];
    statement = json['Statement'];
    idcontent = json['ID_Content'];
    datecontent = json['Date_Content'];
    title = json['Title'];
    category = json['Category'];
    content = json['Content'];
    link = json['Link_VDO'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    read = json['Counter_Read'];
    images01 = json['Images01'];
    images02 = json['Images02'];
    images03 = json['Images03'];
    images04 = json['Images04'];
    favorite = json['Total_Fav'];
    comment = json['Total_Com'];
    save = json['Total_Save'];
    share = json['Total_Share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_User'] = this.iduser;
    data['Username'] = this.username;
    data['Image'] = this.display;
    data['Status_Post'] = this.statuspost;
    data['Status_Content'] = this.statuscontent;
    data['Status_Report'] = this.statusreport;
    data['Statement'] = this.statement;
    data['ID_Content'] = this.idcontent;
    data['Date_Content'] = this.datecontent;
    data['Title'] = this.title;
    data['Category'] = this.category;
    data['Content'] = this.content;
    data['Link_VDO'] = this.link;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Counter_Read'] = this.read;
    data['Images01'] = this.images01;
    data['Images02'] = this.images02;
    data['Images03'] = this.images03;
    data['Images04'] = this.images04;
    data['Total_Fav'] = this.favorite;
    data['Total_Com'] = this.comment;
    data['Total_Save'] = this.save;
    data['Total_Share'] = this.share;
    return data;
  }
}
