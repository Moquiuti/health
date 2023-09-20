<?xml version="1.0" encoding="iso-8859-1" ?>
<!---->
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

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/eis.js"></script>
	
	<xsl:text disable-output-escaping="yes">
	<![CDATA[	
  	<script type="text/javascript">
	<!--
		
	//	Funciones de Javascript
	
	
	function HabilitarRatios(form,valor,dspOrigen, dspDestino){
	  if(form.elements[dspOrigen].value==valor){
	    form.elements[dspDestino].disabled=false;
	  }
	  else{
	    form.elements[dspDestino].selectedIndex=0;
	    form.elements[dspDestino].disabled=true;
	  }
	}	
	//-->
	</script>
	

	]]>
	</xsl:text>	
    </head>
    <body>
   
		<!--	Comprueba si la sesión ha caducado	-->
	<xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
        	<xsl:apply-templates select="//SESION_CADUCADA"/> 
        </xsl:when>
		<xsl:otherwise>
        <div class="divCenter">
	    <!-- Cabecera -->
	  	<form method="post" action="EISDatos.xsql"><!--?xml-stylesheet=none-->
		<!--
       	<input type="hidden" name="Indicadores" value=""/>
       	<input type="hidden" name="OR_US_ID">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/US_ID"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_SES_ID">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/SES_ID"/></xsl:attribute>
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
       	<input type="hidden" name="OR_IDRESULTADOS">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDRESULTADOS"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_AGRUPARPOR">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/AGRUPARPOR"/></xsl:attribute>
		</input>
       	<input type="hidden" name="OR_IDRATIO">
			<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/IDRATIO"/></xsl:attribute>
		</input>
		-->
		<!--	Comprueba si no hay datos	-->   
        
        <!--idioma-->
        <xsl:variable name="lang">
        	<xsl:value-of select="/EIS_XML/LANG" />
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
        <table class="infoTable" >
		<tr>
        <th>&nbsp;</th>
		<th colspan="4" class="tituloTabla">
       		<xsl:value-of select="document($doc)/translation/texts/item[@name='sistema_info_direccion']/node()"/>
			(<xsl:value-of select="document($doc)/translation/texts/item[@name='actualizado']/node()"/>: <xsl:value-of select="/EIS_XML/EISANALISIS/ACTUALIZACION"/>) - <xsl:value-of select="document($doc)/translation/texts/item[@name='totales_mensuales']/node()"/>
		</th>
        <th>&nbsp;</th>
        </tr>
      
		<tr> <td>&nbsp;</td><td colspan="4">&nbsp; </td> <td>&nbsp;</td></tr>
	    <tr> 
       
      		<xsl:for-each select="/EIS_XML/EISANALISIS/FILTROS/field"> 
           
				<xsl:choose> 
					<xsl:when test='(position() mod 2) and position()!=1'>
						<xsl:text disable-output-escaping="yes">
							<![CDATA[</tr><tr>]]>
						</xsl:text>	
					</xsl:when> 
				</xsl:choose> 
				<xsl:choose>
				  <xsl:when test="count(/EIS_XML/EISANALISIS/FILTROS/field) mod 2!=0 and position()=last()">
                    <td>&nbsp;</td>
				    <td class="label">
					<xsl:value-of select="./@label"/>:&nbsp;
				    </td>
				    <td class="datosleft" colspan="3">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select=".">
        				</xsl:with-param>
      				       </xsl:call-template>				
				    </td>
                    
				  </xsl:when>
				  <xsl:otherwise>
                  <xsl:if test="./@label = 'Cuadro de Mando' or ./@label = 'Empresa'">
                   	<td>&nbsp;</td>
                  </xsl:if>
				    <td class="label">
					<xsl:value-of select="./@label"/>:&nbsp;
				    </td>
				    <td class="datosLeft">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select=".">
        				</xsl:with-param>
      				       </xsl:call-template>				
				    </td>
                    <xsl:if test="./@label = 'Año' or ./@label = 'Centro'">
                   		<td>&nbsp;</td>
                    </xsl:if>
				  </xsl:otherwise>
				</xsl:choose>
				
      		</xsl:for-each> 
           
			<xsl:text disable-output-escaping="yes">
				<![CDATA[</tr>]]>
			</xsl:text>
			<tr>
             <td>&nbsp;</td>
				<td class="label">
					<xsl:value-of select="/EIS_XML/EISANALISIS/AGRUPARPOR/field/@label"/>:&nbsp;
				</td>
				<td class="datosLeft">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/AGRUPARPOR/field">
        				</xsl:with-param>
      				</xsl:call-template>				
				</td>
				<td colspan="2">&nbsp;</td>
                <td>&nbsp;</td>
			</tr>
			<tr>
                <td>&nbsp;</td>
				<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='documento']/node()"/>:&nbsp;</td>
				<td class="datosLeft">
					<table><tr>
					<td>
					<input type="text" name="CODIGO">
					<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/CODIGO"/></xsl:attribute>
					</input>
					</td>
					<td>
					<small>&nbsp;'?': <xsl:value-of select="document($doc)/translation/texts/item[@name='un_unico_caracter']/node()"/>: '0604?01'<br/>&nbsp;'*': <xsl:value-of select="document($doc)/translation/texts/item[@name='una_cadena']/node()"/>: '*<xsl:value-of select="document($doc)/translation/texts/item[@name='jering']/node()"/>*'</small>
					</td>
					</tr>
                    </table>
				</td>
				<td class="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>:&nbsp;</td>
				<td class="datosLeft">
					<table><tr>
					<td>
					<input type="text" name="REFERENCIA">
					<xsl:attribute name="value"><xsl:value-of select="/EIS_XML/EISANALISIS/VALORES/REFERENCIA"/></xsl:attribute>
					</input>
					</td>
					<td>
					<small>&nbsp;'?': <xsl:value-of select="document($doc)/translation/texts/item[@name='un_unico_caracter']/node()"/>: '0604?01'<br/>&nbsp;'*': <xsl:value-of select="document($doc)/translation/texts/item[@name='una_cadena']/node()"/>: '*<xsl:value-of select="document($doc)/translation/texts/item[@name='jering']/node()"/>*'</small>
					</td>
					</tr></table>
				</td>
                <td>&nbsp;</td>
			</tr>
			<tr>
             <td>&nbsp;</td>
				<td class="label">
					<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@label"/>:&nbsp;
				</td>
				<td class="datosLeft">
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRESULTADOS/field">
        				</xsl:with-param>
        				<xsl:with-param name="onChange">HabilitarRatios(document.forms[0],'RATIO','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@name"/>','<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@name"/>');</xsl:with-param>
      				</xsl:call-template>				
				</td>
				<td class="label">
					<xsl:value-of select="/EIS_XML/EISANALISIS/IDRATIO/field/@label"/>:&nbsp;
				</td>
				<td class="datosLeft">
				  <xsl:variable name="vDeshabilitado">
				    <xsl:if test="/EIS_XML/EISANALISIS/IDRESULTADOS/field/@current!='RATIO'">
        		              disabled
        		            </xsl:if>
				  </xsl:variable>
					<xsl:call-template name="desplegable">
        				<xsl:with-param name="path" select="/EIS_XML/EISANALISIS/IDRATIO/field"> 
        				</xsl:with-param>
        				<xsl:with-param name="deshabilitado"><xsl:value-of select="$vDeshabilitado"/></xsl:with-param>
      				</xsl:call-template>				
				</td>
                 <td>&nbsp;</td>
			</tr>
            </tr>
           
         </table>
       
       <div class="divleft marginTop20">
       		<div class="divLeft40">&nbsp;</div>
            <div class="divLeft20 botonLargo">
					<a href="javascript:SubmitForm(document.forms[0])"><xsl:value-of select="document($doc)/translation/texts/item[@name='presentar_cuadro_mando']/node()"/></a>
            </div>
   	   </div><!--fin divLeft boton-->
       		
		</form>
        </div>
      </xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
