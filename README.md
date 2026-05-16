Frontend Flutter – Trabajo de Fin de Grado (TFG)
Descripción general
Este repositorio contiene el desarrollo del frontend móvil del Trabajo de Fin de Grado del ciclo de Desarrollo de Aplicaciones Multiplataforma (DAM).
La aplicación está implementada utilizando Flutter (Dart) y tiene como objetivo integrar un feed de noticias y un sistema de notificaciones push dentro de una plataforma móvil del centro educativo.

El frontend está diseñado siguiendo una arquitectura clara, modular y escalable, permitiendo la futura integración con la plataforma web del colegio.

Tecnologías utilizadas
Framework: Flutter
Lenguaje: Dart
IDE: Visual Studio Code
Control de versiones: Git
Repositorio remoto: GitHub
Plataformas objetivo: Android / iOS
Objetivos del frontend
Implementar un feed de noticias consumiendo información desde WordPress vía API REST.
Gestionar el consentimiento del usuario para recibir notificaciones.
Integrar notificaciones push mediante Firebase Cloud Messaging.
Garantizar una arquitectura limpia: separación en módulos (core, features, services, widgets).
Ofrecer una interfaz moderna, clara y fácil de mantener.
Plan de trabajo – Desarrollo por semanas
📅 Semana 1 – Creación y configuración del proyecto
Objetivos
Preparar el entorno de desarrollo.
Crear el proyecto base en Flutter.
Configurar Git y GitHub.
Tareas realizadas
Instalación y verificación de Flutter y Dart.
Creación del proyecto con flutter create.
Inicialización del repositorio Git.
Creación del repositorio remoto en GitHub.
Primer commit del proyecto.
Resultado
Proyecto Flutter funcional y base estable del TFG.
Repositorio GitHub correctamente configurado.
📅 Semana 2 – Estructura base y diseño inicial
Objetivos
Definir la estructura del proyecto.
Preparar los primeros componentes visuales.
Tareas realizadas / previstas
Limpieza del código inicial generado por Flutter.
Organización del proyecto en módulos:
core/, features/, services/, widgets/.
Configuración de main.dart.
Creación de la pantalla Home.
Definición del tema visual (AppTheme).
Resultado
Proyecto limpio, organizado y listo para implementar funcionalidad.
📅 Semana 3 – Feed de noticias y consumo de datos
Objetivos
Implementar el feed dinámico de noticias.
Integrar la API REST de WordPress.
Tareas realizadas
Creación de entidades, modelos y repositorios.
Implementación de NewsRemoteDataSource con HTTP.
Obtención de noticias reales desde WordPress.
Listado de noticias con imágenes, título y resumen.
Manejadores de carga (loading) y error.
Navegación a detalle de noticia.
Resultado
Feed de noticias completamente funcional dentro de la app.
📅 Semana 4 – Notificaciones push y cierre del frontend
Objetivos
Implementar notificaciones push.
Finalizar la interfaz y pruebas de usuario.
Tareas previstas
Integración de Firebase Cloud Messaging (FCM).
Manejo de permisos y almacenamiento de preferencias.
Pantallas de configuración de notificaciones.
Pruebas completas en Android e iOS.
Optimización final del código y documentación.
Resultado esperado
Aplicación funcional, estable y lista para integrar con el backend.
Estado actual del proyecto
🟢 Estructura definida
🟢 Integración con API REST (noticias)
🟢 Frontend en desarrollo activo
🟡 Notificaciones pendientes de integración
⚪ Backend pendiente de construcción (fase siguiente del TFG)

Autor
Nombre del alumno: [Tu nombre aquí]
Ciclo: Desarrollo de Aplicaciones Multiplataforma
Centro educativo: [Nombre del centro]
Curso académico: 2025 / 2026

Licencia
Proyecto desarrollado con fines académicos como Trabajo de Fin de Grado (TFG).
No destinado a uso comercial.
