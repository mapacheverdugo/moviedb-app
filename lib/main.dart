import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/config/routes/routes.dart';
import 'package:moviedb/config/theme/app_themes.dart';
import 'package:moviedb/core/presentation/blocs/cubit/theme_cubit.dart';
import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_item_checker_bloc/watchlist_item_checker_bloc.dart';
import 'package:moviedb/injection_container.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MovieDbApp());
}

class MovieDbApp extends StatelessWidget {
  const MovieDbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<WatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<WatchlistItemCheckerBloc>(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, Brightness>(
        builder: (context, state) {
          setStatusBarColor(state);

          return MaterialApp(
            title: 'MovieDB',
            theme: AppTheme.getThemeByBrightness(state),
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
