Micole::Application.routes.draw do 

  get "admin/archivos/subir_archivos" => "archivos#subir_archivos", :as => "subir_archivos"
  post "admin/archivos/subir_archivos" => "archivos#subir_archivos", :as => "subir_archivos"
  get "admin/archivos/cargar_alumnos" => "archivos#cargar_alumnos", :as => "cargar_alumnos"
  post "admin/archivos/cargar_alumnos" => "archivos#cargar_alumnos", :as => "cargar_alumnos"
  get "admin/archivos/cargar_padres" => "archivos#cargar_padres", :as => "cargar_padres"
  post "admin/archivos/cargar_padres" => "archivos#cargar_padres", :as => "cargar_padres"
  get "admin/archivos/cargar_vinculos" => "archivos#cargar_vinculos", :as => "cargar_vinculos"
  post "admin/archivos/cargar_vinculos" => "archivos#cargar_vinculos", :as => "cargar_vinculos"
  get "admin/archivos/listar" => "archivos#listar_archivos", :as => "listar_archivos"
  post "admin/archivos/borrar_archivos" => "archivos#borrar_archivos", :as => "borrar_archivos"
  get "admin/archivos/guardar_log" => "archivos#guardar_log", :as => "guardar_log"
  post "admin/archivos/guardar_log" => "archivos#guardar_log", :as => "guardar_log"

  resources :perfiles_permisos

  resources :permisos

  resources :curriculos

  resources :alumnos_personas_vinculadas
  
  get "salida" => "alumnos_personas_vinculadas#consultar", :as => "salida"
  
  resources :personas_vinculadas  
  
  resources :asistencias
  post "salidas" => "asistencias#crear_en_bloque", :as => "salidas"
  get "consulta_asistencia" => "asistencias#consultar", :as => "consulta_asistencia"
  
  get "marcacion" => "asistencias#registrar", :as => "marcacion"
  post "marcaciongrabar" => "asistencias#registrar_grabar", :as => "marcaciongrabar"  
  
  resources :actividades_secciones

  resources :actividades do
    resources :actividades_secciones
  end
  get "calendario_actividades/:anio/:mes/:dia" => "actividades#calendario", :as => "calendario_actividades"

  resources :cursos

  resources :autorizaciones
  
  resources :notas

  resources :menus
  
  get "menu" => "menus#main", :as => "menu"

  resources :perfiles_transacciones

  resources :transacciones

  resources :listas_valores

  resources :perfiles do
    resources :perfiles_permisos
  end
  
  #get "sessions/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"  
  get "sign_up" => "usuarios#new", :as => "sign_up"

  resources :usuarios
  resources :sessions
  

  resources :tipos_notas

  resources :tipos_eventos

  resources :cuaderno_controles_revisiones
  
  resources :alumnos do
    resources :alumnos_personas_vinculadas
  end
  
  resources :cuadernos_controles do
    resources :cuaderno_controles_eventos
  end
  
  get "cierre_cuadernos_controles/:id" => "cuadernos_controles#cerrar", :as => "cerrar_cuaderno_control"

  resources :anios_alumnos

  resources :secciones

  resources :grados

  resources :anios_escolares

  resources :colegios

  resources :alumno_padres

  resources :colegio_anio_escolars

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
 root :to => 'public#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
