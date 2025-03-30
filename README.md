# Prueba técnica
Desarrollar una aplicación de gestión de usuarios

La app se la realizo con las siguientes tecnologias:
* SwiftUI
* Alamofire
* Realm

Las librerias son importados mediantes SPM.

Se utilizó una aquitectura MVVM en la cual se separaron los View, ModelView, Model y Managers
 para conexiones API, Persistencia local de datos y Localización de gps.
 
 La app consta de 3 View principales UserListView, UserDetailView y CreateUserView

En UserListView mostramos el listado obtenido mediante el consumo al API y guardado de la información en local. para mantener la informacion actualizada en UI se uso ObservedResults de Realm el cual mediante reactividad mantiene informada de cambios en los usuarios de la base local.

UserDetailView contiene la lógica de Edición y Eliminación de usuario local el cual solo puede editar el campo nombre y correo de los usuarios.
 
CreateUserView esta encargado de la creación de nuevos usuarios en la base local, en el mismo pueden encontrar la opcion de obtener la geolocalizacion en tiempo real(si el usuario lo habilita), el mismo funciona en background.

Para el manejo de los modelos, se implemento clases heredadas de Codable para la facil optencion del response del API e Identifiable para la compatibilidad de REALM.

