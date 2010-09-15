module AppNoticiasHelper


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
