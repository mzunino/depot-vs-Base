module AppNoticiasHelper

        # Dado un hash con elementos cargados, devuelve el que corresponda a la ubicación solicitada,
        # y dentro de la ubicación si habiera mas de uno devuelve el también solicitado.
        # Parametros: hash, ubicacion, elemento_dentro de la ubicación
        # Devuelve: un string con el elemento dibujado 
        def mostrarElemento(hash, ubicacion, elemento_vector)

            html_generado = ""
            
            if !hash.nil? && !hash[ubicacion].nil? && !hash[ubicacion][elemento_vector].nil?
                            html_generado += hash[ubicacion][elemento_vector]
            end
          
            return html_generado
        end



      # Obtiene una lista de templates disponibles (tipos de contenidos) y lo lista en un formato que 
      # el usuario pueda seleccionar gráficamente
      def H_app_not_mostrar_templates_disponibles
        
        tipos_disponibles = TipoContenido.find(:all)
        
        @modo_muestra_template = true
        
        html_generado = "<div class='contenedor_tipos_contenidos'> "
        for tipo in tipos_disponibles
                    html_generado += "<div class='desc_tipo_contenido_muestra'> "
                    html_generado += tipo.descripcion
                    html_generado += "</div> "
                    html_generado += "<div class='tipo_contenido_muestra'> "
                    html_generado += render (:partial => tipo.template )
                    html_generado += "</div> "
        end   
        
        html_generado += "</div>"
        
        return html_generado
          
      end
      
end
