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
       <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Noticia/LANG"><xsl:value-of select="/Noticia/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
        
        <title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_noticias']/node()"/></title>
		
        <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>


	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript">
        <!--

var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';

function validarFormulario(form){

 var text='';
 
  for(var n=0;n<form.length;n++){
  		var element=form.elements[n];
	  text=text+form.elements[n].name+' = ' +form.elements[n].value +" Prop:";
	  for (property in element)
			text+=property+':'+element[property]+' - ';
	  text=text+'\n';
  }//for  
  
  alert (text);
  
  return true;
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
          
           
          
<body bgColor="#eeffff" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
<form action="NoticiaSave.xsql" method="POST" name="form1">
  	<input type="hidden" name="ID">
		<xsl:attribute name="value">
		<xsl:value-of  select="Noticia/LEERNOTICIA/NOTICIA/ID"/>
		</xsl:attribute>				
	</input>
	
     <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Noticia/LANG"><xsl:value-of select="/Noticia/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->
        
  <p class="tituloPag" align="center"><br/>Noticias - Consejos - Preguntas Frecuentes - Publicidad</p><br/>

  <table border="0" width="100%">
    <tr> 
      <td colspan="2"> 
        <table width="75%" align="center">
          <tr> 
            <td class="textoLegal">
			<p  align="center">
		Página para el uso exclusivo por parte de administradores de MedicalVM<br/>
		Si usted dispone de acceso a esta página sin ser administrador, por favor, informe
		a su comercial de MedicalVM.<br/><br/>
			</p></td>
          </tr>
        </table>
      </td>
    </tr>
	
    <tr> 
      <td>&nbsp;</td>
    </tr>
    <tr class="textoform"> 
      <td class="textoform" height="219" colspan="2"> 
        <table border="0" width="100%">
          <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Pública:</div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <!--<div align="center">*</div>-->&nbsp;
            </td>
            <td width="25%"> 
              <div align="left"> 
                <input type="checkbox" name="PUBLICA">
				<xsl:variable name="Chequear">
					<xsl:value-of select="Noticia/LEERNOTICIA/NOTICIA/PUBLICA"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$Chequear=1">
						<xsl:attribute name="CHECKED"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="UNCHECKED"/>
					</xsl:otherwise>
				</xsl:choose>
                </input> (ver desde la parte pública de MedicalVM)
              </div>
            </td>
            <td class="textoform" colspan="3" align="left">&nbsp;</td>
          </tr>
          <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Fecha Anuncio:</div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>&nbsp;
            </td>
            <td width="25%"> 
              <div align="left"> 
                <input name="FECHANOENTRADA" size="25" maxlength="10" obligatorio="si" tipo="fecha">
				<xsl:attribute name="value">
					<xsl:value-of  select="Noticia/LEERNOTICIA/NOTICIA/FECHAENTRADA"/>
				</xsl:attribute>				
				</input>
                <div class="textoLegal">(dd/mm/aaaa) </div>
              </div>
            </td>
            <td width="15%"> 
              <div align="right" class="textoform">Fecha Caducidad:</div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <!--<div align="center">*</div>-->&nbsp;
            </td>
            <td width="25%"> 
              <div align="left"> 
                <input name="FECHANOSALIDA" size="25" maxlength="10">
				<xsl:attribute name="value">
					<xsl:value-of  select="Noticia/LEERNOTICIA/NOTICIA/FECHASALIDA"/>
				</xsl:attribute>				
				</input>
                <div class="textoLegal">(dd/mm/aaaa) </div>
              </div>
            </td>
          </tr>
          <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Tipo:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
            	<xsl:variable name="IDAct" select="Noticia/LEERNOTICIA/NOTICIA/IDTIPO"/>
   		    	<xsl:apply-templates select="Noticia/LEERNOTICIA/TIPO/field"/>
   <!--
              <select name="Tipo">
          		<xsl:for-each select="Noticia/LEERNOTICIA/TIPO">
                <option selected="true">
					<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
					<xsl:value-of select="NOMBRE"/>
				</option>
				</xsl:for-each>
              </select>-->
            </td>
            <td class="textoform" width="15%"> 
              <div align="right">Grupo:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
            	<xsl:variable name="IDAct" select="Noticia/LEERNOTICIA/NOTICIA/IDGRUPO"/>
   		    	<xsl:apply-templates select="Noticia/LEERNOTICIA/GRUPO/field"/>
   <!--
              <select name="Grupo">
          		<xsl:for-each select="Noticia/LEERNOTICIA/GRUPO">
                <option selected="true">
					<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
					<xsl:value-of select="NOMBRE"/>
				</option>
				</xsl:for-each>
              </select>-->
            </td>
          </tr>
          <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Título:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%" colspan="4" align="left"> 
                <input name="TITULO" size="50" maxlength="100">
				<xsl:attribute name="value">
					<xsl:value-of  select="Noticia/LEERNOTICIA/NOTICIA/TITULO"/>
				</xsl:attribute>				
				</input>
            </td>
          </tr>
          <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Noticia:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%" colspan="4" align="left"> 
				<textarea  maxlength="2000" rows="10" cols="50" name="RESPUESTA">
					<xsl:value-of  select="Noticia/LEERNOTICIA/NOTICIA/RESPUESTA"/>
				</textarea>
            </td>
          </tr>    
          <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Opción del menú:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%" colspan="4" align="left"> 
            	<xsl:variable name="IDAct" select="Noticia/LEERNOTICIA/NOTICIA/IDMENU"/>
   		    	<xsl:apply-templates select="Noticia/LEERNOTICIA/MENU/field"/>
   <!--
              <select name="Menu">
          		<xsl:for-each select="Noticia/LEERNOTICIA/MENU">
				<choose>
					<when test="">
                		<option selected="true">
					</when>
					<otherwise>
                		<option>
					</otherwise>
				</choose>
					<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
					<xsl:value-of select="NOMBRE"/>
				</option>
				</xsl:for-each>
              </select>-->
            </td>
			<!--
            <td width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios">&nbsp;</td>
            <td colspan="2" width="*">&nbsp;</td>
			-->
          </tr>
          <tr> 
		  	<td align="center" colspan="6">&nbsp;</td>
          </tr>
          <tr> 
		  	<td align="center" colspan="6">La opción de envío automático de e-mails todavía
			no está activa
			</td>
          </tr>
          <tr> 
            <td width="25%"> 
              <div align="right"> 
                <input type="checkbox" name="ENVIARCLINICAS"/>
              </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <!--<div align="center">*</div>-->&nbsp;
            </td>
            <td width="15%"> 
              <div align="left" class="textoform">Enviar a Clínicas, Hospitales y Laboratorios</div>
            </td>
            <td class="textoform" width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios">&nbsp;</td>
            <td width="*" class="textoform">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%"> 
              <div align="right"> 
                <input type="checkbox" name="ENVIARCONSULTAS"/>
              </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <!--<div align="center">*</div>-->&nbsp;
            </td>
            <td width="15%"> 
              <div align="left" class="textoform">Enviar a Consultas</div>
            </td>
            <td class="textoform" width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios">&nbsp;</td>
            <td width="*" class="textoform">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%"> 
              <div align="right"> 
                <input type="checkbox" name="ENVIARPROVEEDORES"/>
              </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <!--<div align="center">*</div>-->&nbsp;
            </td>
            <td width="15%"> 
              <div align="left" class="textoform">Enviar a Proveedores</div>
            </td>
            <td class="textoform" width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios">&nbsp;</td>
            <td width="*" class="textoform">&nbsp;</td>
          </tr>
		</table>
	  </td>
	</tr>
	<tr>  
      <td width="15%" align="center">
        <input  type="button" name="SUBMIT" value="Aceptar" onClick="if(validarFormulario(document.forms[0])==true)SubmitForm(document.forms[0]); else alert(msgError)" />
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