<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Mantenimiento de comentarios para los pedidos. Nuevo disenno 2022.
 	Ultima revision: ET 17may22 10:10 UltimosComentarios_071021.js
 +-->
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
		<xsl:when test="/Comentarios/LANG"><xsl:value-of select="/Comentarios/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
    <title><xsl:value-of select="/Comentarios/LISTA_COMENTARIOS/CENTRO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='repositorio_comentarios']/node()"/></title>
    <!--style-->
    <xsl:call-template name="estiloIndip"/>
    <!--fin de style-->

	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios2022_170522.js"></script>
</head>
<body class="gris" onLoad="javascript:Inicio();">
	<!--idioma-->
	<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Comentarios/LANG"><xsl:value-of select="/Comentarios/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>  
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>        <!--idioma fin-->
        
	<div class="divLeft">
    <form name="form1" method="post" action="UltimosComentarios2022.xsql">
        <input type="hidden" name="IDEMPRESA" value="{/Comentarios/LISTA_COMENTARIOS/IDEMPRESA}"/>
        <input type="hidden" name="IDCENTRO" value="{/Comentarios/LISTA_COMENTARIOS/IDCENTRO}"/>
        <input type="hidden" name="COMENTARIO" value="{/Comentarios/COMENTARIO}"/>
        <input type="hidden" name="TIPO" value="{/Comentarios/TIPO}"/>
        <input type="hidden" name="ACCION" value="{/Comentarios/ACCION}"/>
        <input type="hidden" name="CAMBIOS"/>
        <input type="hidden" name="NOMBRE_OBJETO" value="{/Comentarios/NOMBRE_OBJETO}"/>
        <input type="hidden" name="NOMBRE_FORM" value="{/Comentarios/NOMBRE_FORM}"/>
        <input type="hidden" name="DEFECTO_SEL">
            <xsl:attribute name="value">
                <xsl:for-each select="LISTA_COMENTARIOS/COMENTARIOS">
                    <xsl:if test="PORDEFECTO = 'S'"><xsl:value-of select="ID" /></xsl:if>
                </xsl:for-each>
            </xsl:attribute>
        </input>
		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="TituloPagina">        
				<xsl:choose>
	            <xsl:when test="/Comentarios/LISTA_COMENTARIOS/LISTACENTROS">
					<!--	Desplegable de centros si el usuario es MVM o EMPRESA	-->
					<xsl:value-of select="document($doc)/translation/texts/item[@name='repositorio_comentarios']/node()"/>:&nbsp;
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Comentarios/LISTA_COMENTARIOS/LISTACENTROS/field"/>
						<xsl:with-param name="claSel">w400px</xsl:with-param>
						<xsl:with-param name="onChange">javascript:CambioCentro();</xsl:with-param>
					</xsl:call-template>
	            </xsl:when>
				<xsl:otherwise>
					<!--	Nombre del centro	-->
					<xsl:value-of select="/Comentarios/LISTA_COMENTARIOS/CENTRO"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='repositorio_comentarios']/node()"/>
				</xsl:otherwise>
    		  	</xsl:choose> 

				<span class="CompletarTitulo" style="width:400px;font-size:13px;">
        			<a class="btnNormal" href="javascript:window.close();">
            			<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
            		</a>
					&nbsp;
				</span>
			</p>
		</div>
		<br/>
		<br/>		
       
		<div class="tabela tabela_redonda">
		<table cellspacing="6px" cellpadding="6px">
			<thead class="cabecalho_tabela">
			<tr class="h40px">
				<th class="w1x"></th>
				<th class="textLeft w100px">
					<a class="btnDestacado" href="javascript:BorrarComentarios(document.forms['form1'],'BORRAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='eliminar']/node()"/></a>
				</th>
				<th class="textLeft w150px">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/>
				</th> 
				<th class="textLeft w150px">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Clausula_legal']/node()"/>
				</th> 
				<th class="textLeft w150px">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='Incluir_siempre']/node()"/>
				</th> 
				<th class="textLeft w100px">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='codigo']/node()"/>
				</th> 
				<th class="textLeft">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>
				</th> 
				<th>&nbsp;</th>
				<th class="w200px">
					<a class="btnDestacado" href="javascript:GuardarDefecto(document.forms['form1'],'DEFECTO')"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_por_defecto']/node()"/></a>
				</th>
				<th>&nbsp;</th>
            </tr>
			</thead>
			<!--	Cuerpo de la tabla	-->
			<tbody class="corpo_tabela">
            <xsl:for-each select="Comentarios/LISTA_COMENTARIOS/COMENTARIOS">
				<tr class="conhover">
					<td class="color_status">&nbsp;</td>
                	<td>
                		<input class="muypeq" type="checkbox" name="CHKCOMENTARIO_{ID}"/>
                		<input type="hidden" name="COMENTARIO_{ID}" value="{COMENTARIO}"/>
                	</td>
                	<td class="textLeft"> 
                    	&nbsp;<xsl:value-of select="CATEGORIA"/>
                	</td>
                	<td> 
                    	<xsl:value-of select="CLAUSULALEGAL"/>
                	</td>
                	<td> 
                    	<xsl:value-of select="INCLUIRSIEMPRE"/>
                	</td>
                	<td> 
                    	&nbsp;<xsl:value-of select="CODIGO"/>
                	</td>
                	<td class="textLeft"> 
                    	&nbsp;<xsl:copy-of select="COMENTARIO_HTML"/>
                	</td>
                	<td>  
                	<a class="btnDestacado btnCopiar" style="display:none" title="Pulse sobre el texto y se añadira al actual">
                    	<xsl:attribute name="href">javascript:copiarComentarios(<xsl:value-of select="ID" />);</xsl:attribute>
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='copiar']/node()"/>
                    	</a> 
                	</td>
                	<td>
                	  <!--<input class="muypeq" type="checkbox" name="CHKDEFECTO_{ID}" id="{ID}" onclick="GuardarPorDefecto(document.forms['form1'],{ID})">-->
                	  <input class="muypeq" type="checkbox" name="CHKDEFECTO_{ID}" id="{ID}">
                    	<xsl:if test="PORDEFECTO != 'N'">
                        	<xsl:attribute name="checked">true</xsl:attribute>
                    	</xsl:if>
                	  </input>
                	  <input type="hidden" name="DEFECTO_{ID}" value="{COMENTARIO}"/>
                	</td>
                	<td>&nbsp;</td>
           		</tr>
        	</xsl:for-each>
			</tbody>
			<tfoot class="rodape_tabela">
				<tr><td colspan="10">&nbsp;</td></tr>
			</tfoot>
		</table>
 		</div>
       	<p class="fuentePeq marginLeft200">*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_por_defecto_expli']/node()"/></p>
 		<br/>  
 		<br/>  
 		<br/>  
	    <table cellspacing="6px" cellpadding="6px" class="w1000px tableCenter"> 				
            <tr>
				<!--	Desplegable de categorias	-->
                <td>&nbsp;</td>
                <td class="labelRight w150px"><xsl:value-of select="document($doc)/translation/texts/item[@name='Clausula_legal']/node()"/>:&nbsp;</td>
                <td class="textLeft"> 
					<input type="checkbox" name="chkCLAUSULALEGAL" id="chkCLAUSULALEGAL" class="muypeq" onchange="javascript:ClausulaLegalChange();"/>
					<input type="hidden" name="CLAUSULALEGAL"/>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
				<!--	Desplegable de categorias	-->
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Incluir_siempre']/node()"/>:&nbsp;</td>
                <td class="textLeft"> 
					<input type="checkbox" name="chkINCLUIRSIEMPRE" id="chkINCLUIRSIEMPRE" class="muypeq" onchange="javascript:IncluirSiempreChange();"/>
					<input type="hidden" name="INCLUIRSIEMPRE"/>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
				<!--	Desplegable de categorias	-->
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='categoria']/node()"/>:&nbsp;</td>
                <td class="textLeft"> 
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Comentarios/LISTA_COMENTARIOS/LISTACATEGORIAS/field"/>
						<xsl:with-param name="claSel">w300px</xsl:with-param>
					</xsl:call-template>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='Codigo']/node()"/>:&nbsp;</td>
                <td class="textLeft"> 
					<xsl:call-template name="desplegable">
						<xsl:with-param name="path" select="/Comentarios/LISTA_COMENTARIOS/CODIGO/field"/>
						<xsl:with-param name="claSel">w100px</xsl:with-param>
					</xsl:call-template>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="labelRight"><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:&nbsp;</td>
                <td class="textLeft"> 
                    <textarea name="NUEVO_COMENTARIO" cols="80" rows="6"/>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="labelRight">&nbsp;</td>
                <td class="textLeft"> 
            		<a class="btnDestacado" href="javascript:GuardarComentario(document.forms['form1'],'INSERTAR');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
    </table> 
	<br/><br />
	</form>
    <form name="MensajesJS">
        <input type="hidden" name="COME_PARA_BORRAR" value="{document($doc)/translation/texts/item[@name='comentarios_para_borrar']/node()}"/>
        <input type="hidden" name="COME_SEL_BORRAR" value="{document($doc)/translation/texts/item[@name='borrar_comentarios_seleccionados']/node()}"/>
        <input type="hidden" name="SIN_COME_PARA_GUARDAR" value="{document($doc)/translation/texts/item[@name='sin_comentarios_para_guardar']/node()}"/>
        <input type="hidden" name="NO_COME_PARA_BORRAR" value="{document($doc)/translation/texts/item[@name='no_comentarios_para_borrar']/node()}"/>
        <input type="hidden" name="COME_YA_EXISTE" value="{document($doc)/translation/texts/item[@name='comentario_ya_existe']/node()}"/>
    </form>
    </div><!--fin de divleft-->
    </body>      
    </html>
  </xsl:template>

</xsl:stylesheet>
