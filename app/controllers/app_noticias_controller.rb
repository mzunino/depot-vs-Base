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

  end

  # parametro: noticia_id
  def mostrar_noticia
	# muestra una noticia determinada
 	 render(:layout => false)
  end
	

end
