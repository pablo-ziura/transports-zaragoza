# Transportes Ciudad de Zaragoza

<p align="center">
  <img src="TransportZaragoza/Assets.xcassets/AppIcon.appiconset/logo_zaragoza_transports_app.jpg" alt="Logo de Transportes Ciudad de Zaragoza" width="200">
</p>

Sumérgete en...

## Descripción General

Transportes Ciudad de Zaragoza está diseñada con **SwiftUI**, siguiendo una **Arquitectura Clean** y **principios SOLID**, además de un **patrón MVVM** para la UI, permitiendo una separación clara entre la presentación y la lógica de negocio...

Este proyecto utiliza la [API del Ayuntamiento de Zaragoza](https://www.zaragoza.es/sede/servicio/urbanismo-infraestructuras/transporte-urbano), un servicio que pone a su disposición los diferentes conjuntos de datos que publica el Ayuntamiento de Zaragoza. Ofrece diferentes formatos y operaciones para la consulta de los mismos.

## Introducción

Transportes Ciudad de Zaragoza es la aplicación esencial para...

## Capturas de pantalla

<p align="center">
  <img src="TransportZaragoza/Assets.xcassets/Screeshots/screen_001.png" alt="Screenshot 01" width="150">
  <img src="TransportZaragoza/Assets.xcassets/Screeshots/screen_002.png" alt="Screenshot 02" width="150">
  <img src="TransportZaragoza/Assets.xcassets/Screeshots/screen_003.png" alt="Screenshot 03" width="150">
  <img src="TransportZaragoza/Assets.xcassets/Screeshots/screen_004.png" alt="Screenshot 04" width="150">
  <img src="TransportZaragoza/Assets.xcassets/Screeshots/screen_005.png" alt="Screenshot 05" width="150">
  <img src="TransportZaragoza/Assets.xcassets/Screeshots/screen_006.png" alt="Screenshot 06" width="150">
</p>

## Estructura del Proyecto

La aplicación sigue una **Arquitectura Clean** y **principios SOLID**, y está organizada en las siguientes carpetas de alto nivel dentro de la carpeta `lib/`:

- `data/` - Contiene la implementación de la lógica de acceso a datos, tanto remotos como locales.
  - `genre/` - Operaciones relacionadas con géneros de películas.
  - `movie/` - Operaciones relacionadas con películas.
- `di/` - Configuración de la inyección de dependencias para la aplicación.
- `domain/` - Repositorios y entidades de negocio.
- `model/` - Modelos de datos utilizados a lo largo de la aplicación.
- `ui/` - Elementos de la interfaz de usuario, organizados por pantalla y funcionalidad.
  - `base/` - Clases base para los ViewModels.
  - `views/` - Vistas individuales de la aplicación, cada una con su ViewModel correspondiente.
  - `widgets/` - Widgets reutilizables.
- `main.dart` - Punto de entrada de la aplicación.

Dentro de `Features/`, cada vista de la aplicación está cuidadosamente separada en su propio directorio con su ViewModel específico, lo que facilita la gestión de estados y la navegación.

## Librerías

Para el diseño de una aplicación robusta y escalable, se han utlizado las siguientes librerías en el proyecto:

- [SwiftUI](https://developer.apple.com/xcode/swiftui) - El SDK de UI para crear hermosas aplicaciones compiladas nativamente.

Estas herramientas y librerías se han seleccionado cuidadosamente para trabajar juntas y proporcionar una base sólida y flexible para la **arquitectura MVVM**, facilitando un código mantenible y una experiencia de usuario fluida.

## Instalación

Sigue estos pasos para configurar el entorno de desarrollo y ejecutar la aplicación:

### Clona el repositorio de GitHub
git clone https://github.com/pablo-ziura/transports-zaragoza.git

### Navega al directorio del proyecto clonado
cd ultimate-movie-database

### Instala las dependencias del proyecto
flutter pub get

### Ejecuta la aplicación en modo de desarrollo
flutter run

## Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE.md](LICENSE.md) para detalles.