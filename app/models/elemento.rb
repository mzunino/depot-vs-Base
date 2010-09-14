class Elemento < ActiveRecord::Base

	has_one :contenido
	has_one :tipo_elemento

end
