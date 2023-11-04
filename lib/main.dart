import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userlist/provider/user_provider.dart';
import 'package:userlist/routes/route_names.dart';
import 'package:userlist/routes/route_navigation.dart';
import 'package:userlist/utilities/constants.dart';
void main(){
  runApp(
      ChangeNotifierProvider(create: (context)=>UserProvider(),child: Main()));
}
class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.homeRoute,
      onGenerateRoute: RouteNavigation.generateRoute,
      theme: ThemeData(scaffoldBackgroundColor: Constants.primaryColor),
    );
  }
}
