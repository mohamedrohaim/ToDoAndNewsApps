import 'package:todo/shared/component/cubit/cubit.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}
class  AppChangeBottomVavBarState extends AppStates{}
class  AppCreateDatabaseState extends AppStates{}
class  AppGetDatabaseState extends AppStates{}

class  AppInsertDatabaseState extends AppStates{}
class  AppUpdateDatabaseState extends AppStates{}
class  AppDeleteDatabaseState extends AppStates{}


class  AppChangeBottomSheetState extends AppStates{}
class  AppNavgigatorPopState extends AppStates{}
class AppChangeModeState extends AppStates{}


