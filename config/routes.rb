Micole::Application.routes.draw do 

  resources :curriculos

  resources :alumnos_personas_vinculadas
  
  get "alumnos_personas_vinculadas/:tipo_documento/:numero_documento/consultar" => "alumnos_personas_vinculadas#consultar", :as => "consultar_alumnos_personas_vinculadas"
  post "alumnos_personas_vinculadas/buscar" => "alumnos_personas_vinculadas#buscar", :as => "buscar_alumnos_personas_vinculadas"
  
  resources :personas_vinculadas  
  
  resources :asistencias
  post "asistencias/crear_en_bloque" => "asistencias#crear_en_bloque", :as => "crear_en_bloque_asistencias"
  
  resources :actividades_secciones

  resources :actividades

  resources :cursos

  resources :autorizaciones

  resources :notas

  resources :menus
  
  get "menu" => "menus#main", :as => "menu"

  resources :perfiles_transacciones

  resources :transacciones

  resources :listas_valores

  resources :perfiles
  
  #get "sessions/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"  
  get "sign_up" => "usuarios#new", :as => "sign_up"

  resources :usuarios
  resources :sessions
  

  resources :tipos_notas

  resources :tipos_eventos

  resources :cuaderno_controles_revisiones
  
  get "revision_cuaderno_control/:usuario" => "cuaderno_controles_revisiones#revision", :as => "revision_cuaderno_control"
  
  resources :alumnos do
    resources :alumnos_personas_vinculadas
  end
  
  get "alumnos/:seccion_id/listar_seccion" => "alumnos#listar_seccion", :as => "listar_seccion_alumnos"
  post "alumnos/buscar" => "alumnos#buscar", :as => "buscar_alumnos"
  
  resources :cuadernos_controles do
    resources :cuaderno_controles_eventos
  end
  
  get "cuadernos_controles/:id/cerrar" => "cuadernos_controles#cerrar", :as => "cerrar_cuaderno_control"

  put "cuaderno_controles_revisiones/:id/revisar" => "cuaderno_controles_revisiones#revisar", :as => "revisar_cuaderno_control_revision"

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
