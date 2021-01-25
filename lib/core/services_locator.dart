abstract class ServiceModule {
  void register(ServiceLocator locator);
}

class ServiceLocator {
  _Registry _registry;

  ServiceLocator() {
    _registry = _Registry();
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

class ServiceNotFoundError extends Error {
  final String message;

  ServiceNotFoundError(this.message);

  @override
  String toString() => message;
}

typedef FactoryFunc<T> = T Function();

class _Registry {
  Map<String, Object> _singletons = Map<String, Object>();
  Map<String, Object> _factories = Map<String, Object>();

  T call<T>() => get<T>();

  T get<T>() {
    var singleton = _singletons[T.toString()] as T;

    if (singleton != null) {
      return singleton;
    }

    var factory = _factories[T.toString()] as FactoryFunc<T>;

    if (factory == null) {
      throw ServiceNotFoundError(
        'The $T was not found. Make sure to register it under a module.',
      );
    }

    return factory();
  }

  void registerFactory<T>(FactoryFunc<T> factory) {
    _factories[T.toString()] = factory;
  }

  void registerSingleton<T>(T instance) {
    _singletons[T.toString()] = instance;
  }
}
