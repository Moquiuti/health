<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Nuevo proceso interno de la Central de Compras
 |
 |	(c) 9/10/2002 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  	<xsl:param name="lang" select="@lang"/>  
  	<xsl:template match="/">
    <html>
      <head>
        <!-- 
	<title><xsl:value-of select="document('messages.xml')/messages/msg[@id='USD-1010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	-->
	<title>Nuevo proceso Central de Compras</title>
	<xsl:text disable-output-escaping="yes">
	<![CDATA[	
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
	
	//	Presenta la pagina con el listado correspondiente a la seleccion del usuario
	
	function MostrarListado(Indicador, Grupo, Mes)
	{
		var Enlace;
		var form=document.forms[0];
		
		Enlace='http://www.newco.dev.br/Gestion/EIS/EISListado.xsql?'
				+'US_ID='+form.elements['OR_US_ID'].value
				+'&'+'IDINDICADOR='+Indicador
				+'&'+'ANNO='+form.elements['OR_ANNO'].value
				+'&'+'MES='+Mes
				+'&'+'IDEMPRESA='+form.elements['OR_IDEMPRESA'].value
				+'&'+'IDCENTRO='+form.elements['OR_IDCENTRO'].value
				+'&'+'IDUSUARIO='+form.elements['OR_IDUSUARIOSEL'].value
				+'&'+'IDEMPRESA2='+form.elements['OR_IDEMPRESA2'].value
				+'&'+'IDPRODUCTO='+form.elements['OR_IDPRODUCTO'].value
				+'&'+'IDESTADO='+form.elements['OR_IDESTADO'].value
				+'&'+'REFERENCIA='+form.elements['OR_REFERENCIA'].value
				//+'&'+'IDNOMENCLATOR='+
				//+'&'+'URGENCIA='+
				+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
				+'&'+'IDGRUPO='+Grupo;
				
		//alert (Enlace);
				
		MostrarPag(Enlace, 'Listado');
		
		
		
	}
	
	function Guardar(accion)
	{
		var form=document.forms[0];
          	  
		form.elements['STATUS'].value=accion;
          
		  alert('valor='+form.elements['STATUS'].value+'\n\r'
		  		+'titulo='+form.elements['TITULO'].value+'\n\r'
				+'texto='+form.elements['TEXTO'].value+'\n\r');
		SubmitForm(form);
    }
	
	//-->
	</script>
	<!--
	<script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/eis.js">
	</script>
	-->
	]]>
	</xsl:text>	
      </head>
      <body bgcolor="#FFFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">  
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
	-->
	<xsl:when test="//SESION_CADUCADA">
          <xsl:apply-templates select="//SESION_CADUCADA"/> 
        </xsl:when>
        <xsl:when test="EIS_XML/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="EIS_XML/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
	  	<form method="post" action="TareaSave.xsql"><!--?xml-stylesheet=none-->
		<input type="hidden" name="ID">
		<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/ID"/></xsl:attribute>
		</input>
		<input type="hidden" name="STATUS">
		<xsl:attribute name="value"></xsl:attribute>
		</input>
        <table width="80%" class="muyoscuro" border="0" align="center" cellspacing="1" cellpadding="1" >
		<tr class="oscuro">
		<td align="center" colspan="7">
			<font color="#0"><b>......:::::: <xsl:value-of select="/Tarea/TAREA/TIPO"/> ::::::......</b></font>
		</td></tr>
		<tr class="blanco"><td align="center" colspan="7">&nbsp;</td></tr>
	    <tr class="blanco">
			<td class="claro" align="right" width="15%">
				De:
			</td>
			<td>
				<xsl:value-of select="/Tarea/TAREA/USUARIO"/>
			</td>
		</tr>
		<tr class="blanco">
			<td class="claro" align="right">
				Para:
			</td>
			<td>
				&nbsp;
			</td>
		</tr>
		<tr class="blanco">
			<td class="claro" align="right">
				Titulo:
			</td>
			<td>
			    <input type="text" name="TITULO" maxlength="100" size="60">
				<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/TITULO"/></xsl:attribute>
				</input>
			</td>
		</tr>
		<tr class="blanco">
			<td class="claro" align="right">
				Texto:
			</td>
			<td>
			    <textarea type="text" name="TEXTO" cols="60" rows="20">
				<xsl:attribute name="value"><xsl:value-of select="/Tarea/TAREA/TEXTO"/></xsl:attribute>
				</textarea>
			</td>
		</tr>
		<tr class="blanco">
			<td class="claro" align="right">
				Anexos:
			</td>
			<td>
			    &nbsp;
			</td>
		</tr>
		<tr class="blanco">
			<td class="claro" colspan="2">
			<table width="100%" align="center">
				<tr class="blanco" align="center">
				<td>
				<xsl:call-template name="boton">
				  <xsl:with-param name="path" select="//Tarea/button[@label='Enviar']"/>
				</xsl:call-template>
				</td>
				<td>
				<xsl:call-template name="boton">
				  <xsl:with-param name="path" select="//Tarea/button[@label='Pendiente']"/>
				</xsl:call-template>
				</td>
				<td>
				<xsl:call-template name="boton">
				  <xsl:with-param name="path" select="//Tarea/button[@label='Cancelar']"/>
				</xsl:call-template>
				</td>
				</tr>
			</table>
			</td>
		</tr>
		</table>
		</form>
	
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
