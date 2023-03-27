import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_udevs/cubits/todo_cubit.dart';
import 'package:todo_udevs/data/local_data/local_data.dart';
import 'package:todo_udevs/data/repos/category_repo.dart';
import 'package:todo_udevs/data/repos/my_repo.dart';
import 'package:todo_udevs/data/services/notif/service_notif.dart';
import 'package:todo_udevs/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalData.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  LocalNotificationService.localNotificationService.init();

  runApp(
    RepositoryProvider(
      create: (context) => CategoryRepository(),
      child: BlocProvider(
        create: (context) => TodoCubit(
          myTodoRepo: MyTodoRepo(),
          categRepo: CategoryRepository(),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 880),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: (LocalData.getBool(key: "isOnBoarding") == true)
              ? "/"
              : "/on_boarding",
        );
      },
    );
  }
}
