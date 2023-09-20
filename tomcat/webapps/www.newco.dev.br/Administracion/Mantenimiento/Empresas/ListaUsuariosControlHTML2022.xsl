<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Usuarios en control de accesos. Nuevo disenno 2022.
	ultima revision: ET 17may22 11:38
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>  
<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
<head>
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/ListadoUsuarios/LANG"><xsl:value-of select="/ListadoUsuarios/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      <!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios_control_accesos']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
    <!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
    
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	<!--
	//	Funciones de Javascript
	function CambiarEmpresa(idEmpresa)
	{
	  var objFrame=new Object();
	  objFrame=obtenerFrame(top, 'zonaEmpresa');
	  objFrame.CambioEmpresaActual(idEmpresa);
	}

	function CambiarCentro(idEmpresa, idCentro)
	{
	  var objFrame=new Object();
	  objFrame=obtenerFrame(top, 'zonaEmpresa');
	  objFrame.CambioCentroActual(idEmpresa, idCentro);
	}
	
	function EditarUsuario(idEmpresa,idUsuario)
	{
	 document.location.href='./USManten.xsql?ID_USUARIO='+idUsuario+'&EMP_ID='+idEmpresa;
	}
		-->
	</script>
    ]]></xsl:text>
		
</head>
<body>
    <!--idioma-->
    <xsl:variable name="lang">
    <xsl:choose>
        <xsl:when test="/ListadoUsuarios/LANG"><xsl:value-of select="/ListadoUsuarios/LANG" /></xsl:when>
        <xsl:otherwise>spanish</xsl:otherwise>
        </xsl:choose>  
    </xsl:variable>
    <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->

	<form method="post" action="CorreosUsuarios_2.xsql">    
	<input type="hidden" name="LISTAEMPRESAS" value=""/>

	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
			<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarios_control_accesos']/node()"/>
			<span class="CompletarTitulo">
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<div class="tabela tabela_redonda">
	<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1x"></th>
	      	<th class="treinta"><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/></th>
	      	<th class="treinta"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/></th>
	      	<th><xsl:value-of select="document($doc)/translation/texts/item[@name='usuario']/node()"/></th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
		<xsl:for-each select="/ListadoUsuarios/USUARIOS/USUARIO">
		<tr>
			<td class="color_status">&nbsp;</td>
    		<td class="textLeft">&nbsp;&nbsp;<a href="javascript:CambiarEmpresa({IDEMPRESA});"><xsl:value-of select="EMPRESA"/></a></td>
    		<td class="textLeft">&nbsp;&nbsp;<a href="javascript:CambiarCentro({IDEMPRESA},{IDCENTRO});"><xsl:value-of select="CENTRO"/></a></td>
    		<td class="textLeft">&nbsp;&nbsp;<a href="javascript:EditarUsuario({IDEMPRESA},{IDUSUARIO});"><xsl:value-of select="USUARIO"/></a></td>
		</tr>
		</xsl:for-each>	   
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="4">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	</div>
 	<br/>  
 	<br/>  
	</form>
</body>
</html>
</xsl:template>  
  
  

</xsl:stylesheet>
