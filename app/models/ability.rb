class Ability
  include CanCan::Ability

  def initialize(user)
  
    if !user.id.nil?
      if user.perfil.id == 1 # administrador
        can :manage, :all
      else
        user.perfil.permisos.each do |permiso|
          if permiso.subject_id.nil?
            can permiso.action.to_sym, permiso.subject_class.constantize
          else
            can permiso.action.to_sym, permiso.subject_class.constantize, :id => permiso.subject_id
          end
        end
      end
    end
 can :manage, Perfil
 can :manage, Permiso
 can :manage, PerfilPermiso
#       user ||= Usuario.new # guest user (not logged in)
#       
#       if user.id.nil?
#         cannot :all, :all
#       else
#         if user.perfil.id == 1 # administrador
#           can :manage, :all
#         else
#           if user.perfil.id == 2 # padre
#             can :read, CuadernoControl 
#             can [:update, :read], CuadernoControlRevision
#             can :update, Autorizacion
#             can :read, Actividad
#             can :calendario, Actividad
#             can :autorizacion, Autorizacion
#             can :read, ActividadSeccion
#             can :read, Menu
#           else # 3 personal administrativo
#             can :read, :all
#             can :manage, CuadernoControl
#             can :manage, CuadernoControlEvento
#             can :read, CuadernoControlRevision
#             can :manage, Actividad
#             can :read, Autorizacion
#             can :create, Asistencia
#             can :read, Menu
#           end
#         end         
#       end
  end
end
