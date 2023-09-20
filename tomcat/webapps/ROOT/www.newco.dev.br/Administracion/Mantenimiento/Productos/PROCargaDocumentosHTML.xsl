<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html>
      <head> 
      <title>   
      	Carga de documentos
      </title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
     <script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CargaDocumentos.js"></script>
     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>    
   

      </head>
  
      <body class="gris">
        <h1 class="titlePage" id="OneProdManten">     
         Carga de documentos
        </h1>	
        <div class="divLeft">         
                    
            <xsl:apply-templates select="CargaDocumentos"/> 
        </div>	 
        
        <!--frame para las imagenes-->
	<div id="uploadFrameBoxDoc" style="display:;"><iframe src="" id="uploadFrameDoc" name="uploadFrameDoc" style="width: 100%;"></iframe></div>
    
      </body>
    </html>
  
</xsl:template>



<xsl:template match="CargaDocumentos">
	
 <form name="formCarga" method="post">
 	<input type="hidden" name="HISTORIA"/>
    <input type="hidden" name="CADENA_DOCUMENTOS" />
    <input type="hidden" name="DOCUMENTOS_BORRADOS" />  
    <input type="hidden" name="ID_USUARIO" value="{PRODUCTO/USUARIO/US_ID}" />  
    <input type="hidden" name="ID_PROVEEDOR" value="{PRODUCTO/USUARIO/EMP_ID}" />  
    <input type="hidden" name="BORRAR_ANTERIORES" />  
    
    <div class="divLeft">
  	
    <div id="confirmBox" style="display:none;" align="center"><span class="cargado">¡Documento Cargado!</span></div>
    
  <!--tabla imagenes y documentos-->
  <table class="infoTable" border="0">
  <tr><td colspan="2"><strong>Se permite cargar documentos de tamaños inferiores a 10 MB.</strong></td></tr>
  
  <tr>
  	<td class="labelRight cuarenta">Nombre documento:</td>
    <td class="datosLeft">
    	<input type="text" name="DOC_NOMBRE" size="30" />
    </td>
 </tr>
 <tr>
    	<td class="labelRight">Descripción documento:</td>
        <td class="datosLeft">
            <textarea name="DOC_DESCRI" cols="50" rows="2"> 
            </textarea>
        </td>
  </tr>
  <tr>
     <!--documentos-->
        <td class="labelRight">Subir documento:</td>
        <td class="datosLeft">
       	<div class="altaDocumento">

            <fieldset class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(1)" /></xsl:call-template>
            </fieldset>
			<!--<fieldset class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(2)" /></xsl:call-template>
            </fieldset>
			<fieldset class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(3)" /></xsl:call-template>
            </fieldset>
            <fieldset class="anadirDoc">
                <xsl:call-template name="documentos"><xsl:with-param name="num" select="number(4)" /></xsl:call-template>
            </fieldset>-->
        
        </div>	
        </td>
     </tr>
     <tr><td colspan="2">&nbsp;</td></tr>
  </table><!--fin de tabla imagenes doc-->
  
  <div id="waitBoxDoc" align="center">&nbsp;</div>
  
  </div><!--fin de divleft-->
 <br /><br />
 	<div class="divLeft">
        	<div class="divLeft30">&nbsp;</div>
        	<div class="divLeft20">
       			<div class="boton">
         			<a href="javascript:window.close();">
                    	Cerrar
                    </a>
       			</div>
     		</div>
            <div class="divLeft10">&nbsp;</div>
            <div class="divLeft20">
       			<div class="boton">
                	<a href="javascript:cargaDoc(document.forms['formCarga'],'waitBoxDoc');">
                    	Enviar
                    </a>
         			
       			</div>
     		</div>
       <br /><br />
    </div><!--fin divleft botones-->
  
 </form> 
 
</xsl:template>
 


<!--documentos-->
<xsl:template name="documentos">
	<xsl:param name="num" />
	<xsl:choose>
	<!--imagenes de la tienda-->
		<xsl:when test="$num &lt; number(5)">
			<div class="docLine" id="docLine_{$num}">
				<xsl:if test="number($num) &gt; number(1)">	
						<xsl:attribute name="style">display: none;</xsl:attribute>
				</xsl:if>
				<div class="docLongEspec">
					<!--<label class="medium" for="inputDoc_{$num}">Documento&nbsp;<xsl:value-of select="$num"/>:</label>-->
					<input id="inputFileDoc_{$num}" name="inputFileDoc" type="file" onChange="addDocFile({$num});" />
				</div>
			</div>
		</xsl:when>
		
	</xsl:choose>
    </xsl:template>
<!--fin de documentos-->

</xsl:stylesheet>




















