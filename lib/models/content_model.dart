class ContentModel {
  int? iduser;
  String? username;
  String? statuscontent;
  int? idcontent;
  String? dateContent;
  String? timeContent;
  String? title;
  String? category;
  String? content;
  String? link;
  double? latitude;
  double? longitude;
  int? counterread;
  String? images01;
  String? images02;
  String? images03;
  String? images04;
  int? favorite;
  int? save;
  int? comments;
  int? share;

  ContentModel({
    this.iduser,
    this.username,
    this.statuscontent,
    this.idcontent,
    this.dateContent,
    this.timeContent,
    this.title,
    this.category,
    this.content,
    this.link,
    this.latitude,
    this.longitude,
    this.counterread,
    this.images01,
    this.images02,
    this.images03,
    this.images04,
    this.favorite,
    this.save,
    this.comments,
    this.share,
  });

  ContentModel.fromJson(Map<String, dynamic> json) {
    iduser = json['ID_User'];
    username = json['Username'];
    statuscontent = json['Status_Content'];
    idcontent = json['ID_Content'];
    dateContent = json['Date_Content'];
    timeContent = json['Time_Content'];
    title = json['Title'];
    category = json['Category'];
    content = json['Content'];
    link = json['Link_VDO'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    counterread = json['Counter_Read'];
    images01 = json['Images01'];
    images02 = json['Images02'];
    images03 = json['Images03'];
    images04 = json['Images04'];
    favorite = json['Total_Fav'];
    save = json['Total_Save'];
    comments = json['Total_Com'];
    share = json['Total_Share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_User'] = this.iduser;
    data['Username'] = this.username;
    data['Status_Content'] = this.statuscontent;
    data['ID_Content'] = this.idcontent;
    data['Date_Content'] = this.dateContent;
    data['Time_Content'] = this.timeContent;
    data['Title'] = this.title;
    data['Category'] = this.category;
    data['Content'] = this.content;
    data['Link_VDO'] = this.link;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Counter_Read'] = this.counterread;
    data['Images01'] = this.images01;
    data['Images02'] = this.images02;
    data['Images03'] = this.images03;
    data['Images04'] = this.images04;
    data['Total_Fav'] = this.favorite;
    data['Total_Save'] = this.save;
    data['Total_Com'] = this.comments;
    data['Total_Share'] = this.share;
    return data;
  }
}
