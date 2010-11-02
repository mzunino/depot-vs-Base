class Profile < ActiveRecord::Base


	has_many :users
  
  belongs_to :entities

	validates_presence_of  :container_id, :message => 'Debe seleccionar un contenedor para el Perfil'


	NIVELES_DE_USUARIO = [['Usuario', 0], ['Administradores', 1]]

  # Se obtiene los profiles asociados a la entidad que se encuentra registrada en el sistema
  def obtener_profiles_entidad_actual
    
      profiles = nil
      if( !session[:profile].nil? )
          
          entidad_id = session[:profile].entidad_id
      
          profiles = Profile.find(:all, :conditions => "entidad_id = #{entidad_id}")
          
      end
      
      return profiles
          
  end
  
end
