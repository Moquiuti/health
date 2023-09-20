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
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	  <!--
	  var turno_sel_familias=0;
          
	  function Actua(formu,NombreCampoCheck,link){
            if(valida_alguna_seleccion(formu,NombreCampoCheck,]]></xsl:text>'<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0080' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes">'<![CDATA[)){
              agrupaArray(formu,NombreCampoCheck);
              Envia(formu,link);
            }
          }          
          
          function Seleccionar(formu,NombreCampoCheck){
	    if (turno_sel_familias == 0){
              for (j=0; j<formu.elements.length;j++) {
              if (formu.elements[j].name.substr(0,7)==NombreCampoCheck){
        	  formu.elements[j].checked=true;
	        }
	      }
	    }else{
              for (j=0; j<formu.elements.length;j++) {
              if (formu.elements[j].name.substr(0,7)==NombreCampoCheck){
        	  formu.elements[j].checked=false;
	        }
	      }	    
	    } 
	    turno_sel_familias = !turno_sel_familias;           
          }
	  //-->
	</script>
        ]]></xsl:text>       
      </head>
      <body bgcolor="#EEFFFF">
	<xsl:choose>
	  <xsl:when test="not(//TooManyRows) and not(//NoDataFound)">       
            <!--<xsl:attribute name="onLoad">Selecciona(document.forms[0],'<xsl:value-of select="Lista/form/LLP_PRODUCTO_DETERMINADO"/>')</xsl:attribute>   -->
	  </xsl:when>
	</xsl:choose> 
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
            <p class="tituloForm">     
              <xsl:apply-templates select="//xsql-error"/>
            </p>
          </xsl:when>
          <xsl:when test="//TooManyRows">       
            <p class="tituloPag">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0220' and @lang=$lang]" disable-output-escaping="yes"/>
              <hr/>
            </p>
            <p class="tituloForm">            
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0230' and @lang=$lang]" disable-output-escaping="yes"/>
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
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr align="center" valign="top">          
          <td><xsl:apply-templates select="../jumpTo"/></td> 
          <td><xsl:apply-templates select="button[1]"/></td>
          <td><xsl:apply-templates select="button[2]"/></td>
          <td><xsl:apply-templates select="button[3]"/></td>                              
        </tr>
      </table>
    <br/>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center"><img align="rigth" src="{//BANNERS/BANNERS_ROW/BN_LOCATION}" alt="{//BANNERS/BANNERS_ROW/BN_TEXTO_ALTERNATIVO}"/></td>
      </tr>
    </table>
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
       
             
	  <input type="hidden" name="LLP_CATEGORIA" value="{LLP_CATEGORIA}"/>
	  <input type="hidden" name="LLP_FAMILIA" value="{LLP_FAMILIA}"/>  
	  <input type="hidden" name="LLP_SUBFAMILIA" value="{LLP_SUBFAMILIA}"/>  
	  <input type="hidden" name="LLP_NOMBRE" value="{LLP_NOMBRE}"/>    
	  <input type="hidden" name="LLP_DESCRIPCION" value="{LLP_DESCRIPCION}"/>  
	  <input type="hidden" name="LLP_FABRICANTE" value="{LLP_FABRICANTE}"/>      
	  <input type="hidden" name="LLP_MARCA" value="{LLP_MARCA}"/>        
	  <input type="hidden" name="LLP_PROVEEDOR" value="{LLP_PROVEEDOR}"/>        
	  <input type="hidden" name="LLP_HOMOLOGADO" value="{LLP_HOMOLOGADO}"/>        
	  <input type="hidden" name="LLP_CERTIFICACION" value="{LLP_CERTIFICACION}"/>            
	  <input type="hidden" name="LLP_NIVEL_CALIDAD" value="{LLP_NIVEL_CALIDAD}"/>            
	  <input type="hidden" name="LLP_PROV_HABITUALES" value="{LLP_PROV_HABITUALES}"/>            
	  <input type="hidden" name="LLP_PRODUCTO_DETERMINADO" value="{LLP_PRODUCTO_DETERMINADO}"/>     
	  <input type="hidden" name="LLP_PRESENTACION" value="{LLP_PRESENTACION}"/>     	  
	  <input type="hidden" name="LLP_ORDERBY" value="{LLP_ORDERBY}"/>              
	  <input type="hidden" name="LLP_LISTAR" value="{LLP_LISTAR}"/>
	  <input type="hidden" name="OPERACION" value="{OPERACION}"/>    
	  <input type="hidden" name="LLP_IDESPECIALIDAD" value="{LLP_IDESPECIALIDAD}"/>    
	  
	  	  
	  <input type="hidden" name="LLP_ID" value="{LLP_ID}"/>
	  <input type="hidden" name="LP_ID" value="{LP_ID}"/>  
	  <input type="hidden" name="TCV_ID" value="{TCV_ID}"/>    

	  <input type="hidden" name="REGISTROSPORPAGINA" value="{REGISTROSPORPAGINA}"/>	  
	  <input type="hidden" name="EMPRESATOTAL" value="{EMPRESATOTAL}"/>
	  
	  <input type="hidden" name="FAMILIATOTAL"/>	  	              
      <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0" >      
        <tr bgcolor="#A0D8D7"><td colspan="2">
          <p class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0460' and @lang=$lang]" disable-output-escaping="yes"/>
          </p></td>
        </tr>
        <tr><td colspan="2">&nbsp;</td></tr> 
        <xsl:apply-templates select="FAMILIAS/FAMILIA_ROW"/>   
      </table>

      </form>                 
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr align="center" valign="top">          
          <td><xsl:apply-templates select="../jumpTo"/></td> 
          <td><xsl:apply-templates select="button[1]"/></td>
          <td><xsl:apply-templates select="button[2]"/></td>
          <td><xsl:apply-templates select="button[3]"/></td>                              
        </tr>
      </table> 
</xsl:template>
    
<xsl:template match="FAMILIA_ROW">
        <tr>
	  <td><input type="checkbox" name="FAMILIA{FAM_ID}" value="{FAM_ID}"/>
          </td>        
	  <td><p class="tituloCamp">
	    <xsl:apply-templates select="FAM_NOMBRE"/> (<i><xsl:apply-templates select="CAT_NOMBRE"/></i>)</p></td>	    
        </tr>
</xsl:template>
</xsl:stylesheet>
