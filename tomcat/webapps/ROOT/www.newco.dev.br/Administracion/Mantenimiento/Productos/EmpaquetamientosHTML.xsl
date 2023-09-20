<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Mantenimiento de empaquetamientos privados
	Ultima revisión: ET 21may19 08:33
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Empaquetamientos/LANG"><xsl:value-of select="/Empaquetamientos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
           
      <title><xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/></title>
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

      
	<xsl:text disable-output-escaping="yes"><![CDATA[
        <script type="text/javascript">
        <!--
        	            
       		function EnviarEmpa(form){
            	var msg = '';
                
            	var proId	= form.elements['PRO_ID'].value;
                var cliente	= form.elements['IDCLIENTE'].value;
                var unBasica	= encodeURIComponent(form.elements['UN_BASICA'].value);
                var unLote	= form.elements['UN_LOTE'].value;
                
                if (cliente != '' && unBasica != '' && unLote != ''){
                
                    jQuery.ajax({
                    cache:	false,
                    url:	'EmpaquetamientosSave_ajax.xsql',
                    type:	"GET",
                    data:	"PRO_ID="+proId+"&IDCLIENTE="+cliente+"&UN_BASICA="+unBasica+"&UN_LOTE="+unLote,
                    contentType: "application/xhtml+xml",
                    error: function(objeto, quepaso, otroobj){
                        alert('error'+quepaso+' '+otroobj+''+objeto);
                    },
                    success: function(objeto){
                        var data = eval("(" + objeto + ")");
            
                        if(data.EmpaquetamientosSave.estado == 'OK'){
                           document.location.reload(true);	
                        }else{
                            alert(document.forms['MensajeJS'].elements['ERROR_INSERTAR_DATOS'].value);
                        }
                    }
                    });//fin jquery
            	}
                else{ 
                    msg = document.forms['MensajeJS'].elements['TODOS_CAMPOS_OBLI'].value; 
                    alert(msg);
                }
            }//fin de enviarEmpa
            
            function EliminarEmpa(form,cliente){
            
            	var proId= form.elements['PRO_ID'].value;
                
            	jQuery.ajax({
                cache:	false,
                url:	'EliminarEmpaquetamientos.xsql',
                type:	"GET",
                data:	"PRO_ID="+proId+"&IDCLIENTE="+cliente,
                contentType: "application/xhtml+xml",
                error: function(objeto, quepaso, otroobj){
                    alert('error'+quepaso+' '+otroobj+''+objeto);
                },
                success: function(objeto){
                    var data = eval("(" + objeto + ")");
        
                    if(data.EliminarEmpaquetamientos.estado == 'OK'){
                       document.location.reload(true);	
                    }else{
                        alert(document.forms['MensajeJS'].elements['ERROR_ELIMINAR_DATOS'].value);
                    }
                }
            });
            }
            -->
        </script>
        ]]></xsl:text> 
        
        
      </head>
      <body>
      	  <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Empaquetamientos/LANG"><xsl:value-of select="/Empaquetamientos/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
           
     
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
          <!-- 
          <h1 class="titlePage">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/>
	  	  </h1>
			-->

		<!--	Titulo de la página		-->
		<div class="ZonaTituloPagina">
			<p class="Path"><xsl:value-of select="document($doc)/translation/texts/item[@name='Inicio']/node()"/>&nbsp;/&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='producto']/node()"/>&nbsp;/&nbsp;<span class="FinPath"><xsl:value-of select="document($doc)/translation/texts/item[@name='empaquetamientos']/node()"/>&nbsp;</span>
			</p>
			<p class="TituloPagina">
				<xsl:value-of select="/Empaquetamientos/EMPAQUETAMIENTOS/PRO_REFERENCIA"/>:&nbsp;<xsl:value-of select="substring(/Empaquetamientos/EMPAQUETAMIENTOS/PRO_NOMBRE, 1, 75)"/>
				<span class="CompletarTitulo" style="width:460px;">
                   <a class="btnNormal" href="javascript:window.close();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                   </a>
				</span>
			</p>
		</div>
		<br/>
		<br/>
		<br/>

          
        <form name="form1" method="get">
         <input type="hidden" name="PRO_ID" id="PRO_ID" value="{/Empaquetamientos/EMPAQUETAMIENTOS/IDPRODUCTO}"/>
       
         <table class="buscador" border="0">
          <tr class="subTituloTabla">
            <th class="dies">&nbsp;</th>
            <th class="veinte">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>
            </th>
            <th class="veinte">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>
            </th>
            <th class="veinte">
            	<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_por_lote']/node()"/>
            </th>
            <th>&nbsp;</th>
           
          </tr>
          <xsl:choose>
            <xsl:when test="/Empaquetamientos/EMPAQUETAMIENTOS/EMPAQUETAMIENTO">
              <!-- mostramos cada empresa -->
              <xsl:for-each select="/Empaquetamientos/EMPAQUETAMIENTOS/EMPAQUETAMIENTO">
              <tr>
              	<td>&nbsp;</td>
                <td align="center"><xsl:value-of select="CLIENTE"/></td>
                <td align="center"><xsl:value-of select="UNIDADBASICA"/></td>
                <td align="center"><xsl:value-of select="UNIDADESPORLOTE"/></td>
                <td align="left" style="text-align:left;">
                	<a href="javascript:EliminarEmpa(document.forms[0],{IDCLIENTE});">
						<img src="http://www.newco.dev.br/images/2017/trash.png" alt="Eliminar"/>
					</a>
                </td>
              </tr>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <tr>
                <td colspan="5">
                	<strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_hay_datos']/node()"/></strong>
                </td>
              </tr>
            </xsl:otherwise>
          </xsl:choose>
        </table> 
       <br /><br />
     <!--tabla abajo mantenimiento-->

	<!--nuevo empaquetamineto-->          
          <table class="Buscador" border="0"> 
          
               <tr class="subTituloTabla">
                  <td colspan="5">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo_empaquetamiento']/node()"/>:<br/>
                  </td>
                </tr>
			<tr>
            <td class="dies">&nbsp;</td>
            <td class="labelRight trenta">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='cliente']/node()"/>:
	          	<xsl:choose>
            	<xsl:when test="/Empaquetamientos/EMPAQUETAMIENTOS/ADMIN">
					<span class="camposObligatorios">*</span>&nbsp;
                    <xsl:call-template name="desplegable">
              			<xsl:with-param name="path" select="/Empaquetamientos/EMPAQUETAMIENTOS/CLIENTES/field"></xsl:with-param>
                        <xsl:with-param name="class">select200</xsl:with-param>
            		</xsl:call-template>
            	</xsl:when>
            	<xsl:otherwise>
					&nbsp;<xsl:value-of select="/Empaquetamientos/EMPAQUETAMIENTOS/EMPRESA"/>
					<input type="hidden" name="IDCLIENTE" id="IDCLIENTE" value="{/Empaquetamientos/EMPAQUETAMIENTOS/IDEMPRESA}"/>
				</xsl:otherwise>
				</xsl:choose>
             </td>
             <td class="labelRight veintecinco">
              <xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_basica']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
              <input type="text" name="UN_BASICA" id="UN_BASICA" size="15"/>
             </td>
           	 <td class="labelRight veintecinco">
          	  &nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='unidad_por_lote']/node()"/>:<span class="camposObligatorios">*</span>&nbsp;
              <input type="text" name="UN_LOTE" id="UN_LOTE" size="15"/>
      		</td>
             <td>
			 &nbsp;&nbsp;&nbsp;&nbsp;
				<a class="btnDestacado" href="javascript:EnviarEmpa(document.forms[0]);">
					<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
				</a>
			 &nbsp;
			 </td>
         </tr>
        
	</table>
		<!--
      <br/>
      <br />
      <table width="100%">
		<tr align="center">
        	<td class="veinte">&nbsp;</td>
              <td>
                <div class="boton">
                       <a href="javascript:window.close();">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                       </a>
                 </div>
              </td>
              <td>
                 <div class="boton">
                       <a href="javascript:EnviarEmpa(document.forms[0]);">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
                       </a>
                 </div>
              </td>
              <td>&nbsp;</td>
            </tr>
          </table>
		  -->
        </form>
        
        <form name="MensajeJS">
 
        	<input type="hidden" name="ERROR_INSERTAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_insertar_datos']/node()}"/>
            
            <input type="hidden" name="ERROR_ELIMINAR_DATOS" value="{document($doc)/translation/texts/item[@name='error_eliminar_datos']/node()}"/>
            
            <input type="hidden" name="TODOS_CAMPOS_OBLI" value="{document($doc)/translation/texts/item[@name='todos_campos_obli']/node()}"/>
                     
        </form>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
