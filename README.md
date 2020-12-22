# cresce_flutter_app

![Flutter](https://github.com/AlienEngineer/cresce-flutter-app/workflows/Flutter/badge.svg?branch=master)

Cresce flutter app

## Getting Started

```
// Before running integration tests:
docker run -d -p 5000:80 --name cresce.api alienengineer/cresce
```

## Architecture decisions

- Dependency Injection
  - Widgets collect dependencies via `context.get<ServiceType>()`
  - Services receive dependencies via constructor
  - Services are configured via ServiceModule implementation which in turn 
    is registered in the service locator.    