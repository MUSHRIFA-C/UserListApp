import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userlist/routes/route_names.dart';
import 'package:userlist/screens/default_page.dart';
import 'package:userlist/screens/detail_page.dart';
import 'package:userlist/screens/home_page.dart';

class RouteNavigation{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(
    settings.name
    ){
      case RouteName.homeRoute:return MaterialPageRoute(builder: (context)=>HomePage());
      case RouteName.locationRoute:return MaterialPageRoute(builder: (context)=>Detailpage());
      default:return MaterialPageRoute(builder: (context)=>DefaultPage());
    }
  }
}