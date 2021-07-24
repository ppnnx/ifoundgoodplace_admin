class ContentModel {
  int iduser;
  String username;
  String statuspost;
  int idcontent;
  String dateContent;
  String timeContent;
  String title;
  String category;
  String content;
  String linkVDO;
  String location;
  int counterread;
  String images01;
  String images02;
  String images03;
  String images04;

  ContentModel(
      {this.iduser,
      this.username,
      this.statuspost,
      this.idcontent,
      this.dateContent,
      this.timeContent,
      this.title,
      this.category,
      this.content,
      this.linkVDO,
      this.location,
      this.counterread,
      this.images01,
      this.images02,
      this.images03,
      this.images04});

  ContentModel.fromJson(Map<String, dynamic> json) {
    iduser = json['ID_User'];
    username = json['Username'];
    statuspost = json['Status_Post'];
    idcontent = json['ID_Content'];
    dateContent = json['Date_Content'];
    timeContent = json['Time_Content'];
    title = json['Title'];
    category = json['Category'];
    content = json['Content'];
    linkVDO = json['Link_VDO'];
    location = json['Location'];
    counterread = json['Counter_Read'];
    images01 = json['Images01'];
    images02 = json['Images02'];
    images03 = json['Images03'];
    images04 = json['Images04'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_User'] = this.iduser;
    data['Username'] = this.username;
    data['Status_Post'] = this.statuspost;
    data['ID_Content'] = this.idcontent;
    data['Date_Content'] = this.dateContent;
    data['Time_Content'] = this.timeContent;
    data['Title'] = this.title;
    data['Category'] = this.category;
    data['Content'] = this.content;
    data['Link_VDO'] = this.linkVDO;
    data['Location'] = this.location;
    data['Counter_Read'] = this.counterread;
    data['Images01'] = this.images01;
    data['Images02'] = this.images02;
    data['Images03'] = this.images03;
    data['Images04'] = this.images04;
    return data;
  }
}
