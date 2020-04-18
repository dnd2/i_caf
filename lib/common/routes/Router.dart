import 'package:i_caf/common/routes/RouteWidgets.dart';
import 'package:i_caf/components/RouteTranistion.dart';

class Router {
  
  static Map<String, Widget> getRoutes() {
    return <String, Widget>{
      '/': LoginPage(),
      'home': HomePage(),
    };
  }
  
  static redirectTo(String path) {
    final Map<String, Widget> items = getRoutes();

    if (items.containsKey(path)) {
        return RouteTranistion(items[path]);
    }

    return '404';
  }
}