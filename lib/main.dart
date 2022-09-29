import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/src/utilities/dependency_setup.dart';
import 'package:todo_app/src/utilities/navigation/navigation_service.dart';
import 'package:todo_app/src/utilities/navigation/route.dart';
import 'package:todo_app/src/utilities/notification/notification_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await DependencySetup.registerDependencies();
  await Hive.initFlutter();
  await NotificationService().init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO-APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      //navigatorKey: Get.find<NavigationService>().navigatorKey,
      onGenerateRoute: (settings)=>RouteGenerator().generateRoute(settings),
    );
  }
}
