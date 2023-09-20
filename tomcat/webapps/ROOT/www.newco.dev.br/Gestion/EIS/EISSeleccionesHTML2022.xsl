<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Creación de selecciones/agrupaciones de centros/empresas
	Se utilizará en filtros, al crear licitaciones, etc
	
	Ultima revisión: ET 5set22 17:15 EISSelecciones2022_050922.js
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
      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/EISSelecciones/LANG"><xsl:value-of select="/EISSelecciones/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='selecciones']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
    <script type="text/javascript" src="http://www.newco.dev.br/Gestion/EIS/EISSelecciones2022_050922.js"></script>

    <script type="text/javascript">
        var sincroErrorPerfil = '<xsl:value-of select="document($doc)/translation/texts/item[@name='sincronizacion_error_perfil']/node()"/>';
        var sincroOkPerfil = '<xsl:value-of select="document($doc)/translation/texts/item[@name='sincronizacion_ok_perfil']/node()"/>';
        var refYaInsertada = '<xsl:value-of select="document($doc)/translation/texts/item[@name='ref_ya_insertada']/node()"/>';
        var nombreObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_obli_seleccion']/node()"/>';
        var tipoObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='tipo_obli_seleccion']/node()"/>';
        var elementosObli = '<xsl:value-of select="document($doc)/translation/texts/item[@name='elementos_obli_seleccion']/node()"/>';
        var strRegistrosIncluidos = '<xsl:value-of select="document($doc)/translation/texts/item[@name='Registros_incluidos']/node()"/>';
        var strAvisoBorrar = '<xsl:value-of select="document($doc)/translation/texts/item[@name='seguro_de_borrar_registro']/node()"/>';
    </script>

      </head>
      <!--<body onLoad="javascript:onLoad();">-->
      <body>
      <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/EISSelecciones/LANG"><xsl:value-of select="/EISSelecciones/LANG" /></xsl:when>
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
		<form action="EISSelecciones2022.xsql" name="Selecciones" method="POST">
			<input type="hidden" name="ACCION"/>
			<input type="hidden" name="IDSELECCION"/>
			<input type="hidden" name="IDUSUARIO"/>
			<input type="hidden" name="IDEMPRESA" value="{/EISSelecciones/SEL/SELECCIONES/IDEMPRESA}"/>

			<!--	Titulo de la página		-->
			<div class="ZonaTituloPagina">
				<p class="TituloPagina">
					<xsl:value-of select="/EISSelecciones/SEL/SELECCIONES/EMPRESA" />					
					<span class="CompletarTitulo" style="width:400px;font-size:13px;">
						<a class="btnNormal" href="javascript:NuevaSeleccion();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_seleccion']/node()"/>
						</a>&nbsp;
						<a class="btnNormal" href="javascript:DescargarExcel();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='CSV']/node()"/>
						</a>&nbsp;
					</span>
				</p>
			</div>
			<br/>
			<br/>		
			&nbsp;&nbsp;&nbsp;
			<xsl:choose>
       			<xsl:when test="/EISSelecciones/SEL/SELECCIONES/LISTAEMPRESAS">
					<label><xsl:value-of select="document($doc)/translation/texts/item[@name='empresa']/node()"/>:</label>&nbsp;
		        	<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/EISSelecciones/SEL/SELECCIONES/LISTAEMPRESAS/field"/>
						<xsl:with-param name="claSel">w600px</xsl:with-param>
					</xsl:call-template>
					&nbsp;&nbsp;&nbsp;
				</xsl:when>
				<xsl:otherwise>
				<input type="hidden" name="IDEMPRESALISTA" value="{/EISSelecciones/SEL/SELECCIONES/IDEMPRESA}"/>
				</xsl:otherwise>
			</xsl:choose>
			
			<label><xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/>:</label>&nbsp;
		    <xsl:call-template name="desplegable">
				<xsl:with-param name="path" select="/EISSelecciones/SEL/SELECCIONES/CLASIFICACIONES/field"/>
				<xsl:with-param name="nombre">IDFILTROCLASIFICACION</xsl:with-param>
				<xsl:with-param name="id">IDFILTROCLASIFICACION</xsl:with-param>
				<xsl:with-param name="claSel">w300px</xsl:with-param>
				<xsl:with-param name="onChange">javascript:CambioCategoria();</xsl:with-param>
			</xsl:call-template>
			<br/>
			<br/>
            <xsl:if test="/EISSelecciones/SEL/SELECCIONES/SELECCION">
			<div class="tabela tabela_redonda">
			<table cellspacing="6px" cellpadding="6px">
				<thead class="cabecalho_tabela">
                <tr>
                    <th class="w1px">&nbsp;</th>
                    <th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre']/node()"/></th>
                    <th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='nombre_corto']/node()"/></th>
                    <th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
                    <th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='total']/node()"/></th>
                    <th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='todas_las_empresas']/node()"/></th>
					<xsl:if test="/EISSelecciones/SEL/SELECCION/ADMINMVM">
                    	<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='AUTORIZADOS']/node()"/></th>
                    	<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Area_geografica']/node()"/></th>
                    	<th class="w50px"><xsl:value-of select="document($doc)/translation/texts/item[@name='EXCLUIDOS']/node()"/></th>
                    </xsl:if>
					<th class="w50px">&nbsp;</th>
                    <th class="w100px textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='autor']/node()"/></th>
                    <th class="w100px">&nbsp;</th>
                    <th><xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/></th>
                </tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
       		<xsl:for-each select="/EISSelecciones/SEL/SELECCIONES/SELECCION">
                <tr>
                <td class="color_status"><xsl:value-of select="CONTADOR"/></td>
				<td class="textLeft">
					<xsl:choose>
					<xsl:when test="AUTOR">
						<a href="javascript:Seleccion({EIS_SEL_ID});"><xsl:value-of select="EIS_SEL_NOMBRE"/></a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="EIS_SEL_NOMBRE"/>
					</xsl:otherwise>
					</xsl:choose>
                	<input type="hidden" name="EIS_SEL_NOMBRE" id="EIS_SEL_NOMBRE" value="{EIS_SEL_NOMBRE}" />
				</td>
                <td class="textLeft"><xsl:value-of select="EIS_SEL_NOMBRECORTO"/></td>
                <td class="textLeft"><xsl:value-of select="TIPO"/></td>
                <td class="textRight"><xsl:value-of select="TOTAL"/>&nbsp;&nbsp;</td>
                <td>
                    <xsl:if test="EIS_SEL_PUBLICO = 'S'"><img src="http://www.newco.dev.br/images/check.gif" alt="Si" /></xsl:if>
                </td>
				<xsl:if test="/EISSelecciones/SEL/SELECCION/ADMINMVM">
                	<td>
                    	<xsl:if test="EIS_SEL_AUTORIZADOS = 'S'"><img src="http://www.newco.dev.br/images/check.gif" alt="Si" /></xsl:if>
                	</td>
                	<td>
                    	<xsl:if test="EIS_SEL_AREAGEOGRAFICA = 'S'"><img src="http://www.newco.dev.br/images/check.gif" alt="Si" /></xsl:if>
                	</td>
                	<td>
                    	<xsl:if test="EIS_SEL_EXCLUIDOS = 'S'"><img src="http://www.newco.dev.br/images/check.gif" alt="Si" /></xsl:if>
                	</td>
				</xsl:if>
                <td>&nbsp;</td>
                <td class="textLeft"><xsl:value-of select="USUARIO"/></td>
                <td>&nbsp;</td>
				<td>
                <xsl:if test="AUTOR">
                    <a href="javascript:BorrarSeleccion({EIS_SEL_ID})">
                        <img src="http://www.newco.dev.br/images/2017/trash.png"/>
                    </a>
                </xsl:if>
				</td>
            </tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="15">&nbsp;</td></tr>
		</tfoot>
	    </table>
		</div>
    	<br />
    	<br />
    	<br />
    	<br />
    	</xsl:if>
	</form>
	</xsl:otherwise>
      </xsl:choose>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
