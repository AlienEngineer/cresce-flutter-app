import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/features/employees/employees.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

abstract class ServiceModule {
  void register(ServiceLocator locator);
}

class ServiceLocator {
  _Registry _registry;

  ServiceLocator(String authority) {
    _registry = _Registry();
    _init(authority);
  }

  void _init(String authority) {
    registerModule(HttpModule(authority));
    registerModule(AuthenticationModule());
    registerModule(EmployeesModule());
    registerModule(OrganizationsModule());
  }

  void overrideDependency<T>(T service) {
    _registry.registerSingleton(service);
  }

  void registerModule(ServiceModule module) => module.register(this);

  void registerSingleton<T>(T service) {
    _registry.registerSingleton<T>(service);
  }

  void registerFactory<T>(T Function() factory) {
    _registry.registerFactory<T>(() => factory());
  }

  T get<T>() => _registry<T>();
  T call<T>() => get<T>();
}

typedef FactoryFunc<T> = T Function();

class _Registry {
  Map<String, Object> _singletons = Map<String, Object>();
  Map<String, Object> _factories = Map<String, Object>();

  bool allowReassignment;

  T call<T>() => get<T>();

  T get<T>() {
    var singleton = _singletons[T.toString()] as T;

    if (singleton != null) {
      return singleton;
    }

    var factory = _factories[T.toString()] as FactoryFunc<T>;

    return factory();
  }

  void registerFactory<T>(FactoryFunc<T> factory) {
    _factories[T.toString()] = factory;
    print('${T.toString()} -> $factory');
  }

  void registerSingleton<T>(T instance) {
    print('${T.toString()} -> $instance');
    _singletons[T.toString()] = instance;
  }
}

extension BuildContextExtensions on BuildContext {
  T get<T>() {
    var locator = Provider.of<ServiceLocator>(this, listen: false);
    return locator<T>();
  }
}

void _stubOverrideDependencies(ServiceLocator locator) {}

Provider<ServiceLocator> wrapWithProvider({
  Widget app,
  void Function(ServiceLocator) override,
}) {
  return Provider(
    create: (_) => makeServiceLocator(override: override),
    child: app,
  );
}

ServiceLocator makeServiceLocator({
  void Function(ServiceLocator) override = _stubOverrideDependencies,
}) {
  var locator = ServiceLocator('https://cresce.azurewebsites.net/');
  print('locator initialized');
  override(locator);
  return locator;
}
