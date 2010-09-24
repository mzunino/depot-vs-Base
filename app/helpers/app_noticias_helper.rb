module AppNoticiasHelper


        def mostrarElemento(hash, ubicacion, elemento_vector)

		if hash.nil?
			return ""
		else
			if hash[ubicacion].nil?
				return ""
			else
				if hash[ubicacion][elemento_vector].nil?
					return ""
				else
					return hash[ubicacion][elemento_vector]
				end
			end
		end

           

        end


end
