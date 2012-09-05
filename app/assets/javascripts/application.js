// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function toggleElement(origen, destino, valorDeshabilita)
{
    //if (alcance == 3)
    if (origen.value != valorDeshabilita)
    {
        //document.getElementById("cuaderno_control_evento_alumno_id").disabled = false;
        destino.disabled = false;
    }
    else
    {
        destino.value = null;
        destino.disabled = true;
    }
}

function validarBusquedaXDocumento()
{ 
    if (numero_documento.value == "") 
    {
        alert("Seleccione un número de documento");
        return false;
    }
    
    return true;
}

function validarBusquedaXFecha()
{ 
    if (fecha.value == "") 
    {
        alert("Seleccione una fecha");
        return false;
    }
    
    return true;
}

function verificarCantidadCheckBoxes(checkBox, cantidadMinima, cantidadMaxima, entidad)
{
    try
    {
        count = 0;
        
        if(typeof document.salida.elements[checkBox].length === 'undefined')
        {
            if(document.salida.elements[checkBox].checked == true)
            {
                count++;
            }
        }else{
            for(x=0; x < document.salida.elements[checkBox].length; x++)
            {
                if(document.salida.elements[checkBox][x].checked == true)
                {
                    count++;
                }
            }
        }            
        
        if(count < cantidadMinima && cantidadMinima > -1)
        {
            alert("Debe seleccionar por lo menos " + cantidadMinima.toString() + " " + entidad);
            return false;
        }
        else if(count > cantidadMaxima && cantidadMaxima > -1)
        {
            alert("Puede seleccionar como máximo " + cantidadMaxima.toString() + " " + entidad);
            return false;
        }
        else 
        {
            return true;
        }
    }
    catch(exception)
    {
        alert("Error: " + exception);
        return false;
    }
}

function getExtension(Filename) {
    var I = Filename.lastIndexOf(".");
    return (I > -1) ? Filename.substring(I + 1, Filename.length).toLowerCase() : "";
}

function validarFoto(form, inputFile) {
    //var form = document.name_form;

    var ext = "";

    if ( form.inputFile.value == "")
    {
        alert("Por favor, seleccione una foto");
        return false;
    }
        if (form.inputFile.value != "") {
            ext = getExtension(form.inputFile.value);
            if (ext != "jpeg" && ext != "jpg" && ext != "png" && ext != "gif")
            {
                alert("El archivo no es una imagen válida");
                return false;
            }
        else
        {
            return true; 
        }
    }
    
    
}
