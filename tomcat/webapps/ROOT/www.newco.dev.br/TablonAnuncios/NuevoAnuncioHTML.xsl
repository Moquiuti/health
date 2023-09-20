<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 |
 |	
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Anuncios y foros de MedicalVM</title>

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
						listacampos=listacampos+'\'Descripción\''+'\n';
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
        
        <STYLE>.tituloPagForm {
	COLOR: #015e4b; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; FONT-SIZE: 14pt; FONT-WEIGHT: bold
}
.tituloForm {
	COLOR: #015e4b; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.subTituloForm {
	COLOR: #018167; FONT-SIZE: 9pt; FONT-WEIGHT: bold
}
.textoForm {
	COLOR: #000000; FONT-SIZE: 10pt; FONT-WEIGHT: bold
}
.textoLegal {
	COLOR: #000000; FONT-SIZE: 8pt
}
.camposObligatorios { COLOR: #FF0000; FONT-SIZE: 10pt; FONT-WEIGHT: bold }
</STYLE>
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
	<xsl:value-of select="/NuevoAnuncio/TIPO"/>
</xsl:variable>		
<form action="NuevoAnuncioSave.xsql" method="POST" name="form1">
	<!-- El tipo ser 'Demandas' de forma predeterminada -->
  <input type="hidden" name="Tipo">
  	<xsl:attribute name="value">
  		<xsl:value-of select="/NuevoAnuncio/TIPO"/>
  	</xsl:attribute>
  </input>
  <p class="tituloPag" align="center"><br/>
		<xsl:choose> 
			<xsl:when test="$TipoAnuncio=0">				
				Tablón de Anuncios - Nueva demanda
			</xsl:when> 
			<xsl:when test="$TipoAnuncio=1">				
				Ventas de Stocks - Nueva oferta
			</xsl:when> 
			<xsl:when test="$TipoAnuncio=3">				
				Foro Público para Compradores - Nueva pregunta
			</xsl:when> 
			<xsl:otherwise>
				Tablón de Anuncios - Varios
			</xsl:otherwise> 
		</xsl:choose>
  </p><br/>
  <table border="0" width="95%" align="center">
    <tr> 
      <td colspan="2"> 
        <table width="75%" align="center">
          <tr> 
            <td class="textoLegal">
			<p  align="center">
			<xsl:choose> 
				<xsl:when test="$TipoAnuncio=3">				
			Este formulario le permitirá publicar una pregunta en el Foro Público de Compradores
			de MedicalVM que podrá ser consultado únicamente por los compradores de Hospitales,
			Clínicas y Centros Socio-Sanitarios.
			Es recomendable utilizar un título breve y aprovechar el campo "Texto" para
			desarrollar el tema tanto como sea necesario (el límite son 2.000 caracteres)
				</xsl:when> 
				<xsl:when test="$TipoAnuncio=4">				
			Este formulario le permitirá publicar una pregunta en el Foro Privado
			de MedicalVM que podrá ser consultado únicamente por los usuarios de su empresa.
			Es recomendable utilizar un título breve y aprovechar el campo "Texto" para
			desarrollar el tema tanto como sea necesario (el límite son 2.000 caracteres)
				</xsl:when> 
				<xsl:when test="$TipoAnuncio=1">				
			Este formulario le permitirá publicar un anuncio en el Tablón
			de Ventas de Stocks de MedicalVM que podrá ser consultado por los Centros Sanitarios.
			Es recomendable utilizar un título breve y aprovechar el campo "Texto" para
			presentar los productos y sus referencias (el límite son 2.000 caracteres)
				</xsl:when> 
				<xsl:otherwise>
			Este formulario le permitirá publicar un anuncio en el Tablón
			de anuncios de MedicalVM que podrá ser consultado por los Proveedores.
			Es recomendable utilizar un título breve y aprovechar el campo "Texto" para
			desarrollar la pregunta tanto como sea necesario (el límite son 2.000 caracteres)
				</xsl:otherwise> 
			</xsl:choose>
			</p><br/></td>
          </tr>
        </table>
      </td>
    </tr>
	
    <tr> 
      <td>&nbsp;</td>
    </tr>
    <tr class="textoform"> 
      <td class="textoform" height="219" colspan="2"> 
		<table align="center" cellspacing="1" cellpadding="1" border="0" class="oscuro">
		<!--	Datos de Contacto: Solo para empresas no afiliadas a MedicalVM	-->
		<xsl:choose>
		<xsl:when test="NuevoAnuncio/IDUSUARIO/IDUSUARIO='NOCONECTADO'">
		<tr> 
			<td align="left" class="claro"> 
				&nbsp;Nombre:<font color="red">*</font>
			</td>
			<td align="left" class="blanco"> 
				<input size="30" maxlength="100" name="Usuario"/>
			</td>
		</tr>  
		<tr> 
			<td align="left" class="claro"> 
				&nbsp;Empresa:<font color="red">*</font>
			</td>
			<td align="left" class="blanco"> 
				<input size="30" maxlength="100"  name="Empresa"/>
			</td>
		</tr>  
          <tr> 
            <td width="30%" class="claro"> 
              &nbsp;Provincia:<font color="red">*</font>
            </td>
            <td  width="70%" class="blanco"> 
				<input size="30" maxlength="100" name="Provincia"/>
            </td>
          </tr>
          <tr> 
            <td width="30%" class="claro"> 
              &nbsp;Email:<font color="red">*</font>
            </td>
            <td  width="70%" class="blanco"> 
				<input size="30" maxlength="100" name="Email"/>
            </td>
          </tr>
          <tr> 
            <td width="30%" class="claro"> 
              &nbsp;Otros datos de Contacto:
            </td>
            <td  width="70%" class="blanco"> 
				<textarea  maxlength="2000" rows="5" cols="50" name="Contacto"/>
            </td>
          </tr>
		</xsl:when>
		<xsl:otherwise>
			<input type="hidden" name="Usuario" value="Conectado"/>
		</xsl:otherwise>
		</xsl:choose>
		<!--	Titulo	-->
          <tr> 
            <td width="30%" class="claro"> 
              &nbsp;Título:<font color="red">*</font>
            </td>
            <td  width="70%" class="blanco"> 
              <input name="Titulo" size="50" maxlength="100"/>
            </td>
          </tr>
		<!--	Categoria	-->
          <tr> 
            <td width="30%" class="claro"> 
              &nbsp;Categoría:<font color="red">*</font>
            </td>
            <td  width="70%" class="blanco"> 
              <select name="Categoria">
          		<xsl:for-each select="NuevoAnuncio/Categorias/ROW">
                <option selected="true">
					<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
					<xsl:value-of select="listItem"/>
				</option>
          		</xsl:for-each>
              </select>
            </td>
          </tr>
		<!--	Caducidad	-->
          <tr> 
            <td width="30%" class="claro"> 
              &nbsp;Fecha Caducidad:
            </td>
            <td  width="70%" class="blanco"> 
              <div align="left"> 
                <input name="FechaSalida" size="25" maxlength="10"/>
                <div class="textoLegal">(dd/mm/aaaa) </div>
              </div>
            </td>
          </tr>
		<!--	Descripción	-->
          <tr> 
            <td width="30%" class="claro"> 
              &nbsp;Descripción:<font color="red">*</font>
            </td>
            <td  width="70%" class="blanco"> 
				<textarea  maxlength="2000" rows="6" cols="50" name="Explicacion"/>
            </td>
          </tr>
		<tr class="claro">  
			<td align="center" colspan="2">
			  <table width="100%">
          <tr align="center">
            <td>
	            <xsl:call-template name="botonPersonalizado">
	              <xsl:with-param name="funcion">window.close();</xsl:with-param>
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
  </td></tr>
  </table>
  </form>
 </body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 </xsl:stylesheet>