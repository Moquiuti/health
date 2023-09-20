<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 	Mantenimiento de logotipos
	Ultima revisión: 25nov19 15:05
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
  <xsl:template match="/">
    <html>
      <head>
      
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
         
         <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Logotipos/LANG"><xsl:value-of select="/Logotipos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->
      
      
         <script type="text/javascript">
         var referenciaDuplicada	= '<xsl:value-of select="document($doc)/translation/texts/item[@name='referencia_lugar_duplicada']/node()"/>';
         </script>
         <title><xsl:value-of select="/Logotipos/CENTROS/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Logotipos']/node()"/></title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
<script type="text/javascript">
<!--
function CambiarCentro(idEmpresa, idCentro){
	parent.zonaEmpresa.CambioCentroActual(idEmpresa, idCentro);
	window.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten.xsql?ID='+idCentro;
}
                   
function Guardar(ID)
{
	document.forms['form1'].ACCION.value='GUARDAR';
	document.forms['form1'].IDCENTRO.value=ID;
	document.forms['form1'].IDLOGOTIPO.value=jQuery('#IDLOGO_'+ID).val();

	SubmitForm(document.forms['form1']);
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
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='Logotipos']/node()"/>&nbsp;</span></p>
			<p class="TituloPagina">
				<xsl:value-of select="/Logotipos/CENTROS/EMPRESA"/>
				<span class="CompletarTitulo">
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>


      <!--
            <h1 class="TitlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_lugares_entrega']/node()"/></h1>
          -->
        <form name="form1" id="form1" action="Logotipos.xsql" method="post">
          <input type="hidden" name="IDEMPRESA" value="{Logotipos/CENTROS/IDEMPRESA}"/>
          <input type="hidden" name="ACCION"/>
          <input type="hidden" name="IDCENTRO"/>
          <input type="hidden" name="IDLOGOTIPO"/>
   		<div class="divLeft">
        
        <table class="buscador">
        
		<xsl:choose>
        <xsl:when test="Logotipos/CENTROS/CENTRO">
          <tr class="subTituloTabla">
			<td style="width:287px;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='logotipo']/node()"/>
			</td>
			<td>
				<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
			</td>
			<td class="diez">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='seleccionar']/node()"/>
			</td>
			<td class="veinte">
            </td>
				&nbsp;
            <td>
				&nbsp;
            </td>
          </tr>
      
		<xsl:for-each select="Logotipos/CENTROS/CENTRO">
      	<tr>
			<td style="height:50px">
   				<img src="{URLLOGO}" style="width:287px;height:50px"/>
			</td>
			<td align="left">
				&nbsp;<strong><a href="javascript:CambiarCentro({/Logotipos/CENTROS/IDEMPRESA},{ID});"><xsl:value-of select="NOMBRE"/></a></strong>
			</td>
			<td align="left">&nbsp;
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="LOGOTIPOS/field"/>
				<xsl:with-param name="nombre">IDLOGO_<xsl:value-of select="ID"/></xsl:with-param>
				<xsl:with-param name="id">IDLOGO_<xsl:value-of select="ID"/></xsl:with-param>
				</xsl:call-template>
			</td>
			<td>
				<a class="btnDestacado" href="javascript:Guardar({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
			</td>
			<td>
			</td>
        </tr>
		</xsl:for-each>
        </xsl:when>
       </xsl:choose>
    </table><!--fin datos centro-->
           </div>
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
