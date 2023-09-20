<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Logotipos de logotipos. Nuevo disenno 2022.
	Ultima revisión: 16may22 17:35
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

  <xsl:template match="/">
    <html>
      <head>
      
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
         
         <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Logotipos/LANG"><xsl:value-of select="/Logotipos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
		<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
      
      
         <script type="text/javascript">
         var referenciaDuplicada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_lugar_duplicada']/node()"/>';
         </script>
         <title><xsl:value-of select="/Logotipos/CENTROS/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Logotipos']/node()"/></title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
<script type="text/javascript">
<!--
function CambiarCentro(idEmpresa, idCentro){
	parent.zonaEmpresa.CambioCentroActual(idEmpresa, idCentro);
	document.location=='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten2022.xsql?ID='+idCentro;
}
                   
function Guardar(ID)
{
	document.forms['frmLogos'].ACCION.value='GUARDAR';
	document.forms['frmLogos'].IDCENTRO.value=ID;
	document.forms['frmLogos'].IDLOGOTIPO.value=jQuery('#IDLOGO_'+ID).val();

	SubmitForm(document.forms['frmLogos']);
}
                   
//-->        
</script>
        ]]></xsl:text> 
        
        
      </head>
      <body>
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:otherwise>  
          
        <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Logotipos/LANG"><xsl:value-of select="/Logotipos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">
				<xsl:value-of select="/Logotipos/CENTROS/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Logotipos']/node()"/>
				<span class="CompletarTitulo">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
        <form name="frmLogos" id="frmLogos" action="Logotipos2022.xsql" method="post">
		<input type="hidden" name="IDEMPRESA" value="{Logotipos/CENTROS/IDEMPRESA}"/>
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="IDCENTRO"/>
		<input type="hidden" name="IDLOGOTIPO"/>
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr>
				<th class="w1x"></th>
				<td style="width:350px;">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='logotipo']/node()"/>
				</td>
				<td>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
				</td>
				<td class="w100px">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/>
				</td>
				<td class="w200px">
            	</td>
					&nbsp;
            	<td>
					&nbsp;
            	</td>
          </tr>
      
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
		<xsl:for-each select="Logotipos/CENTROS/CENTRO">
		<tr class="conhover">
			<td class="color_status">&nbsp;</td>
			<td>
   				<img src="{URLLOGO}" style="width:350px;height:60px"/>
			</td>
			<td class="textLeft">
				&nbsp;<strong><a href="javascript:CambiarCentro({/Logotipos/CENTROS/IDEMPRESA},{ID});"><xsl:value-of select="NOMBRE"/></a></strong>
			</td>
			<td>
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="LOGOTIPOS/field"/>
				<xsl:with-param name="nombre">IDLOGO_<xsl:value-of select="ID"/></xsl:with-param>
				<xsl:with-param name="id">IDLOGO_<xsl:value-of select="ID"/></xsl:with-param>
				<xsl:with-param name="claSel">w200px</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>
				<a class="btnDestacado" href="javascript:Guardar({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
			</td>
			<td>
			</td>
        </tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="12">&nbsp;</td></tr>
		</tfoot>
		</table>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
        </div>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
