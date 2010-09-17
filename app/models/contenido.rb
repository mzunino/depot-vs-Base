class Contenido < ActiveRecord::Base


	has_many :elemento
	has_one :tipo_contenido


        protected

        def self.find_noticias_del_perfil(profile_id)

		#logger.debug("Buscando noticias para el perfil: " + profile_id)

		if profile_id.nil?
			condicion = "cont_pro.profile_id is null " 
		else
			condicion = "cont_pro.profile_id = #{profile_id}"
		end
		logger.debug("Con la condicion: " + condicion)

		self.find(:all, :conditions => condicion ,
              			:joins => "as contenidos inner join contenido_profiles as cont_pro on contenidos.id = cont_pro.contenido_id" ) 


        end


end
