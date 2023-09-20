<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
   Mantenimiento de carpetas y plantillas de un usuario. Nuevo disenno 2022.
   Ultima revision: ET 16may22 12:07. CARPyPLManten2022_160522.js
-->
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
		<xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>  
		</xsl:variable>
		<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
		<!--idioma fin-->
      
		<title>
			<xsl:value-of select="/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/NOMBREEMPRESA"/>.&nbsp;<xsl:value-of select="/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/@usuario"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_de_carpetas_y_plantillas']/node()"/>
		</title>

       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  	
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
   	<!--<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>-->
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CARPyPLManten2022_160522.js"></script>
    
      
    <SCRIPT type="text/javascript">
	<xsl:text disable-output-escaping="yes"><![CDATA[

        <!-- 
        
        var msgMaximoBotones='Ha seleccionado un número de botones superior al permitido para mostrar en su menú principal. El máximo es 5';
        var msgMinimoBotones='No ha seleccionado ningún botón para el menú principal. Debe seleccionar al menos uno.';

			/*
          	array bidimensional en la primera posicion de cada registro guardo el id de la carpeta 
            y despues el id de todos las plantillas de esta carpeta
            
                0 [idCarpeta],[idPlantilla],[idPlantilla],[idPlantilla]
                1 [idCarpeta],[idPlantilla]
                2 [idCarpeta],[idPlantilla],[idPlantilla]
                ...
           */
           
           
           ]]></xsl:text>
          		  
          arrayPlantillas=new Array(<xsl:value-of select="count(/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/CARPETA)"/>);

          <xsl:for-each select="/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/CARPETA">
            var i='<xsl:value-of select="position()-1"/>';
            arrayPlantillas[parseInt(i)]=new Array(<xsl:value-of select="count(PLANTILLA)+1"/>);
            arrayPlantillas[i][0]=<xsl:value-of select="ID"/>;
            <xsl:for-each select="PLANTILLA">
              var j='<xsl:value-of select="position()"/>';
              arrayPlantillas[i][j]=<xsl:value-of select="ID"/>;
            </xsl:for-each>
            
          </xsl:for-each>  
		  
		  var IDCarpetaProvs='<xsl:value-of select="/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/CARPETA/ID"/>';

    </SCRIPT>        
	</head>

	<body>
	<!-- Formulario de datos -->	        
	<xsl:choose>
	  <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>
          </xsl:when>   
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="/Manrenimiento/SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="//SESION_CADUCADA"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when> 
          <xsl:otherwise>  
            <xsl:attribute name="onLoad">inicializarDerechosPorPlantilla(document.forms[0]);</xsl:attribute>            
            <xsl:apply-templates select="Mantenimiento/CATEGORIAS"/>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
 
<!--
 |  Templates
 +-->


<xsl:template match="CATEGORIAS">
   <form method="post" name="frmDerechos" action="CARPyPLManten2022.xsql">
     <xsl:apply-templates select="//ID_PROPIETARIO"/>
     <xsl:apply-templates select="//ID_USUARIO"/>   
     
     <input type="hidden" name="DERECHOSCARPETAS"/>
     <input type="hidden" name="DERECHOSPLANTILLAS"/>
     <input type="hidden" name="ACCION" id="ACCION"/>
     
		 <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Mantenimiento/LANG"><xsl:value-of select="/Mantenimiento/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->


	
	<!--	Titulo de la página		-->
	<div class="ZonaTituloPagina">
		<p class="TituloPagina">
    		<xsl:value-of select="/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/NOMBREEMPRESA"/>.&nbsp;<xsl:value-of select="/Mantenimiento/CATEGORIAS/CATEGORIA/CARPETAS/@usuario"/>:&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_de_carpetas_y_plantillas']/node()"/>
			<span class="CompletarTitulo300">
        		<a class="btnDestacado" href="javascript:ValidaySubmit();"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>&nbsp;
        		<a class="btnNormal" href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
<!--   
	16may22 Solo mostramos carpeta de proveedores: Textos de ayuda sin utilidad, los eliminamos 
  <table class="buscador">	
        <tr class="sinLinea">
          <td class="labelLeft">&nbsp;&nbsp;&nbsp;*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_todas_plantillas']/node()"/>.</td>  
        </tr>
        <tr class="sinLinea">             
           <td class="labelLeft">&nbsp;&nbsp;&nbsp;*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_carpetas']/node()"/>.</td>    
        </tr>
        <tr class="sinLinea">             
          <td class="labelLeft">&nbsp;&nbsp;&nbsp;*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_plantillas_carpeta']/node()"/>.</td>    
         </tr>
         <tr class="sinLinea">             
           <td class="labelLeft">&nbsp;&nbsp;&nbsp;*&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='derechos_plantilla']/node()"/>.</td>  
         </tr>
     </table>    
-->    
  <!--buttons selecion...totales- ->
	16may22 Solo mostramos carpeta de proveedores: Botones de "todos" sin utilidad, los eliminamos 
      <table class="buscador">
      <tr class="sinLinea">
        <td class="trenta">&nbsp;</td>
        <td class="doce">&nbsp;</td>
        <td class="catorce">
            <input type="hidden" name="LECT_ABSOLUTAMENTE_TODOS"/>
 			<a class="btnNormal" href="javascript:validacionEscrituraLectura('LECT',-1,'LECT_ABSOLUTAMENTE_TODOS',document.forms[0]);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='todas_lectura']/node()"/>
			</a>
       </td>
       <td class="catorce">
            <input type="hidden" name="ESCR_ABSOLUTAMENTE_TODOS"/>
 			<a class="btnNormal" href="javascript:validacionEscrituraLectura('LECT',-1,'ESCR_ABSOLUTAMENTE_TODOS',document.forms[0]);">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='todas_escritura']/node()"/>
			</a>
       </td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <!- -buttons arriba total-->
    	
	<div class="tabela tabela_redonda">
	<table class="w1000px tableCenter" cellspacing="6px" cellpadding="6px">
		<thead class="cabecalho_tabela">
		<tr>
			<th class="w1px">&nbsp;</th>
			<th class="textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='Proveedores']/node()"/></th>
			<th class="w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='lectura']/node()"/>&nbsp;<a class="btnDestacadoPeq" href="javascript:TodosLectura();"><xsl:value-of select="document($doc)/translation/texts/item[@name='todos']/node()"/></a></th>
			<th class="w200px"><xsl:value-of select="document($doc)/translation/texts/item[@name='escritura']/node()"/></th>
		</tr>
		</thead>
		<!--	Cuerpo de la tabla	-->
		<tbody class="corpo_tabela">
		<xsl:for-each select="CATEGORIA/CARPETAS/CARPETA/PLANTILLA">
			<tr class="con_hover">
				<td class="color_status">&nbsp;</td>
				<td class="textLeft">
					<a href="http://www.newco.dev.br/Compras/Multioferta/PLManten2022.xsql?PL_ID={ID}"><xsl:value-of select="NOMBRE"/>&nbsp;[<xsl:value-of select="LINEAS"/>]</a>
				</td>
				<td align="center">
				<xsl:choose>
				  <xsl:when test="LECTURA='S'">  
    				<input type="checkbox" name="LECT_{ID}" value="PLANTILLA_LECT" checked="checked" onClick="validacionEscrituraLectura('LECT',{ID},'ESTE',document.forms['frmDerechos']);"/>
					<input type="hidden" name="LECT_ORIG_{ID}" value="S"/>
				  </xsl:when>
				  <xsl:otherwise>
    				<input type="checkbox" name="LECT_{ID}" value="PLANTILLA_LECT" unchecked="unchecked" onClick="validacionEscrituraLectura('LECT',{ID},'ESTE',document.forms['frmDerechos']);"/> 
					<input type="hidden" name="LECT_ORIG_{ID}" value="N"/>
				  </xsl:otherwise>
				</xsl:choose>
				</td>
				<td align="center">
				<xsl:choose>
				  <xsl:when test="ESCRITURA='S'">  
    				<input type="checkbox" name="ESCR_{ID}" value="PLANTILLA_ESCR" checked="checked" onclick="validacionEscrituraLectura('ESCR',{ID},'ESTE',document.forms['frmDerechos']);">
				   <xsl:if test="BLOQUEADO">
        				<xsl:attribute name="disabled">disabled</xsl:attribute>
    				  </xsl:if>
    				</input>
					<input type="hidden" name="ESCR_ORIG_{ID}" value="S"/>
				   </xsl:when>
				  <xsl:otherwise>
    				<input type="checkbox" name="ESCR_{ID}" value="PLANTILLA_ESCR" unchecked="unchecked" onclick="validacionEscrituraLectura('ESCR',{ID},'ESTE',document.forms['frmDerechos']);">
    				<xsl:if test="BLOQUEADO">
        				<xsl:attribute name="disabled">disabled</xsl:attribute>
    				  </xsl:if>
    				</input> 
 					<input type="hidden" name="ESCR_ORIG_{ID}" value="N"/>
				 </xsl:otherwise>
				</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		</tbody>
		<tfoot class="rodape_tabela">
			<tr><td colspan="4">&nbsp;</td></tr>
		</tfoot>
	</table><!--fin de infoTableAma-->
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	<br/>  
 	</div>
	</form>	      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>
  

<xsl:template match="ID_USUARIO">
  <input type="hidden" name="ID_USUARIO">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template> 


<xsl:template match="ID_PROPIETARIO">
  <input type="hidden" name="ID_PROPIETARIO">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>      
  </input>
</xsl:template>


</xsl:stylesheet>
