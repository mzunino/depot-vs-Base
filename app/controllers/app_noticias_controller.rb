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
  
  def ejemplo_ajax
        return "Hola" 
  end
  
end
