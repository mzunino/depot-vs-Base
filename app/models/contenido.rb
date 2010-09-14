class Contenido < ActiveRecord::Base


	has_many :elemento
	has_one :tipo_contenido


        protected

        def self.find_noticias_del_perfil
                find(:all, :order => "id" )
        end


end
