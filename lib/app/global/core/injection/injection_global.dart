import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/core/injection/controllers_injection.dart';
import 'package:safe2biz/app/global/core/injection/repositories_injection.dart';
import 'package:safe2biz/app/global/core/injection/services_injection.dart';
import 'package:safe2biz/app/global/core/injection/usecases_injection.dart';

void setUp() {
  // Init preferences
  LocalPreferences().initPrefs();
  // SERVICES
  ServicesInjection.list;
  // REPOSITORIES
  RepositoriesInjection.list;
  // USECASE
  UseCasesInjection.list;
  // CONTROLLERS
  ControllersInjection.list;
}
