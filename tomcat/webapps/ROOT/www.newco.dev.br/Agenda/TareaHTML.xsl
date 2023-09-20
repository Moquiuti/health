<?xml version="1.0" encoding="iso-8859-1" ?>
<!--

	Mantenimiento de una tarea de la agenda personal de MedicalVM
	
	Permite tratar citas o tareas
	
	(c) may 2003 ET
	
	
	T:	Tarea normal (presenta todos los campos)
	R:	Tarea reducida: Fecha Inicio, Responsable, Descripcion (Estado=Pendiente, Descripcion=null, Acceso='C', Actividad='OTROS')
	C:	Cita

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Nueva tarea para la Agenda de MedicalVM</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
        <!--

var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';

//
//	Monta las fechas, comprueba el formulario y envia
//
function enviarFormulario(form)
{
	//PresentaCampos(form);		//solodebug

	if(validarFormulario(form)==true)
	{
		//	Monta las fechas juntando la parte dia/mes/año con  hora:minuto
		if (form.elements['IDTIPOTAREA'].value=='T')
		{
			//	Para tareas construimos las fechas de inicio y final reales
			if (form.elements['DIAINICIO'].value!='')
				form.elements['FECHANO_INICIO'].value=form.elements['DIAINICIO'].value+form.elements['HORAINICIO'].value;
			else form.elements['FECHANO_INICIO'].value='';
			
			if (form.elements['DIAINICIO'].value!='')
				form.elements['FECHANO_FINAL'].value=form.elements['DIAFINAL'].value+form.elements['HORAFINAL'].value;
			else form.elements['FECHANO_FINAL'].value='';

			form.elements['FECHANO_FINALPREVISTA'].value=form.elements['DIAFINALPREVISTO'].value+' '+form.elements['HORAFINALPREVISTA'].value;

		}
		else if (form.elements['IDTIPOTAREA'].value=='C')
		{
			//	Para citas ponemos al mismo usuario propietario como responsable y controlador de la tarea
			form.elements['IDUSUARIOCONTROL'].value=form.elements['IDUSUARIORESPONSABLE'].value;
		
			//	Para citas fijamos estos valores a null
			form.elements['FECHANO_INICIO'].value='';
			form.elements['FECHANO_FINAL'].value='';
			//	El dia de final de la tarea debe ser el mismo que el de inicio
			form.elements['DIAFINALPREVISTO'].value=form.elements['DIAINICIOPREVISTO'].value;

			form.elements['FECHANO_FINALPREVISTA'].value=form.elements['DIAFINALPREVISTO'].value+' '+form.elements['HORAFINALPREVISTA'].value;
		}
		else if (form.elements['IDTIPOTAREA'].value=='R')
		{
			//	Para tareas simplificadas ponemos al mismo usuario propietario como responsable y controlador de la tarea
			form.elements['IDUSUARIOCONTROL'].value=form.elements['IDUSUARIORESPONSABLE'].value;
		
			//	Para citas fijamos estos valores a null
			form.elements['FECHANO_INICIO'].value='';
			form.elements['FECHANO_FINAL'].value='';
			//	El dia de final de la tarea lo dejamos abierto
			form.elements['FECHANO_FINALPREVISTA'].value='';
		}
		form.elements['FECHANO_INICIOPREVISTA'].value=form.elements['DIAINICIOPREVISTO'].value+' '+form.elements['HORAINICIOPREVISTA'].value;
	
		//	Envia el formulario
		SubmitForm(form);
	} 
	else
	{
		alert(msgError);
	}
}

function validarFormulario(form)
{
	var	listacampos='';
	var error='';
	
	for(var n=0;n<form.length;n++)
	{
		switch (form.elements[n].name)
		{
			case 'TITULO':
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Titulo\''+'\n';
					}
					break;  

			case 'DIAINICIOPREVISTO':
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Fecha inicio previsto\''+'\n';
					}
				   if(form.elements[n].value!='')
					{
						if (test2(form.elements[n])!='')
						{
				   			error='La fecha de Inicio introducida no está en un formato correcto (dd/mm/yyyy).'+'\n';
						}
					}
				  break;
				  
			case 'HORAINICIOPREVISTA'://
				if(form.elements['TODOELDIA'].checked==false){
				  if(validarHoras(document.forms['form1'].elements['HORAINICIOPREVISTA'].value,'MAYOR',document.forms['form1'].elements['HORAFINALPREVISTA'].value)){
				    error='La hora de inicio es posterior a la hora de final.'+'\n';
				  }
				}
				break;
				
			case 'HORAINICIO'://
				  if(validarHoras(document.forms['form1'].elements['HORAINICIO'].value,'MAYOR',document.forms['form1'].elements['HORAFINAL'].value)){
				    error='La hora de inicio real es posterior a la hora de final real.'+'\n';
				  }
				break;
				
				
				
				

			case 'DIAFINALPREVISTO'://
				if (form.elements['IDTIPOTAREA'].value=='T')
				{
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Fecha final prevista\''+'\n';
					}
				   if(form.elements[n].value!='')
					{
						if (test2(form.elements[n])!='')
						{
				   			error='La fecha de Final introducida no está en un formato correcto (dd/mm/yyyy).'+'\n';
						}
					}
				}
				break;
		}//switch
	}//for 
  
	if ((listacampos=='')&&(error==''))
		return true;
	else
	{
		msgError='';
		if (listacampos!='')
			msgError=msgError+'Los siguientes campos son obligatorios pero no están informados:\n'+listacampos;
		if (error!='')
			msgError=msgError+error;
		
		msgError=msgError+msgErrorStd;
		return false;
	}
}

//---------declaracion-funciones--------------------------------------	  
function validarNoNulo(obj){
  if(obj.value=="")
    return false
  else
    return true;
}

function validarEsCaracter(obj){
   var cadena=obj.value.toLowerCase();
   for(var n=0;n<cadena.length;n++){
     var car=cadena.substring(n,n+1);
     if((car>='0') && (car<='9'))
       return false;  
   }	
  return true;
}

function validarEsEntero(obj){

  var error=0;
  
  for(var n=0;n<obj.value.length;n++){
    var car=obj.value.substring(n,n+1);
    if((car<"0") || ("9"<car))
      error=1;   
  }	
  if (error==1){
    return false;
  }
  else
    return true;
}

function validarEsMail(obj){
   var cadena=obj.value.toLowerCase();
     for(var n=0;n<cadena.length;n++){
       var car=cadena.substring(n,n+1);
       if(car=='@')
         return true;   
     }	
  return false;
}

function validarTextoNoNulo(obj){
  if(validarNoNulo(obj)==true)
    return validarEsCaracter(obj);		
  else 
    return false;
}

function validarNumericoNoNulo(obj){
  if(validarNoNulo(obj)==true)
    return validarEsEntero(obj);		
  else 
    return false;
}

function validarLongitud(obj, longitud){
  if(obj.value.length==longitud)
    return true;		
  else 
    return false;
}

function activarDesactivarHoras(objChk){
  if(objChk.checked==true){
    document.forms['form1'].elements['HORAINICIOPREVISTA'].disabled=true;
    document.forms['form1'].elements['HORAFINALPREVISTA'].disabled=true;
  }
  else{
    document.forms['form1'].elements['HORAINICIOPREVISTA'].disabled=false;
    document.forms['form1'].elements['HORAFINALPREVISTA'].disabled=false;
  }
}

function validarHoras(horaInicio,tipo,horaFinal){
	//	ET	1/7/03 Si la fecha final es nula, la comparacion es siempre correcta
	
  if (horaFinal=='')   return false;
  
  if(tipo=='MAYOR'){
    if(horaInicio>horaFinal){
      return true;
    }
    else{
      return false;
    }
  }
  else{
    if(tipo=='MENOR'){
      if(horaInicio<horaFinal){
        return true;
      }
      else{
        return false;
      }
    }
  }
   
}

function CerrarVentana(){
	  ]]></xsl:text>
	    <xsl:choose>
	      <xsl:when test="/Tarea/VENTANA='NUEVA'">
	        window.close();
	      </xsl:when>
	      <xsl:otherwise>
	        document.location.href='about:blank';
	      </xsl:otherwise>
	    </xsl:choose>
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	}



-->
	</script>
        ]]></xsl:text>
        
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>
          
           
          
<body bgColor="#FFFFFF" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
<xsl:variable name="TipoTarea">
	<xsl:value-of select="/Tarea/TAREA/IDTIPOTAREA"/>
</xsl:variable>		
<form action="TareaSave.xsql" method="POST" name="form1">
  <input type="hidden" name="VENTANA" value="{/Tarea/VENTANA}"/>
	<!-- El tipo ser 'Demandas' de forma predeterminada -->
	<input type="hidden" name="ID">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/ID"/></xsl:attribute>
	</input>
	<input type="hidden" name="IDTIPOTAREA">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/IDTIPOTAREA"/></xsl:attribute>
	</input>
	<input type="hidden" name="IDUSUARIO">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/IDUSUARIO"/></xsl:attribute>
	</input>
	<input type="hidden" name="IDCENTRO">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/IDCENTRO"/></xsl:attribute>
	</input>
	<input type="hidden" name="IDEMPRESA">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/IDEMPRESA"/></xsl:attribute>
	</input>
	<!--	campos ocultos para poder montar las fechas concatenando el dia/mes/año con la hora:minuto		-->
	<input type="hidden" name="FECHANO_INICIO">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/FECHAINICIO"/></xsl:attribute>
	</input>
	<input type="hidden" name="FECHANO_FINAL">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/FECHAFINAL"/></xsl:attribute>
	</input>
	<input type="hidden" name="VACACIONES">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/VACACIONES"/></xsl:attribute>
	</input>
	<input type="hidden" name="FECHANO_INICIOPREVISTA"/>
	<input type="hidden" name="FECHANO_FINALPREVISTA"/>
	<!--	Para las tareas de tipo 'Cita' guardamos como ocultos los campos sobrantes		-->
	<xsl:if test="/Tarea/TAREA/IDTIPOTAREA!='T'">
		<input type="hidden" name="DIAINICIO">
			<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/FECHAINICIO"/></xsl:attribute>
		</input>
		<input type="hidden" name="DIAFINAL">
			<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/FECHAFINAL"/></xsl:attribute>
		</input>
		<input type="hidden" name="IDUSUARIOCONTROL">
			<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/IDUSUARIOCONTROL/field/@current"/></xsl:attribute>
		</input>
		<input type="hidden" name="STATUS">
			<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/STATUS/field/@current"/></xsl:attribute>
		</input>
		<input type="hidden" name="PRIORIDAD">
			<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/PRIORIDAD/field/@current"/></xsl:attribute>
		</input>
	</xsl:if>
	<!--	Para las tareas de tipo 'Cita' fijamos la fecha de hoy		-->
	<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='C'">
		<input type="hidden" name="MOSTRAR" value="on"/>
		<input type="hidden" name="DIAFINALPREVISTO">
			<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/FECHAINICIO"/></xsl:attribute>
		</input>
	</xsl:if>
	
	<!--	Para las tareas de tipo 'Reducida' todavia hay mas campos sobrantes		-->
	<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='R'">
		<!--<input type="hidden" name="IDACTIVIDAD" value=""/>-->
		<!--<input type="hidden" name="DESCRIPCION" value=""/>-->
		<input type="hidden" name="TODOELDIA" value=""/>
		<!--<input type="hidden" name="ACCESO" value="C"/>-->
		<input type="hidden" name="MOSTRAR" value=""/>
		<input type="hidden" name="DIAFINALPREVISTO" value=""/>
		<input type="hidden" name="HORAFINALPREVISTA" value=""/>
	</xsl:if>
  <p class="tituloPag" align="center"><br/>
		<xsl:choose> 
			<xsl:when test="$TipoTarea='C'">				
				Agenda MedicalVM: Cita
			</xsl:when> 
			<xsl:when test="$TipoTarea='T'">				
				Agenda MedicalVM: Tarea
			</xsl:when> 
			<xsl:when test="$TipoTarea='R'">				
				Agenda MedicalVM: Tarea
			</xsl:when> 
		</xsl:choose>
  </p><br/>
  <table border="0" width="95%" align="center">
    <tr class="textoform"> 
      <td class="textoform" height="219" colspan="2"> 
		<table align="center" cellspacing="1" cellpadding="1" border="0" class="oscuro">
		<!--	Separador para opciones de control	-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA!='R'">
		<tr> 
			<td class="blanco" colspan="4" align="center">
				Datos básicos [obligatorios]
			</td>
		</tr>
		</xsl:if>
		<!--	Actividad de la cita/tarea	-->
		<!--<xsl:if test="/Tarea/TAREA/IDTIPOTAREA!='R'">-->
		<tr> 
			<td width="20%" class="claro"> 
			  &nbsp;Tipo de Actividad:<font color="red">*</font>
			</td>
			<td class="blanco" colspan="3"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/IDACTIVIDAD/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
		</tr>
		<!--</xsl:if>-->
		<!--	Titulo de la cita/tarea	-->
		<tr> 
			<td width="20%" class="claro"> 
			  &nbsp;Título:<font color="red">*</font>
			</td>
			<td class="blanco" colspan="3"> 
				<input name="TITULO" size="70" maxlength="300">
				<xsl:attribute name="value">
					<xsl:value-of select="/Tarea/TAREA/TITULO"/>
				</xsl:attribute>
				</input>
			</td>
		</tr>
		<tr> 
			<td width="20%" class="claro"> 
			  &nbsp;Cliente:
			</td>
			<td class="blanco" colspan="3"> 
				<input name="CLIENTE" size="70" maxlength="300">
				<xsl:attribute name="value">
					<xsl:value-of select="/Tarea/TAREA/CLIENTE"/>
				</xsl:attribute>
				</input>
			</td>
		</tr>
		<tr> 
			<td width="20%" class="claro"> 
			  &nbsp;Proveedor:
			</td>
			<td class="blanco" colspan="3"> 
				<input name="PROVEEDOR" size="70" maxlength="300">
				<xsl:attribute name="value">
					<xsl:value-of select="/Tarea/TAREA/PROVEEDOR"/>
				</xsl:attribute>
				</input>
			</td>
		</tr>
		<tr> 
			<td width="20%" class="claro"> 
			  &nbsp;Descripción:
			</td>
			<td class="blanco" colspan="3"> 
				<TEXTAREA COLS="60" ROWS="6" NAME="DESCRIPCION" maxlength="1000" > 
					<xsl:value-of select="/Tarea/TAREA/DESCRIPCION"/>
				</TEXTAREA>
			</td>
		</tr>
		<tr> 
			<td width="20%" class="claro"> 
			  &nbsp;Seguimiento:
			</td>
			<td class="blanco" colspan="3">
				<TEXTAREA COLS="60" ROWS="6" NAME="SEGUIMIENTO" maxlength="1000" >
					<xsl:value-of select="/Tarea/TAREA/SEGUIMIENTO"/>
				</TEXTAREA>
			</td>
		</tr>
		<!--	Fecha Prevista de inicio	-->
		<tr> 
			<td  width="20%" class="claro"> 
			  &nbsp;Fecha Prevista de Inicio:<font color="red">*</font>
			</td>
			<td width="30%" class="blanco"> 
				<input name="DIAINICIOPREVISTO" size="15" maxlength="10">
				<xsl:attribute name="value">
					<xsl:value-of select="/Tarea/TAREA/FECHAINICIOPREVISTA"/>
				</xsl:attribute>
				</input>
			</td>
			<td width="15%" class="claro"> 
			  &nbsp;Hora Inicio:<font color="red">*</font>
			</td>
			<td  width="35%" class="blanco"> 	
			  <xsl:variable name="TodoElDia">
			     <xsl:if test="/Tarea/TAREA/TODOELDIA='S'">
			       disabled
			     </xsl:if>
			  </xsl:variable>	
				<xsl:call-template name="desplegable">
          <xsl:with-param name="path" select="/Tarea/TAREA/HORAINICIOPREVISTA/field"></xsl:with-param>
			    <xsl:with-param name="deshabilitado"><xsl:value-of select="$TodoElDia"/></xsl:with-param>
      	</xsl:call-template>	
			</td>
		</tr>
		<!--	Avisar por email	-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA!='R'">
		<tr> 
			<td class="claro"> 
			  &nbsp;Todo el día:
			</td>
			<td class="blanco" colspan="3"> 
				<input type="checkbox" name="TODOELDIA" onclick="activarDesactivarHoras(this);">
				<xsl:choose>
				<xsl:when test="/Tarea/TAREA/TODOELDIA='S'">
					<xsl:attribute name="checked">checked</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="unchecked">unchecked</xsl:attribute>
				</xsl:otherwise>
				</xsl:choose>
				</input>

				(Marcar si la actividad ocupará todo el día)
			</td>
		</tr>
		</xsl:if>
		<!--	Fecha Prevista de Final	-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA!='R'">
		<tr> 
			<xsl:choose>
			<xsl:when test="/Tarea/TAREA/IDTIPOTAREA='T'">
				<td class="claro"> 
				  &nbsp;Fecha Prevista de Final:<font color="red">*</font>
				</td>
				<td class="blanco"> 
					<input name="DIAFINALPREVISTO" size="15" maxlength="10">
						<xsl:attribute name="value">
							<xsl:value-of select="/Tarea/TAREA/FECHAFINALPREVISTA"/>
						</xsl:attribute>
					</input>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<td class="claro"> 
				  &nbsp;Fecha Prevista de Final:<font color="red">*</font>
				</td>
				<td class="blanco">Mismo día de inicio
				</td>
			</xsl:otherwise>
			</xsl:choose>
			<td class="claro"> 
			  &nbsp;Hora Final:<font color="red">*</font>
			</td>
			<td class="blanco"> 
				<xsl:variable name="TodoElDia">
			    <xsl:if test="/Tarea/TAREA/TODOELDIA='S'">
			      disabled
			    </xsl:if>
			  </xsl:variable>
				<xsl:call-template name="desplegable">
          <xsl:with-param name="path" select="/Tarea/TAREA/HORAFINALPREVISTA/field"></xsl:with-param>
			    <xsl:with-param name="deshabilitado"><xsl:value-of select="$TodoElDia"/></xsl:with-param>
      	</xsl:call-template>				
			</td>
		</tr>
		</xsl:if>
		<!--	Separador para opciones avanzadas	-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='T'">
		<tr> 
			<td class="blanco" colspan="4" align="center">
				Opciones avanzadas [opcionales]
			</td>
		</tr>
		</xsl:if>
		<!--	Mostrar en la agenda	-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='T'">
		<tr> 
			<td class="claro"> 
			  &nbsp;Presentar en agenda:
			</td>
			<td class="blanco" colspan="3"> 
				<input type="checkbox" name="MOSTRAR">
				<xsl:choose>
				<xsl:when test="/Tarea/TAREA/MOSTRAR='S'">
					<xsl:attribute name="checked">checked</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="unchecked">unchecked</xsl:attribute>
				</xsl:otherwise>
				</xsl:choose>
				</input>
				(Marcar si se desea que la Tarea aparezca en la agenda. Si no solo aparecerá en la Lista de Tareas)
			</td>
		</tr>
		</xsl:if>
		<!--<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='T'">
			Usuario que da de alta la tarea:	se utiliza con las tareas, no con las citas	
			=====> Lo cogemos directamente del ID de sesion
		<tr> 
			<td class="claro"> 
			  &nbsp;Usuario:
			</td>
			<td class="blanco" colspan="3"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/IDUSUARIO/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
		</tr>
		</xsl:if>-->
		<!--	Usuario Responsable	-->
		<tr> 
			<td class="claro"> 
			  &nbsp;Usuario Responsable:<font color="red">*</font>
			</td>
			<td class="blanco" colspan="3"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/IDUSUARIORESPONSABLE/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
		</tr>
		<!--	Estado	y prioridad-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='T'">
		<tr> 
			<!--	Estado	-->
			<td class="claro"> 
			  &nbsp;Estado:
			</td>
			<td class="blanco"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/STATUS/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
			<!--	Prioridad	-->
			<td class="claro"> 
			  &nbsp;Prioridad:
			</td>
			<td class="blanco"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/PRIORIDAD/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
		</tr>
		</xsl:if>
		<!--	Acceso	-->
		<tr> 
			<td class="claro"> 
			  &nbsp;Acceso:
			</td>
			<td class="blanco" colspan="3"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/ACCESO/field">
        			</xsl:with-param>
      			</xsl:call-template>&nbsp;Permite establecer que usuarios podrán consultar esta tarea				
			</td>
		</tr>
		<!--	Avisar por email	-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA!='R'">
		<tr> 
			<td class="claro"> 
			  &nbsp;Avisar por email:
			</td>
			<td class="blanco"> 
				<input type="checkbox" name="AVISOEMAIL">
				<xsl:choose>
				<xsl:when test="/Tarea/TAREA/AVISOEMAIL='S'">
					<xsl:attribute name="checked">checked</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="unchecked">unchecked</xsl:attribute>
				</xsl:otherwise>
				</xsl:choose>
				</input>
			</td>
			<td class="claro"> 
			  &nbsp;Antelación en el aviso:
			</td>
			<td class="blanco"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/ANTELACIONALERTA/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
		</tr>
		</xsl:if>
		<!--	Separador para opciones de control	-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='T'">
		<tr> 
			<td class="blanco" colspan="4" align="center">
				Opciones de Control de Tareas [opcionales]
			</td>
		</tr>
		</xsl:if>
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='T'">
		<!--	Usuario Control:	se utiliza con las tareas, no con las citas -->
		<tr> 
			<td class="claro"> 
			  &nbsp;Control:
			</td>
			<td class="blanco" colspan="3"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/IDUSUARIOCONTROL/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
		</tr>
		</xsl:if>
		<!--	Las fechas reales se utilizan con las tareas, no con las citas	-->
		<xsl:if test="/Tarea/TAREA/IDTIPOTAREA='T'">
		<!--	Fecha Real de inicio	-->
		<tr> 
			<td class="claro"> 
			  &nbsp;Fecha real de Inicio:
			</td>
			<td class="blanco"> 
				<input name="DIAINICIO" size="15" maxlength="10">
				<xsl:attribute name="value">
					<xsl:value-of select="/Tarea/TAREA/FECHAINICIO"/>
				</xsl:attribute>
				</input>
			</td>
			<td class="claro"> 
			  &nbsp;Hora:
			</td>
			<td class="blanco"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/HORAINICIO/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
		</tr>
		<!--	Fecha Real de Final	-->
		<tr> 
			<td class="claro"> 
			  &nbsp;Fecha real de Final:
			</td>
			<td class="blanco"> 
				<input name="DIAFINAL" size="15" maxlength="10">
				<xsl:attribute name="value">
					<xsl:value-of select="/Tarea/TAREA/FECHAFINAL"/>
				</xsl:attribute>
				</input>
			</td>
			<td class="claro"> 
			  &nbsp;Hora:
			</td>
			<td class="blanco"> 
				<xsl:call-template name="desplegable">
        			<xsl:with-param name="path" select="/Tarea/TAREA/HORAFINAL/field">
        			</xsl:with-param>
      			</xsl:call-template>				
			</td>
		</tr>
		</xsl:if>
		<tr class="claro">  
			<td align="center" colspan="4">
			  <table width="100%">
          <tr align="center">
            <td>
	            <xsl:call-template name="botonPersonalizado">
	              <xsl:with-param name="funcion">CerrarVentana();</xsl:with-param>
	              <xsl:with-param name="label">Volver</xsl:with-param>
	              <xsl:with-param name="status">Volver</xsl:with-param>
	              <xsl:with-param name="ancho">120px</xsl:with-param>
	              <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	              <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            </xsl:call-template> 
            </td>
            <td>
              <xsl:call-template name="botonPersonalizado">
	              <xsl:with-param name="funcion">enviarFormulario(document.forms[0]);</xsl:with-param>
	              <xsl:with-param name="label">Aceptar</xsl:with-param>
	              <xsl:with-param name="status">Aceptar</xsl:with-param>
	              <xsl:with-param name="ancho">120px</xsl:with-param>
	              <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	              <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            </xsl:call-template> 
            </td>
          </tr>
        </table>
            </td>
          </tr>
        </table>
				
			</td>
		</tr>
  </table>
  </form>
 </body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 </xsl:stylesheet>