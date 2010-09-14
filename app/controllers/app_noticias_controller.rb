class AppNoticiasController < ApplicationController
  def index

	@noticias = Contenido.find_noticias_del_perfil


  end

  def hola
	return "Hola"
  end

  def controlarNulabilidad


	if params[x[1]].nil?
		return "No esta cargado"
	else
		return params[x[1]][params[2]]
	end

  end

end
