<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Configuración de la integración para lanzar pedidos o licitaciones. Nuevo disenno 2022.
	Ultima revisión: 17may22  09:00
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:param name="lang" select="@lang"/>

<xsl:template match="/">

<!--	Todos los documentos HTML deben empezar con esto	-->
<xsl:text disable-output-escaping='yes'>&lt;!doctype html></xsl:text>

<html>
	<head>

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  

	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Integracion/LANG"><xsl:value-of select="/Integracion/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>      	        <!--idioma fin-->

	<title><xsl:value-of select="/Integracion/CENTROS/EMPRESA"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='Integracion']/node()"/></title>

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
<script type="text/javascript">
<!--
function CambiarCentro(idEmpresa, idCentro){
	parent.zonaEmpresa.CambioCentroActual(idEmpresa, idCentro);
	window.location.href='http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENManten2022.xsql?ID='+idCentro;
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
		<div class="divLeft">
        <form name="form1" id="form1" action="Integracion2022.xsql" method="post">
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
 		<div class="tabela tabela_redonda">
			<table cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
				<tr>
					<th class="w1x"></th>
					<td class="w70px">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='logotipo']/node()"/>
					</td>
					<td class="textLeft">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='centro']/node()"/>
					</td>
					<td class="w100px">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_erp']/node()"/>
					</td>
					<td class="w100px">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='modelo_integracion']/node()"/>
					</td>
					<td class="w70px">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo_centro_integracion']/node()"/>
					</td>
					<td class="w100px">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='codificacion_pedidos']/node()"/>
					</td>
					<td class="w70px">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='sep_fich_carga_pedidos']/node()"/>
					</td>
					<td class="w100px">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='cabec_fich_carga_pedidos']/node()"/>
					</td>
					<td class="w100px">
						<xsl:value-of select="document($doc)/translation/texts/item[@name='columnas_fich_carga_pedidos']/node()"/>
					</td>
            		<td>
						&nbsp;
            		</td>
				</tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
			<xsl:for-each select="Integracion/CENTROS/CENTRO">
      		<tr>
				<td class="color_status">&nbsp;</td>
				<td>
   					<img src="{URLLOGO}" style="width:70px;height:15px"/>
				</td>
				<td align="left">
					<strong><a href="javascript:CambiarCentro({/Integracion/CENTROS/IDEMPRESA},{ID});"><xsl:value-of select="NOMBRE"/></a></strong>
				</td>
				<td align="left">
					<input id="NOMBREERP_{ID}" type="text" class="campopesquisa w100px" value="{CEN_NOMBREERP}" length="100"/>
				</td>
				<td align="left">
					<xsl:call-template name="desplegable">
					<xsl:with-param name="path" select="CEN_IDMODELOOCINTEGRACION/field"/>
					<xsl:with-param name="nombre">IDMODELO_<xsl:value-of select="ID"/></xsl:with-param>
					<xsl:with-param name="id">IDMODELO_<xsl:value-of select="ID"/></xsl:with-param>
					<xsl:with-param name="claSel">w100px</xsl:with-param>
					</xsl:call-template>
				</td>
				<td align="left">
					<input id="REFERENCIAINTEGRACION_{ID}" class="campopesquisa w70px" type="text" value="{CEN_REFERENCIAINTEGRACION}" length="100"/>
				</td>
				<td align="left">
					<input id="CODIFICACIONPEDIDOS_{ID}" class="campopesquisa w100px" type="text" value="{CEN_CODIFICACIONPEDIDOS}" length="100"/>
				</td>
				<td align="left">
					<input id="SEPFICCARGAPEDIDOS_{ID}" type="text" class="campopesquisa w70px" value="{CEN_SEPFICCARGAPEDIDOS}" length="100"/>
				</td>
				<td align="left">
					<input id="CABFICCARGAPEDIDOS_{ID}" type="text" class="campopesquisa w100px" value="{CEN_CABFICCARGAPEDIDOS}" length="100"/>
				</td>
				<td align="left">
					<input id="MODELOFICCARGAPEDIDOS_{ID}" type="text" class="campopesquisa w100px" value="{CEN_MODELOFICCARGAPEDIDOS}" length="100"/>
				</td>
				<td>
					<a class="btnDestacado" href="javascript:Guardar({ID});"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
				</td>
        	</tr>
			</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="12">&nbsp;</td></tr>
			</tfoot>
		</table><!--fin de infoTableAma-->
 		</div>
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
    </form>
    </div>
    </xsl:otherwise>
    </xsl:choose>
    </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
