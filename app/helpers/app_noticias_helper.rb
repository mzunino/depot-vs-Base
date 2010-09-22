module AppNoticiasHelper


	def mostrar_noticia(noticia_id)
	
		logger.debug("USUARIO _________________________ #{@user}" 
	        if(noticia_id.nil? )
	                flash[:notice] = "No se pudo obtener la noticia"
	        else
	
	                #profile_id = user.profile_id
	
	                contenido = ContenidoProfile.find(:all, :conditions => "contenido_id = #{noticia_id} and profile_id = #{profile_id}")
	
	                if(!contenido.nil?)
	                      @noticia = Contenido.find_by_id(noticia_id)

	                     ## Debo conseguir el template asociado al tipo de noticia para hacer el render
	                      render_noticia = TipoContenido.find(@noticia.tipo_id).template
	                      @elementos = Elemento.find_all_by_contenido_id( @noticia.id, :all)
	
	                  ### Debo pasar la lista de elementos encontrados al render del contenido para que muestre el mismo
	
	                      render (:partial => render_noticia , :object => @elementos )
	                else
	                      flash[:notice] = "No tiene privilegios para ver la noticia"
	                end
	
	        end
	end

        def mostrarElemento(hash, ubicacion, elemento_vector)

		if hash.nil?
			return "Dato no cargado"
		else
			if hash[ubicacion].nil?
				return "Dato no cargado"
			else
				if hash[ubicacion][elemento_vector].nil?
					return "Dato no cargado"
				else
					return hash[ubicacion][elemento_vector]
				end
			end
		end

           

        end


end
