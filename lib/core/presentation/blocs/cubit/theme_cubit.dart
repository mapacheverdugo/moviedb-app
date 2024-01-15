import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';

class ThemeCubit extends Cubit<Brightness> {
  ThemeCubit()
      : super(SchedulerBinding.instance.platformDispatcher.platformBrightness);
}
