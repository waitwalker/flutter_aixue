import 'package:flutter/material.dart';
import 'package:flutter_aixue/common/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// @name StudentPersonalizedRecommendationPage
/// @description 学生个性化推荐
/// @author lca
/// @date 2019-11-01
///
class StudentPersonalizedRecommendationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentPersonalizedRecommendationState();
  }
}

class _StudentPersonalizedRecommendationState extends State<StudentPersonalizedRecommendationPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("个性化推荐"),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
      );
    });
  }
}