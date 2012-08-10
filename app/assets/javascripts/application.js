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

function verificarCantidadCheckBoxes(checkBox, cantidadMinima, cantidadMaxima, entidad)
{
    count = 0;
    
    for(x=0; x < document.salida.elements["alumno_id[]"].length; x++)
    {
        if(document.salida.elements["alumno_id[]"][x].checked == true)
        {
            count++;
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