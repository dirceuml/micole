class Ability
  include CanCan::Ability

  def initialize(user)
  
#    user.perfil.permisos.each do |permiso|
#      if permiso.subject_id.nil?
#        can permiso.action.to_sym, permiso.subject_class.constantize
#      else
#        can permiso.action.to_sym, permiso.subject_class.constantize, :id => permiso.subject_id
#      end
#    end
    
       user ||= Usuario.new # guest user (not logged in)
       
       if user.id.nil?
         cannot :all, :all
       else
         if user.perfil.id == 1 # administrador
           can :manage, :all
         else
           if user.perfil.id == 2 # padre
             can :read, CuadernoControl, :estado => 2 
             can [:update, :read], CuadernoControlRevision, :cuaderno_control => { :estado => 2 }
             can :update, Autorizacion
             can :read, Actividad, :estado => [2,3,4]
             can :read, ActividadSeccion, :actividad => { :estado => [2,3,4] }
             can :read, Menu
           else # 3 personal administrativo
             can :read, :all
             can :manage, CuadernoControl
             can :manage, CuadernoControlEvento
             can :read, CuadernoControlRevision
             can :manage, Actividad
             can :read, Autorizacion
             can :create, Asistencia
             can :read, Menu
           end
         end         
       end
  end
end
