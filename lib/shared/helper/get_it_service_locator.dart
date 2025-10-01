import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pro_genius_test_task/shared/helper/helper.dart';

final getIt = GetIt.instance;

/// COMMENT: Method registers all classes that use Injectable
@InjectableInit()
void configureDependencies() => getIt.init();
