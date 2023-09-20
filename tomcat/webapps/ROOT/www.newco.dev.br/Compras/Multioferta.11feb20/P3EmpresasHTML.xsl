<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="Lista">
    <html> 
      <head>
      
       <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript">
	   <!--
	  var turno_sel_empresas=0;
	  function Actua(formu,NombreCampoCheck,link)
	  {
		var ListaIDs='';
		
		  for (j=0;j<formu.elements.length;j++)
		  {
    		if ((formu.elements[j].type=='checkbox')&&(formu.elements[j].checked))
			{
				if (ListaIDs!='') ListaIDs=ListaIDs+',';
				ListaIDs=ListaIDs+Piece(formu.elements[j].name,'_',1);
			}
		  }  

		if (ListaIDs!='')
		{
			formu.elements['LLP_LISTAPROVEEDORES'].value=ListaIDs;
			SubmitForm(formu);
		}
		else alert('Debe seleccionar como mínimo un proveedor para poder continuar.')
      }
          
     function Seleccionar(formu,NombreCampoCheck)
	 {
	    if (turno_sel_empresas == 0){
           for (j=0; j<formu.elements.length;j++) 
			{
              if (formu.elements[j].name.substr(0,7)==NombreCampoCheck)
			  {
        	    formu.elements[j].checked=true;
	         }
	       }
	    }
		else
		{
          for (j=0; j<formu.elements.length;j++) 
		  {
            if (formu.elements[j].name.substr(0,7)==NombreCampoCheck)
			{
        	  formu.elements[j].checked=false;
	      	}
	      }	    
	    } 
	    turno_sel_empresas=!turno_sel_empresas;            
          }
	  //-->
	</script>
        ]]></xsl:text>       
      </head> 
      <body>
		   <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Lista/LANG"><xsl:value-of select="/Lista/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
      <!--idioma fin-->
      
        <xsl:choose> 
          <xsl:when test="//SESION_CADUCADA">
             <xsl:apply-templates select="//SESION_CADUCADA"/>            
          </xsl:when>
          <xsl:when test="//xsql-error"> 
            <p class="tituloForm">     
              <xsl:apply-templates select="//xsql-error"/>
            </p>
          </xsl:when>
          <xsl:when test="//TooManyRows">       
            <p class="tituloPag">
             <xsl:value-of select="document($doc)/translation/texts/item[@name='la_busqueda_no_ha_tenido_exito']/node()"/>
              <hr/>
            </p>
            <p class="tituloForm">            
             <xsl:value-of select="document($doc)/translation/texts/item[@name='la_busqueda_no_ha_tenido_exito']/node()"/>
            </p>
            <div align="center">
              <br/><xsl:apply-templates select="//jumpTo"/>
            </div>
          </xsl:when>

          <xsl:when test="//NoDataFound">       
            <xsl:apply-templates select="//NoDataFound"/>
          </xsl:when>
                              
          <xsl:otherwise>
            <xsl:apply-templates select="form"/>
          </xsl:otherwise>
        </xsl:choose>   
      </body>
    </html>
  </xsl:template>  

<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="form">                      
        <!--idioma-->
        <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="/Lista/LANG"><xsl:value-of select="/Lista/LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>

        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>       			        <!--idioma fin-->
        
   <div class="divLeft">  
    <!-- Formulario de datos -->
    <form>    
      <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>	
      <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>	   
      <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
      
      <!--
       |   CUIDADO: Los cambios en campos ocultos se deben copiar en:
       |	 P3EmpresasHTML.xsl
       |	 P3NomenclatorHTML.xsl
       |	 P3ListaHTML.xsl
       |	 P1ListaHTML.xsl
       |	 LLPMantenSaveHTML.xsl
       +-->      
      
	  <input type="hidden" name="LLP_NOMBRE" value="{LLP_NOMBRE}"/>    
	  <input type="hidden" name="LLP_PROVEEDOR" value="{LLP_PROVEEDOR}"/>        
	  <input type="hidden" name="LLP_LISTAPROVEEDORES" value=""/>        
	  <input type="hidden" name="REGISTROSPORPAGINA" value="{REGISTROSPORPAGINA}"/>	  
	  <input type="hidden" name="EMPRESATOTAL"/> <!-- Empresas seleccionadas, separadas por comas -->
	              
      
      <table class="encuesta">     
        <tr class="tituloTabla">
	  		<th colspan="5"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_de_proveedores']/node()"/></th>
		</tr>
        <tr class="titulos">
          <th class="cinco">
          <!--<xsl:apply-templates select="button[1]"/>-->
          <xsl:call-template name="botonNostyle">
            <xsl:with-param name="path" select="button[@label='Seleccionar']"/>
          </xsl:call-template>
          </th>
          <th class="cinco">&nbsp;</th>
          <th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
          <th class="quince textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
          <th class="quince textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></th>
         <!-- <th class="aster">Descripción</th>-->
        </tr>
          <xsl:for-each select="EMPRESAS/EMPRESA_ROW">
            <xsl:apply-templates select="."/>       
          </xsl:for-each>
          <tr class="titulos">
              <th>
                  <xsl:call-template name="botonNostyle">
                    <xsl:with-param name="path" select="button[@label='Seleccionar']"/>
                  </xsl:call-template>
              </th>
              <th class="cinco">&nbsp;</th>
         	  <th class="trenta textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedor']/node()"/></th>
              <th class="quince textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='tipo']/node()"/></th>
              <th class="quince textLeft"><xsl:value-of select="document($doc)/translation/texts/item[@name='provincia']/node()"/></th>
             <!-- <th class="aster">Descripción</th>-->
          
        </tr>
      </table> 
      </form>        
	 </div><!--fin de divLeft-->
    
     <div class="divLeft"> 
     <br />
     <br />      
       <div class="botonCenter">
       	 <xsl:call-template name="botonPersonalizado">
				<xsl:with-param name="funcion">Actua(document.forms[0],'EMPRESA','ListaProductos.xsql');</xsl:with-param>
				<xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></xsl:with-param>
			</xsl:call-template>
       </div>
       <br />
    <br />
     </div><!--fin de divLeft--> 
    
</xsl:template>

<xsl:template match="EMPRESA_ROW">
	<tr>
	  <td align="center"><input type="checkbox" name="EMPRESA_{EMP_ID}" value=""/>
      <!--<input type="checkbox" name="EMPRESA{EMP_ID}" value="{EMP_ID}"/>-->
      </td>        
      <td>&nbsp;</td>
	  <td class="textLeft"><a href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={EMP_ID}">
	    <xsl:apply-templates select="EMP_NOMBRE"/></a></td>
	  <td class="textLeft"> 
	    <xsl:value-of select="TIPOEMPRESA"/></td>	    
	  <td class="textLeft">  
	    <xsl:value-of select="EMP_PROVINCIA"/></td>	    
	  <!--<td align="left">
	    <xsl:value-of select="EMP_REFERENCIAS"/></td>	 -->   
	</tr>
</xsl:template>
</xsl:stylesheet>
