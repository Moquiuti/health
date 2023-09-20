<?xml version="1.0" encoding="iso-8859-1" ?>
<!--  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:import href = "http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/Comentarios_lib.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
  <xsl:template match="/">
    <html>
      <head>
		<title>Mantenimiento de Comentarios por Empresa</title>
         <!--style-->
          <xsl:call-template name="estiloIndip"/>
          <!--fin de style-->  

         <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

		
	    
	<xsl:text disable-output-escaping="yes"><![CDATA[
        <script type="text/javascript">
        <!--
		
		function ActualizarDatos(Accion, ID)		
		{
			var form=document.forms[0];
			
			if (Accion=='BORRAR')
			{
				form.elements['IDCOMENTARIO'] .value=ID;
			}
			form.elements['ACCION'].value=Accion;
			SubmitForm(form);
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
          <h1 class="titlePage">
            Mantenimiento de Comentarios
			<xsl:if test="/Comentarios/COMENTARIOS/TITULOS/EMPRESA!=''">
			de <xsl:value-of select="/Comentarios/COMENTARIOS/TITULOS/EMPRESA"/>
			</xsl:if>
	      </h1>
          
        <form name="form1" action="Comentarios.xsql" method="post">
		<input type="hidden" name="ACCION"/>
		<input type="hidden" name="IDCOMENTARIO"/>
		<input type="hidden" name="IDRELACIONADO1" value="{/Comentarios/COMENTARIOS/TITULOS/IDEMPRESA}"/>
		<!--
          <input type="hidden" name="EMP_ID" value="{MantenimientoEmpresas/EMP_ID}"/>
          <input type="hidden" name="ACCION"/>
          <input type="hidden" name="DESDE"/>
          <input type="hidden" name="NUEVO_CLIENTE"/>
          <input type="hidden" name="NUEVO_CENTRO"/>
          
          
           <input type="hidden" name="EMP_PEDMINIMO_ACTIVO" value="{MantenimientoEmpresas/EMP_PEDMINIMO_ACTIVO}"/>
            <input type="hidden" name="EMP_PEDMINIMO_IMPORTE"  value="{MantenimientoEmpresas/EMP_PEDMINIMO_IMPORTE}"/>
             <input type="hidden" name="EMP_PEDMINIMO_DETALLE"  value="{MantenimientoEmpresas/EMP_PEDMINIMO_DETALLE}"/>
        -->     
      
    			<xsl:call-template name="Comentarios">
                	<xsl:with-param name="COMENTARIOS" select="/Comentarios/COMENTARIOS"/>
                	<xsl:with-param name="IDTIPO" select="/Comentarios/COMENTARIOS/TITULOS/IDTIPO"/>
                	<xsl:with-param name="BORRAR" select="'S'"/>
           		</xsl:call-template>
       		
        			<table class="infoTable">
        			<tr>
            			<td class="labelRight trenta">Tipo:&nbsp;</td>
            			<td class="datosLeft">
            				&nbsp;<select name="TIPO">
                              <option value="GENERAL" selected="true">Comentarios generales</option>
                              <option value="PRECIOS">Precios</option>
                              <option value="PEDMIN">Pedido mínimo</option>
                              <option value="COMISIONES">Comisiones</option>
                           </select>
            			</td>
        			</tr>
        			<tr>
            			<td class="labelRight"><xsl:value-of select="/Comentarios/COMENTARIOS/TITULOS/RELACIONADO2"/>:</td>
            			<td class="datosLeft">
	   						<xsl:call-template name="desplegable">
								<xsl:with-param name="path" select="/Comentarios/COMENTARIOS/EMPRESAS/field">
        						</xsl:with-param>
							</xsl:call-template>
            			</td>
        			</tr>
        			<tr>
            			<td class="labelRight">Titulo:</td>
            			<td class="datosLeft">
            				<input type="text" name="TITULO" maxlength="100" size="50"/> 
            			</td>
        			</tr>
        			<tr>
            			<td class="labelRight">Texto:</td>
            			<td class="datosLeft" align="left">
            				<input type="text" name="TEXTO" maxlength="1000" size="100"/> 
            			</td>
        			</tr>
                    <tr>
                    <td class="trenta">&nbsp;</td>
                    <td><xsl:call-template name="boton">
           					<xsl:with-param name="path" select="/Comentarios/button[@label='GuardarComentario']"/>
        				</xsl:call-template>
                    </td>
                    </tr>
					</table>
			
					<br/>
					<br/>
			
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
</xsl:template>

</xsl:stylesheet>