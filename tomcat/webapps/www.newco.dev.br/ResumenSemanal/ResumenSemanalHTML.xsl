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
        <title>Resumen Semanal - Edición</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        ]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/divisas.js">
	</script>
	<script type="text/javascript">
        <!--

var msgError='', msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';

var ListaCampos;


function InicializarFormulario(formu){
	
	
//
//
//	Todo el codigo de validacion esta en pruebas!
//
//
		
//    MyForm=form;
		
	ListaCampos = new MVMListaCampos(formu);
	ListaCampos.NuevoCampo( 
							'IDRESUMEN',
							'ID',
							formu.elements['IDRESUMEN'].value, 
							'NoChequear', 
							'', -1,'','','');
	ListaCampos.NuevoCampo(
							'FECHAENVIO',
							'Fecha Prevista de Envío',
							formu.elements['FECHAENVIO'].value,  
							'Fecha', 
							'Requerido', -1,'','','');
	ListaCampos.NuevoCampo(
							'IDESTADO',
							'Estado', 
							obtenerIdDesplegable(formu,'IDESTADO'),
							'Texto', 
							'Requerido',-1,'','','');
	ListaCampos.NuevoCampo(
							'PRODUCTOSBUSCADOS',
							'Productos Buscados',
							formu.elements['PRODUCTOSBUSCADOS'].value,  
							'Texto', 
							'',-1,'','','');
	ListaCampos.NuevoCampo(
							'ARTICULO',
							'Articulo',  
							formu.elements['ARTICULO'].value,
							'Texto', 
							'',-1,'','','');
	ListaCampos.NuevoCampo( 
							'PUBLICIDAD',
							'Publicidad',
							formu.elements['PUBLICIDAD'].value, 
							'Texto', 
							'',-1,'','','');
	ListaCampos.NuevoCampo( 
							'ENVIARAFILIADOS',
							'Enviar a Afiliados', 
							formu.elements['ENVIARAFILIADOS'].value,
							'NoChequear', 
							'Requerido',-1,'','','');
    ListaCampos.NuevoCampo(
							'ENVIARNOAFILIADOS',
							'Enviar a No Afiliados', 
							formu.elements['ENVIARNOAFILIADOS'].value, 
							'NoChequear', 
							'Requerido',-1,'','','');

	//Solo depuracion!
	//ListaCampos.MostrarContenidoCampos(formu);
	
}




//	Prepara el envio del formulario despues de comprobar los campos
function ValidarFormulario(formu)
{
	var msgError='';
	msgError=ListaCampos.ValidarCampos(formu,msgError);
		
	if	(msgError=='')
	{        
  		SubmitForm(formu);
		return true;
	}
   	else
	{
		alert(msgError);
		return false;
	}
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
          
           
          
<body bgColor="#eeffff" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0"
	onLoad="javascript:InicializarFormulario(document.forms[0]);">
<form action="ResumenSemanalSave.xsql" method="POST" name="form1">
  	<input type="hidden" name="IDRESUMEN">
		<xsl:attribute name="value">
		<xsl:value-of  select="Resumen/LEERRESUMEN/MENSAJE/ID"/>
		</xsl:attribute>				
	</input>

  <xsl:apply-templates select="Resumen/jumpTo"/>
  <p class="tituloPag" align="center"><br/>Resumen Semanal - Edición</p><br/>

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
		<!--
          <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Divisa:</div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>&nbsp;
            </td>
            <td width="25%"> 
              <select name="DIVISA"  onChange="CambioDivisa(document.forms[0]);">
          		<xsl:for-each select="Factura/DIVISAS/DIVISAS_ROW">
                <option selected="true">
					<xsl:attribute name="value">
					< ! - -
						 Creamos el ID juntando ID '|' (separador) TipoCambio '|' (separador) Decimales
						ya que necesitaremos este valor para los calculos	
						- - >
						<xsl:value-of select="DIV_ID"/>|<xsl:value-of select="DIV_TIPOCAMBIO"/>|<xsl:value-of select="DIV_DECIMALES"/>
					</xsl:attribute>
					<xsl:value-of select="DIV_NOMBRE"/>
				</option>
          		</xsl:for-each>
              </select>
            </td>
            <td class="textoform" colspan="3" align="left">&nbsp;</td>
		</tr>
		-->
        <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Fecha Prevista Envio:</div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>&nbsp;
            </td>
            <td width="25%"> 
              <div align="left"> 
                <input name="FECHAENVIO" size="25" maxlength="10" obligatorio="si" tipo="fecha">
				<xsl:attribute name="value">
					<xsl:value-of  select="Resumen/LEERRESUMEN/MENSAJE/FECHAENVIO"/>
				</xsl:attribute>				
				</input>
                <div class="textoLegal">(dd/mm/aaaa) </div>
              </div>
            </td>
            <td class="textoform" colspan="3" align="left">&nbsp;</td>
		</tr>
        <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Fecha Real Envio:</div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">&nbsp;</div>&nbsp;
            </td>
            <td width="25%"> 
					<xsl:value-of  select="Resumen/LEERRESUMEN/MENSAJE/FECHAREAL"/>
            </td>
            <td class="textoform" colspan="3" align="left">&nbsp;</td>
		</tr>
          <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Estado:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
            	<xsl:variable name="IDAct" select="Resumen/LEERRESUMEN/MENSAJE/IDESTADO"/>
   		    	<xsl:apply-templates select="Resumen/LEERRESUMEN/ESTADOS/field"/>
            </td>
            <td class="textoform" colspan="3" align="left">&nbsp;</td>
          </tr>
         <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Productos Buscados:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%" colspan="4" align="left"> 
				<textarea  maxlength="2000" rows="10" cols="50" name="PRODUCTOSBUSCADOS">
					<xsl:value-of  select="Resumen/LEERRESUMEN/MENSAJE/PRODUCTOSBUSCADOS"/>
				</textarea>
            </td>
          </tr>    
         <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Articulo:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%" colspan="4" align="left"> 
				<textarea  maxlength="2000" rows="10" cols="50" name="ARTICULO">
					<xsl:value-of  select="Resumen/LEERRESUMEN/MENSAJE/NOTICIA"/>
				</textarea>
            </td>
          </tr>    
          <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Publicidad:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%" colspan="4" align="left"> 
				<textarea  maxlength="2000" rows="10" cols="50" name="PUBLICIDAD">
					<xsl:value-of  select="Resumen/LEERRESUMEN/MENSAJE/PUBLICIDAD"/>
				</textarea>
            </td>
          </tr>
          <tr> 
		  	<td align="center" colspan="6">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%"> 
              <div align="right">
                <input type="checkbox" name="ENVIARAFILIADOS" value="S">
				<xsl:variable name="Activado">
					<xsl:value-of select="Resumen/LEERRESUMEN/MENSAJE/ENVIARAFILIADOS"/>
				</xsl:variable>		
				<xsl:choose> 
					<xsl:when test="$Activado=1">				
						<xsl:attribute name="CHECKED" value="CHECKED"/>
					</xsl:when> 
					<xsl:otherwise>
						<xsl:attribute name="UNCHECKED" value="UNCHECKED"/>
					</xsl:otherwise> 
				</xsl:choose>
				</input>
				</div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <!--<div align="center">*</div>-->&nbsp;
            </td>
            <td> 
              Enviar a los afiliados de MedicalVM
            </td>
            <td class="textoform" width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios">&nbsp;</td>
            <td width="*" class="textoform">&nbsp;</td>
          </tr>
          <tr> 
            <td width="25%"> 
              <div align="right">
                <input type="checkbox" name="ENVIARNOAFILIADOS" value="S">
				<xsl:variable name="Activado">
					<xsl:value-of select="Resumen/LEERRESUMEN/MENSAJE/ENVIARNOAFILIADOS"/>
				</xsl:variable>		
				<xsl:choose> 
					<xsl:when test="$Activado=1">				
						<xsl:attribute name="CHECKED" value="CHECKED"/>
					</xsl:when> 
					<xsl:otherwise>
						<xsl:attribute name="UNCHECKED" value="UNCHECKED"/>
					</xsl:otherwise> 
				</xsl:choose>
				</input>
              </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <!--<div align="center">*</div>-->&nbsp;
            </td>
            <td> 
              Enviar a los No Afiliados de MedicalVM
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
        <input  type="button" name="SUBMIT" value="Aceptar"
			onClick="ValidarFormulario(document.forms[0]);" />
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