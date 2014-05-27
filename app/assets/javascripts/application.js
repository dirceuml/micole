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
//= require jquery_nested_form


function toggleElement(valorDeshabilita, valorFechaObligatoria)
{
    origen = document.getElementById("cuaderno_control_evento_tipo_evento_id");
    destino = document.getElementById("cuaderno_control_evento_alumno_id");     
    alumno = document.getElementById("alumno");     
    destinoFecha = document.getElementById("cuaderno_control_evento_fecha_evento");         
    
    if (valorDeshabilita.indexOf(origen.value.toString()) != -1)
    {
        destino.required = true;
        alumno.style.display = "block";
    }
    else
    {
        alumno.style.display = "none";
        destino.value = null;
        destino.required = false;
    }
    
    if (valorFechaObligatoria.indexOf(origen.value.toString()) != -1)
    {
        destinoFecha.required = true;
    }
    else
    {
        destinoFecha.required = false;
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

function validarCodigoAlumno()
{ 
    if (codigo_alumno.value == "") 
    {
        alert("Ingrese el Código del alumno");
        return false;
    }
    return true;
}

function PreviewImage(input) 
{
    if (input.files && input.files[0]) {
      var oFReader = new FileReader();
      oFReader.readAsDataURL(input.files[0]);

      oFReader.onload = function (oFREvent) {
          document.getElementById("preview").src = oFREvent.target.result;
      };
    }
    else
    {
      preview.setAttribute('src', '/assets/blank.gif');
    }
};

function toggleElementPerfil()
{ 
    origen = document.getElementById('usuario_perfil_id');
    
    div_persona_vinculada = document.getElementById("persona_vinculada");
    div_alumno = document.getElementById("alumno");
    div_nivel_acceso = document.getElementById("nivel_acceso");
    
    persona_vinculada = document.getElementById('usuario_persona_vinculada_id');
    alumno = document.getElementById('usuario_alumno_id');
    nivel_acceso1 = document.getElementById('radio-opc1');
    nivel_acceso2 = document.getElementById('radio-opc2');
    
    switch (origen.value) {
      case "2":
        div_persona_vinculada.style.display = "block";          
        div_alumno.style.display = "none";   
        div_nivel_acceso.style.display = "none";
        
        persona_vinculada.required = true;   
        alumno.required = false;   
        nivel_acceso1.required = false;   
        nivel_acceso2.required = false;   
        
        alumno.value = null;
        nivel_acceso1.value = null;
        nivel_acceso2.value = null;
        
        break;
      case "3":
        div_persona_vinculada.style.display = "none";          
        div_alumno.style.display = "none";   
        div_nivel_acceso.style.display = "block";
        
        persona_vinculada.required = false;   
        alumno.required = false;   
        nivel_acceso1.required = true;
        nivel_acceso2.required = true;   
        
        persona_vinculada.value = null;
        alumno.value = null;
        
        break;
      case "4":
        div_persona_vinculada.style.display = "none";          
        div_alumno.style.display = "block";   
        div_nivel_acceso.style.display = "none";
        
        persona_vinculada.required = false;   
        alumno.required = true;   
        nivel_acceso1.required = false;   
        nivel_acceso2.required = false;   
        
        persona_vinculada.value = null;
        nivel_acceso1.value = null;
        nivel_acceso2.value = null;
        
        break;
      default:        
        div_persona_vinculada.style.display = "none";          
        div_alumno.style.display = "none";   
        div_nivel_acceso.style.display = "none";
        
        persona_vinculada.required = false;   
        alumno.required = false;   
        nivel_acceso1.required = false;   
        nivel_acceso2.required = false;   
        
        persona_vinculada.value = null;
        alumno.value = null;
        nivel_acceso1.value = null;
        nivel_acceso2.value = null;
   }
}


function habilitaAutorizacion()
{
    div_autorizacion = document.getElementById("autorizacion");
    requiere_autorizacion = document.getElementById("actividad_requiere_autorizacion");
    limite_autorizacion = document.getElementById("actividad_limite_autorizacion");
    
    if (requiere_autorizacion.checked)
    {
        div_autorizacion.style.display = "block";        
        limite_autorizacion.required = true;
    }
    else
    {
        div_autorizacion.style.display = "none";        
        limite_autorizacion.value = "";        
        limite_autorizacion.required = false;
    }
}

function validarAutorizacion() 
{
    sFechaActividad = document.getElementById("actividad_fecha_hora_inicio").value.substring(0, 10);
    
    dFechaActividad = new Date(sFechaActividad + " 12:00:00");
    sFechaActividad = dFechaActividad.getFullYear() + "-" + leftPad(dFechaActividad.getMonth()+1, 2, "0") + "-" + leftPad(dFechaActividad.getDate(), 2, "0");
    
    dFechaActividadMenos1 = sumarDias(dFechaActividad, -1);
    sFechaActividadMenos1 = dFechaActividadMenos1.getFullYear() + "-" + leftPad(dFechaActividadMenos1.getMonth()+1, 2, "0") + "-" + leftPad(dFechaActividadMenos1.getDate(), 2, "0");

    dFechaActividadMenos2 = sumarDias(dFechaActividad, -2);
    sFechaActividadMenos2 = dFechaActividadMenos2.getFullYear() + "-" + leftPad(dFechaActividadMenos2.getMonth()+1, 2, "0") + "-" + leftPad(dFechaActividadMenos2.getDate(), 2, "0");

    fecha_hora_fin = document.getElementById("actividad_fecha_hora_fin");
    limite_autorizacion = document.getElementById("actividad_limite_autorizacion");
    inicio_notificacion = document.getElementById("actividad_inicio_notificacion");
    fin_notificacion = document.getElementById("actividad_fin_notificacion");
    
    fecha_hora_fin.setAttribute("min", sFechaActividad + "T09:00:00");
     
    limite_autorizacion.setAttribute("min", sFechaActividadMenos2);
    limite_autorizacion.setAttribute("max", sFechaActividadMenos1);
    
    inicio_notificacion.setAttribute("max", sFechaActividadMenos1);
    
    fin_notificacion.setAttribute("max", sFechaActividadMenos1);
}

function habilitaNotificacion()
{
    div_notificacion = document.getElementById("notificacion");
    inicio_notificacion = document.getElementById("actividad_inicio_notificacion");
    fin_notificacion = document.getElementById("actividad_fin_notificacion");
    frecuencia_dias_notificacion = document.getElementById("actividad_frecuencia_dias_notificacion");

    if (inicio_notificacion.value == "")
    {
        div_notificacion.style.display = "none";
     
        fin_notificacion.value = "";
        frecuencia_dias_notificacion.value = "";
        
        fin_notificacion.required = false;
        frecuencia_dias_notificacion.required = false;
    }
    else
    {
        div_notificacion.style.display = "block";
      
        fin_notificacion.required = true;
        frecuencia_dias_notificacion.required = true;
        
    }
}

function sumarDias(fecha, dias){
    fecha.setDate(fecha.getDate() + dias); 
    return fecha;
}

function leftPad(numero, ancho, relleno) {
  var zero = ancho - numero.toString().length + 1;
  return Array(+(zero > 0 && zero)).join(relleno) + numero;
}