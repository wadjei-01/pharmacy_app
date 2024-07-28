import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pharmacy_app/core/config/app_routes.dart';
import 'package:pharmacy_app/core/themes/app_themes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeProvider = ref.watch(AppRoutes.routerProvider);
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          routerConfig: routeProvider,
        );
      },
    );
  }
}
