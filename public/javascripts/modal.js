
$(document).ready(function(){
        //parametros principales
        
        var contenidoHTML = '<h1>No hay contenido para mostrar</h1><%=@contenido_modal%><button onclick=\"closeModal()\">Cerrar</button>'

        var ancho = $(window).width() * 0.75;
        var alto = $(window).height() * 0.75;

        $(window).resize(function(){
                // dimensiones de la ventana del explorer
                var wscr = $(window).width();
                var hscr = $(window).height();

                // estableciendo dimensiones de fondo
                $('#bgtransparent').css("width", wscr);
                $('#bgtransparent').css("height", hscr);
                
                // estableciendo tamaño de la ventana modal
                $('#bgmodal').css("width", ancho+'px');
                $('#bgmodal').css("height", alto+'px');
                
                // obtiendo tamaño de la ventana modal
                var wcnt = $('#bgmodal').width();
                var hcnt = $('#bgmodal').height();
                
                // obtener posicion central
                var mleft = ( wscr - wcnt ) / 2;
                var mtop = ( hscr - hcnt ) / 2;
                
                // estableciendo ventana modal en el centro
                $('#bgmodal').css("left", mleft+'px');
                $('#bgmodal').css("top", mtop+'px');
        });
        
 });
       
function mostrarModal(url){

	var http = createAjax();
	var params = "";
	var cont = "";

	http.open("GET", url, true);

	http.onreadystatechange = function() {//Call a function when the state changes.
		
		if(http.readyState == 4 && http.status == 200) {
			mostrarContenido( http.responseText );
			
		}
	}
	http.send(null);

}


function mostrarContenido(contenido){

	

	var contenidoHTML = '<div id="div_botones_modal"><button class="btn_cerrar_modal" onclick=\"closeModal()\">X</button></div><div id="contenido_modal">' + contenido + "</div>";

        var ancho = 600;
        var alto = 250;

        // fondo transparente
        // creamos un div nuevo, con dos atributos
        var bgdiv = $('<div>').attr({
                               className: 'bgtransparent',
                               id: 'bgtransparent'
                               });

        // agregamos nuevo div a la pagina
        $('body').append(bgdiv);

        // obtenemos ancho y alto de la ventana del explorer
        var wscr = $(window).width();
        var hscr = $(window).height();

        //establecemos las dimensiones del fondo
        $('#bgtransparent').css("width", wscr);
        $('#bgtransparent').css("height", hscr);


        // ventana modal
        // creamos otro div para la ventana modal y dos atributos
        var moddiv = $('<div>').attr({
                                className: 'bgmodal',
                                id: 'bgmodal'
                                });

        // agregamos div a la pagina
        $('body').append(moddiv);

        // agregamos contenido HTML a la ventana modal
        $('#bgmodal').append(contenidoHTML);

        // redimensionamos para que se ajuste al centro y mas
        $(window).resize();


}


function recogeInfo()
{
    if(xmlHttp.readyState == 4 && xmlHttp.status == 200)
    {
	alert(xmlHttp.responseText);
    }
}
 
function closeModal(){
        // removemos divs creados
        $('#bgmodal').remove();
        $('#bgtransparent').remove();
}




function createAjax()
{

	var obj = false;
	
	if(window.XMLHttpRequest)
	{
		try 
		{
			//Mozilla - Firefox, etc
			obj = new XMLHttpRequest();
		}
		catch (e)
		{
			request = false;
		}		
	}
	else if (window.ActiveXObject)
	{
		try
		{
			obj = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e)
		{
			try
			{
				obj = new ActiveXObject("Microsoft.XMLHTTP");				
			}
			catch (e)
			{
				obj = false;
			}				
		}		
	}
	if (obj)
	{
		return obj;
		
	}
	else
	{
		return null;
	}
	
}
