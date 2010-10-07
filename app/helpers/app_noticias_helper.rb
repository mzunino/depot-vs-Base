module AppNoticiasHelper

        # Dado un hash con elementos cargados, devuelve el que corresponda a la ubicación solicitada,
        # y dentro de la ubicación si habiera mas de uno devuelve el también solicitado.
        # Parametros: hash, ubicacion, elemento_dentro de la ubicación
        # Devuelve: un string con el elemento dibujado 
        def mostrarElemento(hash, ubicacion, elemento_vector)
          
            html_generado = "<div class=\"div_template_#{ubicacion}\"> "
            
            if !hash.nil? && !hash[ubicacion].nil? && !hash[ubicacion][elemento_vector].nil?
                            html_generado += hash[ubicacion][elemento_vector]
            end
          
            html_generado += "</div>"
          
            return html_generado
        end


end
