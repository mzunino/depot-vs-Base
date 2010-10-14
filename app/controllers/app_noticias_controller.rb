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

  def admin_noticia
    # Administrador de contenidos
        
    
  end
  
  def save
    
    Contenido.transaction do
      
      @contenido = Contenido.new()
      @contenido.tipo_id = params[:template_id] 
      @contenido.descripcion = params[:titulo]
      @contenido.rotacion = params[:rotacion]
      @contenido.fecha = params[:fecha_ingreso]
      @contenido.app_id = params[:app_id]
      
      
      @elemento = Elemento.new()
      @elemento.valor = params[:valor_elemento]
      @elemento.tipo_id = params[:tipo_elemento_id]
      @elemento.ubicacion = params[:ubicacion_elemento]
      
      @contenido_profile = ContenidoProfile.new()
      @contenido_profile.profile_id = params[:profile_id]
      
      
      #@contenido.save!
      idContenido = @contenido.id
      logger.debug("este es el contenido generado: #{params[:template_id]}")
      
      
      # Seteo los ids necesarios recien obtenidos
      #@elemento.contenido_id = @contenido.id
      #@contenido_profile.contenido_id = @contenido.id
      
      #@elemento.save!
      #@contenido_profile.save!
      
      #redirect_to :controller => :app_noticias, :action => "index"
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
