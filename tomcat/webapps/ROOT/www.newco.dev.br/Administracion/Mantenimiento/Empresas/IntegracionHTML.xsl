<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Configuración de la integración por centro
	Ultima revisión: 27nov19 15:05
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
		<xsl:when test="/Integracion/LANG"><xsl:value-of select="/Integracion/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->

	<title><xsl:value-of select="/Integracion/CENTROS/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Integracion']/node()"/></title>

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
	document.forms['form1'].IDMODELO.value=jQuery('#IDMODELO_'+ID).val();
	document.forms['form1'].CEN_NOMBREERP.value=jQuery('#NOMBREERP_'+ID).val();
	document.forms['form1'].CEN_REFERENCIAINTEGRACION.value=jQuery('#REFERENCIAINTEGRACION_'+ID).val();
	document.forms['form1'].CEN_CODIFICACIONPEDIDOS.value=jQuery('#CODIFICACIONPEDIDOS_'+ID).val();
	document.forms['form1'].CEN_SEPFICCARGAPEDIDOS.value=jQuery('#SEPFICCARGAPEDIDOS_'+ID).val();
	document.forms['form1'].CEN_CABFICCARGAPEDIDOS.value=jQuery('#CABFICCARGAPEDIDOS_'+ID).val();
	document.forms['form1'].CEN_MODELOFICCARGAPEDIDOS.value=jQuery('#MODELOFICCARGAPEDIDOS_'+ID).val();

	SubmitForm(document.forms['form1']);
}
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
            <xsl:when test="/Integracion/LANG"><xsl:value-of select="/Integracion/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->


		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='integracion']/node()"/>&nbsp;</span></p>
			<p class="TituloPagina">
				<xsl:value-of select="/Integracion/CENTROS/EMPRESA"/>
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
        <form name="form1" id="form1" action="Integracion.xsql" method="post">
          <input type="hidden" name="IDEMPRESA" value="{/Integracion/CENTROS/IDEMPRESA}"/>
          <input type="hidden" name="ACCION"/>
          <input type="hidden" name="IDCENTRO"/>
          <input type="hidden" name="IDMODELO"/>
          <input type="hidden" name="CEN_NOMBREERP"/>
          <input type="hidden" name="CEN_REFERENCIAINTEGRACION"/>
          <input type="hidden" name="CEN_CODIFICACIONPEDIDOS"/>
          <input type="hidden" name="CEN_SEPFICCARGAPEDIDOS"/>
          <input type="hidden" name="CEN_CABFICCARGAPEDIDOS"/>
          <input type="hidden" name="CEN_MODELOFICCARGAPEDIDOS"/>
   		<div class="divLeft">
        
        <table class="buscador">
        
		<xsl:choose>
        <xsl:when test="Integracion/CENTROS/CENTRO">
          <tr class="subTituloTabla">
			<td style="width:70px;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='logotipo']/node()"/>
			</td>
			<td class="treinta">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
			</td>
			<td class="cinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_erp']/node()"/>
			</td>
			<td class="diez">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_integracion']/node()"/>
			</td>
			<td class="diez">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_centro_integracion']/node()"/>
			</td>
			<td class="diez">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='codificacion_pedidos']/node()"/>
			</td>
			<td class="cinco">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='sep_fich_carga_pedidos']/node()"/>
			</td>
			<td class="diez">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cabec_fich_carga_pedidos']/node()"/>
			</td>
			<td class="diez">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='columnas_fich_carga_pedidos']/node()"/>
			</td>
            <td>
				&nbsp;
            </td>
          </tr>
      
		<xsl:for-each select="Integracion/CENTROS/CENTRO">
      	<tr>
			<td>
   				<img src="{URLLOGO}" style="width:70px;height:15px"/>
			</td>
			<td align="left">
				&nbsp;<strong><a href="javascript:CambiarCentro({/Integracion/CENTROS/IDEMPRESA},{ID});"><xsl:value-of select="NOMBRE"/></a></strong>
			</td>
			<td align="left">
				&nbsp;<input id="NOMBREERP_{ID}" type="text" class="medio" value="{CEN_NOMBREERP}" length="100"/>
			</td>
			<td align="left">&nbsp;
				<xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="CEN_IDMODELOOCINTEGRACION/field"/>
				<xsl:with-param name="nombre">IDMODELO_<xsl:value-of select="ID"/></xsl:with-param>
				<xsl:with-param name="id">IDMODELO_<xsl:value-of select="ID"/></xsl:with-param>
				</xsl:call-template>
			</td>
			<td align="left">
				&nbsp;<input id="REFERENCIAINTEGRACION_{ID}" class="medio" type="text" value="{CEN_REFERENCIAINTEGRACION}" length="100"/>
			</td>
			<td align="left">
				&nbsp;<input id="CODIFICACIONPEDIDOS_{ID}" class="medio" type="text" value="{CEN_CODIFICACIONPEDIDOS}" length="100"/>
			</td>
			<td align="left">
				&nbsp;<input id="SEPFICCARGAPEDIDOS_{ID}" type="text" class="peq" value="{CEN_SEPFICCARGAPEDIDOS}" length="100"/>
			</td>
			<td align="left">
				&nbsp;<input id="CABFICCARGAPEDIDOS_{ID}" type="text" value="{CEN_CABFICCARGAPEDIDOS}" length="100"/>
			</td>
			<td align="left">
				&nbsp;&nbsp;<input id="MODELOFICCARGAPEDIDOS_{ID}" type="text" value="{CEN_MODELOFICCARGAPEDIDOS}" length="100"/>
			</td>
			<td>
				&nbsp;<a class="btnDestacado" href="javascript:Guardar({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
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
