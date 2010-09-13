class Profile < ActiveRecord::Base


	has_many :user

	validates_presence_of  :container_id, :message => 'Debe seleccionar un contenedor para el Perfil'


	NIVELES_DE_USUARIO = [['Usuario', 0], ['Administradores', 1]]


end
