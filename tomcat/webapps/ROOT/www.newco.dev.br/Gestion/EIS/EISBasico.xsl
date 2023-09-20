<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Presentacion de datos estadisticos de utilizacion de la plataforma MedicalVM
 |
 |	(c) 12/1/2001 ET
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
        	<xsl:value-of select="/EIS_XML/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='sistema_info_direccion']/node()"/>&nbsp;(
	<xsl:value-of select="document($doc)/translation/texts/item[@name='eis']/node()"/>)</title>

    
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
      
     <link rel="stylesheet" href="http://www.newco.dev.br/General/estiloEISPrint.css" type="text/css" media="print" />	
     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	<xsl:text disable-output-escaping="yes">
	<![CDATA[	
	
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
				+'&'+'CODIGO='+form.elements['OR_CODIGO'].value
				//+'&'+'IDNOMENCLATOR='+
				//+'&'+'URGENCIA='+
				+'&'+'AGRUPARPOR='+form.elements['OR_AGRUPARPOR'].value
				+'&'+'IDGRUPO='+Grupo;
				
		//alert (Enlace);
				
		MostrarPag(Enlace, 'Listado');
	}
	-->
	</script>
	
	]]>
	</xsl:text>	
      </head>
      <body>  
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
	    <!-- Titulo -->

	  	<form method="post" action="EISDatos.xsql"><!--?xml-stylesheet=none-->
       	<input type="hidden" name="Indicadores" value=""/>
		<!--	Guardamos los valores originales en campos ocultos		-->
       	<input type="hidden" name="OR_US_ID">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/US_ID"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDCUADRO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCUADRO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_ANNO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/ANNO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDEMPRESA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDEMPRESA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDCENTRO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDCENTRO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDUSUARIOSEL">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDUSUARIOSEL"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDEMPRESA2">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDEMPRESA2"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDPRODUCTO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDPRODUCTO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDESTADO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDESTADO"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDNOMENCLATOR">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDNOMENCLATOR"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_URGENCIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/URGENCIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_REFERENCIA">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/REFERENCIA"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_CODIGO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CODIGO"/></xsl:attribute>
		</input>
       	<input type="text" name="OR_AGRUPARPOR">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/AGRUPARPOR"/></xsl:attribute>
		</input>
        <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/EIS_XML/LANG"><xsl:value-of select="/EIS_XML/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
      
	    <xsl:value-of select="document($doc)/translation/texts/item[@name='sistema_info_direccion']/node()"/>
        <table class="tablaEIS" >
		<tr>
		<td>
			<p><strong><xsl:value-of select="document($doc)/translation/texts/item[@name='sistema_info_direccion']/node()"/></strong></p>
            <p><xsl:value-of select="document($doc)/translation/texts/item[@name='consultas_predefinidas']/node()"/></p>
      		<xsl:for-each select="/EIS_XML/CONSULTAPREDEFINIDA/LISTACONSULTAS/GRUPO">
            
        		<table class="tablaEIS">
	    		<tr>
				   	<th>
						<xsl:value-of select="NOMBRE"/>&nbsp;
				    </th>
				</tr>
      			<xsl:for-each select="./CONSULTA">
	    			<tr>
				   		<td><span class="datosObligatorios">*</span>&nbsp;
							<a>
							<xsl:attribute name="href">EISBasico.xsql?IDCONSULTA=<xsl:value-of select="ID"/>
							</xsl:attribute>
							<xsl:value-of select="NOMBRE"/>
							</a>
				    	</td>
					</tr>
      			</xsl:for-each>
				</table>
				<br/>
      		</xsl:for-each>
		</td>
		</tr>
		</table>
		</form>

	<br/>

        <table class="tablaEIS" >
	    <tr>	 
			<th><xsl:value-of select="document($doc)/translation/texts/item[@name='indicadores']/node()"/></th>
      		<xsl:for-each select="/EIS_XML/CONSULTAPREDEFINIDA/RESULTADOCONSULTA/DATOSEIS/LISTAMESES/MES">
	      		<th class="seis">
					<xsl:value-of select="NOMBRE"/>
				</th>
      		</xsl:for-each>
		</tr>
      	<xsl:for-each select="/EIS_XML/CONSULTAPREDEFINIDA/RESULTADOCONSULTA/DATOSEIS/CUADRODEMANDO/INDICADOR">
		<xsl:variable name="IDINDICADOR">
			<xsl:value-of select="./IDINDICADOR"/>
		</xsl:variable>
	    <tr>	 
	      	<th><xsl:value-of select="./NOMBREINDICADOR"/></th>
		</tr>
      		<xsl:for-each select="GRUPO">
				<xsl:variable name="IDGRUPO">
					<xsl:value-of select="./IDGRUPO"/>
				</xsl:variable>
				<tr>	
					<th>
						<xsl:value-of select="./NOMBREGRUPO"/>&nbsp;
					</th>
      				<xsl:for-each select="ROW">
						<th>
							<a>
							<xsl:attribute name="HREF">javascript:MostrarListado('<xsl:value-of select="$IDINDICADOR"/>','<xsl:value-of select="$IDGRUPO"/>','<xsl:value-of select="./MES"/>');</xsl:attribute>
							<xsl:value-of select="./TOTAL"/>&nbsp;
							</a>
						</th>
      				</xsl:for-each>   
				</tr>
      		</xsl:for-each>
      	</xsl:for-each>
		</table> 
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
