<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Mantenimiento de Menus de un Usuario
	Ultima revision: ET 20jun23 17:50 MenusManten2022_200623
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

	<title><xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_menus']/node()"/></title>
	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->  

	<script src="http://www.newco.dev.br/General/jquery-3.6.0.js"></script>	
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic2022_010822.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/MenusManten2022_200623.js"></script>
	<script type="text/javascript">
        var msgMaximoBotones='<xsl:value-of select="document($doc)/translation/texts/item[@name='Num_menus_superado_max']/node()"/>';
        var msgMinimoBotones='<xsl:value-of select="document($doc)/translation/texts/item[@name='Num_menus_0']/node()"/>';
        
        var arrayPerfiles=new Array();

        <xsl:for-each select="/Mantenimiento/MENUS/PERFILES_MENUS/PERFIL">
            var cadenaMenus='';
            <xsl:for-each select="MENU">
              cadenaMenus+='<xsl:value-of select="ID"/>'+'|'+'<xsl:value-of select="ACCESIBLE"/>'+'|'+'<xsl:value-of select="CABECERA"/>'+'#';
            </xsl:for-each>
            arrayPerfiles[arrayPerfiles.length]=new Array('<xsl:value-of select="./@id"/>',cadenaMenus);
        </xsl:for-each>

    </script> 
    </head>

    <body>
	<!-- Formulario de datos -->	        
		<xsl:choose>
	  	<xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>
        </xsl:when>   
        <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="/Mantenimiento/SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="//SESION_CADUCADA"/>
              </xsl:if>
            </xsl:for-each>
        </xsl:when> 
        <xsl:otherwise> 
            <xsl:apply-templates select="/Mantenimiento/MENUS"/>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
 
<!--
 |  Templates
 +-->
<xsl:template match="MENUS">
   <form method="post" action="MenusManten2022.xsql">
	<input type="hidden" name="LANG" value="{/Mantenimiento/LANG}"/>
	<input type="hidden" name="ID_USUARIO" value="{/Mantenimiento/MENUS/ID_USUARIO}"/>
	<input type="hidden" name="EMP_ID" value="{/Mantenimiento/MENUS/EMP_ID}"/>
	<input type="hidden" name="CAMBIOS_MENUS"/>
 	<input type="hidden" name="ACCION" value=""/>
    
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
    		<xsl:value-of select="document($doc)/translation/texts/item[@name='mantenimiento_de_menus']/node()"/>:&nbsp;<xsl:value-of select="/Mantenimiento/MENUS/USUARIO"/>
			<xsl:if test="/Mantenimiento/MENUS/RESULTADO">
				<span class="fuentePeq">(<xsl:value-of select="/Mantenimiento/MENUS/RESULTADO" />)</span>
			</xsl:if>  	           
			<span class="CompletarTitulo" style="width:300px;">
        		<a class="btnNormal" href="javascript:window.close();"><xsl:value-of select="document($doc)/translation/texts/item[@name='cancelar']/node()"/></a>&nbsp;
        		<a class="btnDestacado" href="javascript:ValidaySubmit(document.forms[0], 'MENUSUSUARIO');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar']/node()"/></a>&nbsp;
			</span>
		</p>
	</div>
	<br/>
	<br/>
	<table cellspacing="6px" cellpadding="6px">				
    <tr>
    	<td colspan="6" style="text-align:center;">
    		<label><xsl:value-of select="document($doc)/translation/texts/item[@name='perfiles_predefinidos_puede']/node()"/>.</label>
        </td>
    </tr> 
	<tr>
          <td class="veinte">&nbsp;</td>
            <xsl:for-each select="PERFILES_MENUS/PERFIL">
                <xsl:if test="@nombre != 'Administrador Vendedor'"><!--provee no puede ser admin quitado 26-8-14-->
                    <td class="diez">
					<a class="btnNormal" href="javascript:CargarPerfilMenus({./@id});">
						<xsl:choose><xsl:when test="contains(./@nombre,'Administrador')">Administrador</xsl:when><xsl:otherwise><xsl:value-of select="./@nombre"/></xsl:otherwise></xsl:choose>
					</a>
                  </td>   
                </xsl:if>  
          </xsl:for-each>
          <td class="veinte">&nbsp;</td>
	</tr>
	</table>
    <br/>
    <table cellspacing="6px" cellpadding="6px">
      <xsl:for-each select="TIPO">
        <xsl:if test="./MENU">
        <tr class="subTituloTabla">
        <th colspan="4">
          <xsl:value-of select="@nombre"/>
        </th>
        </tr>
            <tr>
              <th class="w400px">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='titulo']/node()"/>
              </th>
              <th class="w400px">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='descripcion']/node()"/>
              </th>
              <th class="w200px">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='autorizado']/node()"/>
              </th>
              <th class="w200px">
              	<xsl:value-of select="document($doc)/translation/texts/item[@name='menu_principal']/node()"/>
              </th>
            </tr>
          <xsl:for-each select="./MENU">
            <tr>
              <td class="textLeft">
                &nbsp;&nbsp;<xsl:value-of select="NOMBRE"/>
              </td>
              <td class="textLeft">
                &nbsp;&nbsp;<xsl:value-of select="DESCRIPCION"/>
              </td>
              <td class="textCenter">
                <xsl:choose>
                  <xsl:when test="AUTORIZADO='S'">  
                    <input type="checkbox" name="MENU_{ID}" checked="checked" onClick="deshabilitaCabecera(this);"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <input type="checkbox" name="MENU_{ID}" unchecked="unchecked" onClick="deshabilitaCabecera(this);"/> 
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td class="textCenter">
                <xsl:choose>
                  <xsl:when test="CABECERA='S'">  
                    <input type="checkbox" name="CABECERA_{ID}" checked="checked" onclick="comprobarMaximoBotonesCabecera(0,10,this);"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <input type="checkbox" name="CABECERA_{ID}" unchecked="unchecked" onclick="comprobarMaximoBotonesCabecera(0,10,this);"/> 
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              </tr>
          </xsl:for-each>
        </xsl:if>
      </xsl:for-each>
    </table>
    <br /><br />
   <div class="divLeft">
   <table cellspacing="6px" cellpadding="6px">
   <tr>
	<td class="w200px">
    	&nbsp;<label><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfiles_por_defecto']/node()"/>:</label>
    </td>
    <xsl:choose>
        <xsl:when test="PERFILES_MENUS/PERFIL[1]/@nombre = 'Administrador Comprador'">
            <td class="w200px">
    			<a class="btnNormal w200px" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|1');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_administrador']/node()"/></a>
            </td> 
            <td class="w200px">
                <a class="btnNormal w200px" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|4');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_comprador']/node()"/></a>
            </td>
            <td class="w200px">
                <a class="btnNormal w200px" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|5');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_usuario_cdc']/node()"/></a>
            </td>
            <td class="w200px">
                <a class="btnNormal w200px" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|6');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_comercial']/node()"/></a>
            </td>
        </xsl:when>
        <xsl:when test="PERFILES_MENUS/PERFIL[1]/@nombre = 'Administrador Vendedor'">
            <td class="w200px">
                <a class="btnNormal w200px" href="javascript:ValidaySubmit(document.forms[0], 'MENUSPORDEFECTO'+'|3');"><xsl:value-of select="document($doc)/translation/texts/item[@name='guardar_perfil_comercial']/node()"/></a>
            </td>
        </xsl:when>
    </xsl:choose>
    <td>&nbsp;</td>
	
   </tr>
 </table>
 <br /><br />
</div><!--fin de divLeft-->
</form>	      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>

</xsl:stylesheet>
