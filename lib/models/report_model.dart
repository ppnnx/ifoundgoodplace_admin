class ReportModel {
  int idreport;
  int iduser;
  String username;
  String statement;
  String statusReport;
  String dateReport;
  String timeReport;
  int idauthor;
  String author;
  String image;
  int idcontent;
  String dateContent;
  String timeContent;
  String statusContent;
  String title;
  String category;
  String content;
  String linkVDO;
  String location;
  String images01;
  String images02;
  String images03;
  String images04;
  int counterRead;
  int totalFav;
  int totalCom;
  int totalSave;
  int totalShare;

  ReportModel(
      {this.idreport,
      this.iduser,
      this.username,
      this.statement,
      this.statusReport,
      this.dateReport,
      this.timeReport,
      this.idauthor,
      this.author,
      this.image,
      this.idcontent,
      this.dateContent,
      this.timeContent,
      this.statusContent,
      this.title,
      this.category,
      this.content,
      this.linkVDO,
      this.location,
      this.images01,
      this.images02,
      this.images03,
      this.images04,
      this.counterRead,
      this.totalFav,
      this.totalCom,
      this.totalSave,
      this.totalShare});

  ReportModel.fromJson(Map<String, dynamic> json) {
    idreport = json['ID_Report'];
    iduser = json['ID_User'];
    username = json['Username'];
    statement = json['Statement'];
    statusReport = json['Status_Report'];
    dateReport = json['Date_Report'];
    timeReport = json['Time_Report'];
    idauthor = json['ID_Author'];
    author = json['Author'];
    image = json['Image'];
    idcontent = json['ID_Content'];
    dateContent = json['Date_Content'];
    timeContent = json['Time_Content'];
    statusContent = json['Status_Content'];
    title = json['Title'];
    category = json['Category'];
    content = json['Content'];
    linkVDO = json['Link_VDO'];
    location = json['Location'];
    images01 = json['Images01'];
    images02 = json['Images02'];
    images03 = json['Images03'];
    images04 = json['Images04'];
    counterRead = json['Counter_Read'];
    totalFav = json['Total_Fav'];
    totalCom = json['Total_Com'];
    totalSave = json['Total_Save'];
    totalShare = json['Total_Share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_Report'] = this.idreport;
    data['ID_User'] = this.iduser;
    data['Username'] = this.username;
    data['Statement'] = this.statement;
    data['Status_Report'] = this.statusReport;
    data['Date_Report'] = this.dateReport;
    data['Time_Report'] = this.timeReport;
    data['ID_Author'] = this.idauthor;
    data['Author'] = this.author;
    data['Image'] = this.image;
    data['ID_Content'] = this.idcontent;
    data['Date_Content'] = this.dateContent;
    data['Time_Content'] = this.timeContent;
    data['Status_Content'] = this.statusContent;
    data['Title'] = this.title;
    data['Category'] = this.category;
    data['Content'] = this.content;
    data['Link_VDO'] = this.linkVDO;
    data['Location'] = this.location;
    data['Images01'] = this.images01;
    data['Images02'] = this.images02;
    data['Images03'] = this.images03;
    data['Images04'] = this.images04;
    data['Counter_Read'] = this.counterRead;
    data['Total_Fav'] = this.totalFav;
    data['Total_Com'] = this.totalCom;
    data['Total_Save'] = this.totalSave;
    data['Total_Share'] = this.totalShare;
    return data;
  }
}
