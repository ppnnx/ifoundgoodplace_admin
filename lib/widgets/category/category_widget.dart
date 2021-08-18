import 'package:flutter/material.dart';
import 'package:ifgpadmin/models/category_model.dart';
import 'package:ifgpadmin/screens/categories/content_in_category.dart';
import 'package:ifgpadmin/service/category_api.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APICategory.getCategory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                CategoryModel category = snapshot.data[index];

                return Container(
                  padding: EdgeInsets.only(left: 21, right: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContentinCategory(
                                        idcategory: category.id,
                                        namecategory: category.name,
                                      )));
                          // print(category.id.toString());
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    category.name,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    category.total.toString(),
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
