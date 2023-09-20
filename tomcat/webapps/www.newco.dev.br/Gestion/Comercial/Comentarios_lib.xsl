<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
 
<xsl:template name="Comentarios">
          
	<xsl:param name="COMENTARIOS"/>
	<xsl:param name="IDTIPO"/>
	<xsl:param name="BORRAR"/>
	<table class="infoTable" style="border:1px solid #333;">
		<tr class="subTituloTabla">
			<xsl:if test="$BORRAR='S'">
    			<td class="cinco">
        			Eliminar
    			</td>
			</xsl:if>
    		<td class="cinco">
        		Fecha
    		</td>
    		<td class="dies">
        		Usuario
    		</td>
    		<td class="dies">
        		<xsl:value-of select="$COMENTARIOS/TITULOS/RELACIONADO2"/>
    		</td>
    		<td class="cinco">
        		Tipo
    		</td>
    		<td class="dies">
        		Titulo
    		</td>
    		<td class="cuarenta">
        		Texto
    		</td>
		</tr>
		<xsl:choose>
    		<xsl:when test="$COMENTARIOS/COMENTARIO">
				<xsl:for-each select="$COMENTARIOS/COMENTARIO">
        			<tr>	
						<xsl:if test="$BORRAR='S'">
            				<td>
                    			<a href="javascript:ActualizarDatos('BORRAR',{ID});" onmouseover="window.status='Eliminar comentario';return true;" onmouseout="window.status=''; return true;">
                                	<img src="http://www.newco.dev.br/images/2017/trash.png"/>
                            	</a>
            				</td>
						</xsl:if>
            			<td>
            				<xsl:value-of select="FECHA"/>
            			</td>
            			<td>
            				<xsl:value-of select="USUARIO"/>
            			</td>
            			<td>
                        	<xsl:value-of select="RELACIONADO2"/>
            			</td>
            			<td>
                        	<xsl:value-of select="TIPO"/>
                        </td>
            			<td>
            				<xsl:value-of select="TITULO"/>
            			</td>
            			<td class="datosLeft">
            				<xsl:value-of select="TEXTO"/>
            			</td>
        			</tr>
				</xsl:for-each>
			</xsl:when>
    		<xsl:otherwise>
				<tr><td colspan="7"><strong>No existen comentarios para esta empresa</strong></td></tr>
			</xsl:otherwise>
		</xsl:choose>
	</table>
</xsl:template>


</xsl:stylesheet>