class ApiConstants {
  static final baseUrl = 'https://teatrope-api-production-278a.up.railway.app/api/';
  
  // Auth endpoints
  static final signinEndpoint = 'auth/token/login/'; 
  static final signupEndpoint = 'auth/users/register/';
  static final logoutEndpoint = 'auth/token/logout/';
  
  // User endpoints
  static final usersEndpoint = 'auth/users/';
  static final userDetailEndpoint = 'auth/users/{id}/';
  
  // Content endpoints
  static final obrasEndpoint = 'content/obras/';
  static final obrasDetailEndpoint = 'content/obras/{id}/';
  static final theatersEndpoint = 'content/teatros/';
  static final theatersDetailEndpoint = 'content/teatros/{id}/';
  static final funcionesEndpoint = 'content/funciones/';
  static final personasEndpoint = 'content/personas/';
  
  // Discovery endpoints (buscador)
  static final discoveryBusquedasEndpoint = 'discovery/busquedas/';
  static final discoveryRecomendacionesEndpoint = 'discovery/recomendaciones/';
  
  // Notifications endpoints
  static final notificationsEndpoint = 'notifications/notificaciones/';
  static final notificationsDetailEndpoint = 'notifications/notificaciones/{id}/';
  static final notificationsPreferenciasEndpoint = 'notifications/preferencias/';
  static final notificationsPreferenciasDetailEndpoint = 'notifications/preferencias/{usuario_id}/';
  static final notificationsRecomendacionesPersonalizadasEndpoint = 'notifications/recomendaciones-personalizadas/';
  
  // Tickets endpoints
  static final ticketsDetallesEndpoint = 'tickets/detalles/';
  static final ticketsDisponibilidadEndpoint = 'tickets/disponibilidad/';
  static final ticketsReservasEndpoint = 'tickets/reservas/';
}
