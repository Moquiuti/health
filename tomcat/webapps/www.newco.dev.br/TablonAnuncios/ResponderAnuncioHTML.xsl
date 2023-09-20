<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 |	Responder a un anuncio para el Tablón de Anuncios de MedicalVM
 |	
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/TablonAnuncios/FichaAnuncio.xsl" />
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Responder a un anuncio o pregunta</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
        <!--

var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';



function validarFormulario(form)
{
	var	listacampos='';
	var error='';
	
	for(var n=0;n<form.length;n++)
	{
		switch (form.elements[n].name)
		{
			case 'Titulo':
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Titulo\''+'\n';
					}
					break;  

			case 'Usuario':
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Nombre\''+'\n';
					}
					break;  

			case 'Empresa':
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Empresa\''+'\n';
					}
					break;  

			case 'Email':
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Email\''+'\n';
					}
					break;  

			case 'Explicacion':
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Comentarios\''+'\n';
					}
					break;  

			case 'Provincia':
					if(form.elements[n].value=='')
					{
						listacampos=listacampos+'\'Provincia\''+'\n';
					}
					break;  

			case 'FechaSalida':// Fecha -> Opcional
				   if(form.elements[n].value!='')
					{
						if (test2(form.elements[n])!='')
						{
				   			error='La fecha introducida no está en un formato correcto (dd/mm/yyyy).'+'\n';
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



/*function validarFormulario(form){

 
  for(var n=0;n<form.length;n++){
      switch (n){
	  
	case 1:// Explicacion
		   var error='El campo \'Texto\' esta vacío pero es obligatorio.';
		  if(validarNoNulo(form.elements[n])==false){
			msgError=error+msgErrorStd;
			return false;
		  }
		  break;
		  	  
		}//switch
  }//for  
  return true;
}
*/
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
	<xsl:variable name="TipoAnuncio">
		<xsl:value-of select="ResponderAnuncio/ANUNCIO/TIPO"/>
	</xsl:variable>		
		<br/>
		<p class="tituloPag" align="center">
		<xsl:choose> 
			<xsl:when test="$TipoAnuncio=0">				
				Tablón de Anuncios - Responder
			</xsl:when> 
			<xsl:when test="$TipoAnuncio=1">				
				Ventas de Stocks - Responder
			</xsl:when> 
			<xsl:when test="$TipoAnuncio=3">				
				Foro Público para Compradores - Responder
			</xsl:when> 
			<xsl:when test="$TipoAnuncio=4">				
				Foro Privado - Responder
			</xsl:when> 
			<xsl:otherwise>
				Tablón de Anuncios - Responder
			</xsl:otherwise> 
		</xsl:choose>
		</p>	
		<p align="center">
		<xsl:choose> 
			<xsl:when test="$TipoAnuncio=0">				
		Utilice este formulario para responder a un anuncio.<br/>
		MedicalVM le recomienda introducir sus referencias de productos para facilitar la labor del
		comprador.<br/>
		Introduzca el texto de la respuesta en el campo correspondiente y pulse "Aceptar"<br/><br/>
			</xsl:when> 
			<xsl:when test="$TipoAnuncio=1">				
		Utilice este formulario para responder a un anuncio.<br/>
		Introduzca el texto de la respuesta en el campo correspondiente y pulse "Aceptar"<br/><br/>
			</xsl:when> 
			<xsl:when test="$TipoAnuncio=3">				
		Utilice este formulario para responder a una pregunta en el Foro Público de Compradores.<br/>
		Introduzca el texto de la respuesta en el campo correspondiente y pulse "Aceptar"<br/><br/>
			</xsl:when> 
			<xsl:when test="$TipoAnuncio=4">				
		Utilice este formulario para responder a una pregunta en el Foro Privado de su empresa.<br/>
		Introduzca el texto de la respuesta en el campo correspondiente y pulse "Aceptar"<br/><br/>
			</xsl:when> 
			<xsl:otherwise>
				Tablón de Anuncios - Responder
			</xsl:otherwise> 
		</xsl:choose>
		</p>
		
		
        <xsl:apply-templates select="ResponderAnuncio/ANUNCIO"/>

		<br/>

<form action="ResponderAnuncioSave.xsql" method="POST" name="form1">
	<!-- Almacena el identificador del anuncio -->
  <input type="hidden" name="IDAnuncio">
  	<xsl:attribute name="value">
		<xsl:value-of select="ResponderAnuncio/ANUNCIO/ID"/>
  	</xsl:attribute>
  </input>

	<table align="center" cellspacing="1" cellpadding="3" width="75%" class="oscuro">
	<tr class="oscuro">
		<td align="center" colspan="2">
		.........::::::: Escriba su Respuesta al Anuncio :::::::.........
		</td>
	</tr>
	<xsl:choose>
	<xsl:when test="ResponderAnuncio/ANUNCIO/IDUSUARIO='NOCONECTADO'">
	<tr> 
		<td align="left" class="claro"> 
			Nombre:<font color="red">*</font>
		</td>
		<td align="left" class="blanco"> 
			<input size="30" maxlength="100" name="Usuario"/>
		</td>
	</tr>  
	<tr> 
		<td align="left" class="claro"> 
			Empresa:<font color="red">*</font>
		</td>
		<td align="left" class="blanco"> 
			<input size="30" maxlength="100"  name="Empresa"/>
		</td>
	</tr>  
	<tr> 
		<td align="left" class="claro"> 
			Provincia:<font color="red">*</font>
		</td>
		<td align="left" class="blanco"> 
			<input size="30" maxlength="100"  name="Provincia"/>
		</td>
	</tr>  
	<tr> 
		<td align="left" class="claro"> 
			Email:<font color="red">*</font>
		</td>
		<td align="left" class="blanco"> 
			<input size="30" maxlength="100"  name="Email"/>
		</td>
	</tr>  
    <tr> 
		<td align="left" class="claro"> 
			Otros datos de Contacto:
		</td>
        <td align="left" class="blanco"> 
			<textarea size="3000" rows="5" cols="50" name="Contacto"/>
        </td>
    </tr>  
	</xsl:when>
	<xsl:otherwise>
		<input type="hidden" name="Usuario" value="Conectado"/>
	</xsl:otherwise>
	</xsl:choose>
	<tr> 
		<td align="left" class="claro"> 
			Comentarios:<font color="red">*</font>
		</td>
		<td align="left" class="blanco"> 
			<textarea size="3000" rows="5" cols="60" name="Explicacion"/>
		</td>
	</tr>  
	<tr>  
      <td align="center" class="claro" colspan="2">
        <table width="100%">
          <tr align="center">
            <td>
	            <xsl:call-template name="botonPersonalizado">
	              <xsl:with-param name="funcion">history.go(-1);</xsl:with-param>
	              <xsl:with-param name="label">Volver</xsl:with-param>
	              <xsl:with-param name="status">Volver</xsl:with-param>
	              <xsl:with-param name="ancho">120px</xsl:with-param>
	              <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	              <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            </xsl:call-template> 
            </td>
            <td>
              <xsl:call-template name="botonPersonalizado">
	              <xsl:with-param name="funcion">if(validarFormulario(document.forms[0])==true)SubmitForm(document.forms[0]); else alert(msgError);</xsl:with-param>
	              <xsl:with-param name="label">Aceptar</xsl:with-param>
	              <xsl:with-param name="status">Aceptar</xsl:with-param>
	              <xsl:with-param name="ancho">120px</xsl:with-param>
	              <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	              <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            </xsl:call-template> 
              <!--<input  type="button" name="SUBMIT" value="Aceptar" onClick="if(validarFormulario(document.forms[0])==true)SubmitForm(document.forms[0]); else alert(msgError)" />-->
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