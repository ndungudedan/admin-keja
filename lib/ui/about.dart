import 'package:admin_keja/constants/constant.dart';
import 'package:admin_keja/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class About extends StatelessWidget {
  Constants constants=Constants();

  Future<String> makePostRequest() async {
    Response response = await post(constants.abouturl);

    if(response.statusCode==200){
      String responseBody = response.body;
    print(responseBody);
    return responseBody;
    }
    else{
      String responseBody = response.body;
    print(responseBody);
    return "No data";
    }
  }

  @override
  Widget build(BuildContext context) {
    makePostRequest();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: LightColors.kDarkYellow,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('About'),
        ),
          body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              FutureBuilder<String>(
                future: makePostRequest(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Text(snapshot.data);
                  }
                  return CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}