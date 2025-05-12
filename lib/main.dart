import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/constants/app_constants.dart';
import 'core/themes/app_theme.dart';
import 'features/dashboard/presentation/bloc/navigation_bloc.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with design dimensions from Figma (1440 x 905)
    return ScreenUtilInit(
      designSize: const Size(1440, 905),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => NavigationBloc(),
          child: MaterialApp(
            title: AppConstants.appName,
            theme:
                AppTheme
                    .darkTheme, // Using dark theme by default to match the images
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            builder:
                (context, child) => ResponsiveBreakpoints.builder(
                  child: child!,
                  breakpoints: [
                    const Breakpoint(start: 0, end: 600, name: MOBILE),
                    const Breakpoint(start: 601, end: 900, name: TABLET),
                    const Breakpoint(start: 901, end: 1200, name: DESKTOP),
                    const Breakpoint(
                      start: 1201,
                      end: double.infinity,
                      name: 'XL',
                    ),
                  ],
                ),
            home: const DashboardPage(),
          ),
        );
      },
    );
  }
}
