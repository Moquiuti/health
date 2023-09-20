<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Asignación de comerciales a los clientes
	Ultima revisión: ET 3oct19 10:55
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/ListadoComerciales/LANG"><xsl:value-of select="/ListadoComerciales/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='asignar_comerciales']/node()"/></title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script><!-- para basic_180608.js -->
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script><!-- para SubmitForm	-->
        
	<xsl:text disable-output-escaping="yes"><![CDATA[
	   <script type="text/javascript">
        <!--
	function BorrarRelacion(IDVendedor, IDCentroCliente)
	{
    	var seguroBorrar= document.forms['MensajeJS'].elements['SEGURO_BORRAR'].value;
		if (confirm(seguroBorrar))
		{
	          document.forms[0].elements['ACCION'].value='BORRAR';
	          document.forms[0].elements['IDVENDEDOR'].value=IDVendedor;
	          document.forms[0].elements['IDCENTROCLIENTE'].value=IDCentroCliente;
			  SubmitForm(document.forms[0]);
		}
	}

	function CrearRelacion()
	{
	      document.forms[0].elements['ACCION'].value='CREAR';
	      document.forms[0].elements['IDVENDEDOR'].value=document.forms[0].elements['LISTAUSUARIOS'].value;
	      document.forms[0].elements['IDCENTROCLIENTE'].value=document.forms[0].elements['LISTACENTROS'].value;
		  
		  //alert('CrearRelacion:'+document.forms[0].elements['ACCION'].value+':'+document.forms[0].elements['IDVENDEDOR'].value+':'+document.forms[0].elements['IDCENTROCLIENTE'].value);
		  
		  SubmitForm(document.forms[0]);
	}
	//-->      
	</script>
     ]]></xsl:text>	
        
      </head>
      <body>   
      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/ListadoComerciales/LANG"><xsl:value-of select="/ListadoComerciales/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
      
      <xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
              <xsl:apply-templates select="//SESION_CADUCADA"/>    
        </xsl:when>
        <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>
           </xsl:when>
        <xsl:otherwise>
	    <!-- Titulo -->
		<form action="AsignarComerciales.xsql" name="Comerciales" method="POST">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="IDEMPRESA" value="{/ListadoComerciales/LISTA_COMERCIALES_CLIENTE/IDEMPRESA}"/>
		<input type="hidden" name="IDVENDEDOR"/>
		<input type="hidden" name="IDCENTROCLIENTE"/>
        

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='cartera_clientes_por_vendedor']/node()"/></span></p>
			<p class="TituloPagina">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='comercial_principal']/node()"/>:&nbsp;<xsl:value-of select="/ListadoComerciales/LISTA_COMERCIALES_CLIENTE/COMERCIALPORDEFECTO"/>
				<span class="CompletarTitulo">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
        <xsl:if test="/ListadoComerciales/LISTA_COMERCIALES_CLIENTE/COMERCIAL_CLIENTE">
            <table class="buscador">
                <tr class="subTituloTabla">	
					<th class="cinco">&nbsp;</th>
					<th align="left" class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='centro_propio']/node()"/></th>
					<th align="left"><xsl:value-of select="document($doc)/translation/texts/item[@name='vendedor']/node()"/></th>
					<th align="left" class="trenta"><xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/></th>
					<th class="cinco"><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
				</tr>
	       		<xsl:for-each select="/ListadoComerciales/LISTA_COMERCIALES_CLIENTE/COMERCIAL_CLIENTE">
                <tr>
					<td>&nbsp;</td>
					<td class="textLeft">
						<xsl:value-of select="CENTROPROVEDOR"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="VENDEDOR"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="CENTROCLIENTE"/>
					</td>
					<td>
                    	<a href="javascript:BorrarRelacion({IDVENDEDOR},{IDCLIENTE})">
                        	<img src="/images/2017/trash.png"/>
                    	</a>
					</td>
                 </tr>
			</xsl:for-each> 
	    	</table>
        	</xsl:if>
			<br/>
			<br/>
			<br/>
			<table class="buscador">
				<tr>
				<td>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/ListadoComerciales/LISTA_COMERCIALES_CLIENTE/LISTAUSUARIOS/field"/>
					<xsl:with-param name="style">width:450px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="/ListadoComerciales/LISTA_COMERCIALES_CLIENTE/LISTACENTROS/field"/>
					<xsl:with-param name="style">width:350px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td>
					<a class="btnDestacado" href="javascript:CrearRelacion();"><xsl:value-of select="document($doc)/translation/texts/item[@name='crear_relacion']/node()"/></a>
				</td>
           </tr>
         </table>

		</form>
        <form name="MensajeJS">
			<input type="hidden" name="SEGURO_BORRAR" value="{document($doc)/translation/texts/item[@name='seguro_de_borrar_relacion']/node()}"/>
        </form>
		</xsl:otherwise>
      </xsl:choose> 
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
