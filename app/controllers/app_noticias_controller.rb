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
        
        #@profiles_habilitados = ContenidoProfile.find(:all, :conditions => "contenido_id = #{@contenido.id}")
        
       
        #logger.debug("Contenido del form: #{@form}")
        
        
        #params[:tipo_template_id] = @contenido.tipo_id 
        
        #@profile  = @profiles_habilitados[1] 
        
        
        
        
    
  end
  
  def update
    
  end
  
    # GET /apps/save
  def invento
    
    Contenido.transaction do
      
      @contenido = Contenido.new()
      @contenido.tipo_id = params[:contenido][:id]
      @contenido.tipo_id = params[:contenido][:template_id] 
      @contenido.descripcion = params[:contenido][:descripcion]
      @contenido.rotacion = params[:contenido][:rotacion]
      @contenido.fecha = params[:contenido][:fecha_ingreso]
      @contenido.app_id = params[:contenido][:app_id]
      
      
      @elementos = params[:elemento]
      
      
      
      logger.debug("############]]]]]]]]]]]]]]]]]]]############## esta lista de elementos pasada tiene #{@elementos.size()}")
#      @contenido.tipo_id = params[:contenido][:id_elemento]
#      @elemento.valor = params[:contenido][:valor]
#      @elemento.tipo_id = params[:contenido][:tipo_elemento_id]
#      @elemento.ubicacion = params[:contenido][:ubicacion]
#      
#      @contenido_profile = ContenidoProfile.new()
#      @contenido_profile.profile_id = params[:contenido][:profile_id]
      
      #@contenido.save!
      
 
      # Seteo los ids necesarios recien obtenidos
      #@elemento.contenido_id = @contenido.id
      #@contenido_profile.contenido_id = @contenido.id
      
      #@elemento.save!
      #@contenido_profile.save!

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
  
end
