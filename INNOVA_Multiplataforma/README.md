# INNOVA Multiplataforma

Prototipo académico de una aplicación inmobiliaria multiplataforma desarrollada con **Flutter + Dart**. La misma base de código adapta la navegación y la distribución visual a pantallas móviles y de escritorio.

## Funciones incluidas
- Inicio con propiedades destacadas.
- Catálogo con búsqueda y filtros de Venta/Renta.
- Diseño responsivo: cuadrícula adaptable.
- Detalle de cada propiedad.
- Agenda de citas.
- Favoritos.
- Perfil de usuario.
- Navegación inferior en móvil y `NavigationRail` en pantallas amplias.

## Plataformas objetivo
Flutter permite preparar este proyecto para Android, iOS, Web, Windows, macOS y Linux. Para la entrega se plantean principalmente **Android, Web y Windows**.

## Cómo preparar el proyecto
1. Instala Flutter y verifica con `flutter doctor`.
2. Desde esta carpeta ejecuta:

```bash
flutter create . --platforms=android,web,windows
flutter pub get
```

3. Ejecuta una plataforma:

```bash
flutter run -d chrome
flutter run -d windows
flutter run -d <id-del-telefono>
```

## Compilaciones
```bash
flutter build web
flutter build windows
flutter build apk
```

> El prototipo utiliza datos locales para demostrar la interfaz y el comportamiento sin depender de servicios externos. Puede conectarse posteriormente con Supabase para sincronizar datos con INNOVA Web.
