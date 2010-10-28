class AppNoticiasController < ApplicationController
  def index

        if session[:user_id]
              @user=User.find(session[:user_id])
              if @user
                    @profile_id = @user.profile_id
              end 
        end
  	@noticias = Contenido.find_noticias_del_perfil(@profile_id)
  
  	logger.debug("Entre al controler del index, user: #{@profile_id}")
  
  	@modo_listado = true;
 end
 
 
  def mostrar_noticia
  	# muestra una noticia determinada
  	render(:layout => false)
	
  end

  def new
	# Alta de una nueva noticia

  end

 
  # GET /apps/edit
  def edit
    
        #logger.debug("Se esta pasando el id: #{params[:contenido][:id]}"  )
        @contenido = Contenido.find(params[:contenido][:id])
        
        
        #logger.debug("Este es el contenido id obtenido: #{@contenido.id}"  )
        
        @elementos = Elemento.find(:all, :conditions => "contenido_id = #{@contenido.id}")
        #logger.debug ("elemento id : #{@lista_elementos[1].id}")
        
        
        logger.debug("----------------------------------------------------------------Consultando profiles!!!!!! ")
        @contenidos_profiles = ContenidoProfile.find(:all, :conditions => "contenido_id = #{params[:contenido][:id]}")
        logger.debug("Contenido de profiles!!!!!!:  #{@contenidos_profiles.size()} ")
        
        @profiles = Array.new()
        
        for contenido_profile in @contenidos_profiles
        
              logger.debug("Cargando profile id: #{contenido_profile.profile_id}")
              profile = Profile.find_by_id(contenido_profile.profile_id)
              @profiles << profile
          
          
        end
        #@profiles_habilitados = ContenidoProfile.find(:all, :conditions => "contenido_id = #{@contenido.id}")
        
       
        #logger.debug("Contenido del form: #{@form}")
        
        
        #params[:tipo_template_id] = @contenido.tipo_id 
        
        #@profile  = @profiles_habilitados[1] 
        
        
        
        
    
  end
  
 
    # GET /app_noticias/save
  def save_contenido
    
    Contenido.transaction do
      
      if(!params[:contenido].nil? && !params[:contenido][:id].nil? )
      
      
             logger.debug(" Salvando contenido existente id: #{params[:contenido][:id]}")
            @contenido = Contenido.find(params[:contenido][:id])

       # Cargando nuevos valores
            @contenido.id = params[:contenido][:id]
            @contenido.tipo_id = params[:contenido][:template_id] 
            @contenido.descripcion = params[:contenido][:descripcion]
            @contenido.rotacion = params[:contenido][:rotacion]
            @contenido.fecha = params[:contenido][:fecha_ingreso]
            @contenido.app_id = params[:contenido][:app_id]

            if @contenido.update_attributes(params[:contenido])
              flash[:notice] = 'El contenido se actualizo correctamente'
            else
              flash[:notice] = 'Ocurrió un error al actualizar el contenido: ' + @contenido.errors
            end
        
      else
        
            logger.debug(" Salvando contenido nuevo #{params[:contenido][:id]}")
            @contenido = Contenido.new(params[:contenido])
            
            # Salvando nuevo contenido
            @contenido.save!
      end

      
      
      logger.debug(" ELEMENTOS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #{params[:elemento]}")

      
       # Salvando los elementos del contenido
       actualizarElementosContenido()

       # Salvando asociaciones del contenido con los profiles habilitados
       asociarContenidoAPerfiles()

       # Si no hubieron errores vuelvo a la pantalla inicial
      redirect_to :controller => :app_noticias, :action => "index"
      
    end
  rescue ActiveRecord::RecordInvalid => e
    # force checking of errors even if products failed
    
    flash[:notice] = "Error al dar de alta: " + e
    render :action => "admin"
    
  end
  
  
  def ejemplo_ajax
    
    # obtengo el tipo de template a partir del id pasado
    @tipo_template = TipoContenido.find(params[:template_id])
    
    @modo_muestra_template = true
    
    respond_to { |format| format.js }

       
  end
  
private 


  # Recorre la lista de elementos pasada, si hay cambio en los mismos los actualiza y si hay nuevos los agrega
  # Params: :elementos[], :contenido
  def actualizarElementosContenido


           contenido_id = params[:contenido][:id]
    
          # Se borran elementos originales del contenido
            @elementos_asociados = Elemento.find(:all, :conditions => "contenido_id = #{params[:contenido][:id]}")
            
            for elemento in @elementos_asociados
                    elemento.destroy
            end
            

            @elementos = params[:elemento]
            logger.debug("Esta es la cantidad de elementos para grabar nuevos: #{@elementos.size()}"  )
            if (!@elementos.nil? && @elementos.size() > 0 )
              
                      # Guardando los nuevos elementos
                      @elementos.each do |elemento|

                                  campos = elemento[1]  # 1 corresponde al hash de campos / 0 es el id del elemento actual
                                  
                                  elemento_nuevo = Elemento.new()
                                  elemento_nuevo.id = campos[:id]
                                  elemento_nuevo.ubicacion = campos[:ubicacion] 
                                  elemento_nuevo.contenido_id = contenido_id
                                  elemento_nuevo.valor = campos[:valor]
                                  elemento_nuevo.tipo_id = campos[:tipo_id]
                                  
                                  # Salvo
                                  elemento_nuevo.save!
         
                      end
              end 
  end

  # Asocia una lista de profiles a un contenido determinado
  # Params: :profiles[], :contenido
  def asociarContenidoAPerfiles
    
          # Se borran asociaciones previas al contenido
            @contenidos_profiles = ContenidoProfile.find(:all, :conditions => "contenido_id = #{params[:contenido][:id]}")
            
            for contenido_profile in @contenidos_profiles
                    contenido_profile.destroy
            end
            

            @profiles = params[:profiles]
            if (!@profiles.nil? && @profiles.size() > 0 )
              
                      # Guardando las nuevas asociaciones
                      for profile in @profiles
          
                                  contenido_profile = ContenidoProfile.new()
                                  contenido_profile.profile_id = profile[0]
                                  contenido_profile.contenido_id = params[:contenido][:id]
                                  contenido_profile.save!
          
                      end
              end 
  end

  
end
