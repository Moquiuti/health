<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>    
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/BuscaProd.js">
	</script>
	<script type="text/javascript">
	<!--
	function refillFamilias(formu,valor_categoria){
	  // Borro opciones anteriores
	  deleteOptions(formu.LLP_FAMILIA);	  
	  deleteOptions(formu.LLP_SUBFAMILIA);
          // Anyado los options
          ]]></xsl:text> 
          <xsl:for-each select="BusquedaProductos/ESTRUCTURA_PRODUCTOS/CATEGORIA">
           if (valor_categoria=='<xsl:value-of select="@ID"/>'){          	   
            <xsl:for-each select="FAMILIA">
                <xsl:text disable-output-escaping="yes"><![CDATA[
                  addOption(formu.LLP_FAMILIA,']]></xsl:text><xsl:value-of select="@NOMBRE"/><xsl:text disable-output-escaping="yes"><![CDATA[',']]></xsl:text><xsl:value-of select="@ID"/><xsl:text disable-output-escaping="yes"><![CDATA[');
                ]]></xsl:text>                
             </xsl:for-each>                
            }
          </xsl:for-each>
          formu.LLP_FAMILIA.selectedIndex=0;
          formu.LLP_SUBFAMILIA.selectedIndex=0;        
	  <xsl:text disable-output-escaping="yes"><![CDATA[	  
	}
	        	
	function refillSubfamilias(formu,valor_familia){
	//Borro opciones anteriores
	  //formu.LLP_SUBFAMILIA.length=1;
          deleteOptions(formu.LLP_SUBFAMILIA);
          //Anado los options
          ]]></xsl:text> 
          <xsl:for-each select="BusquedaProductos/ESTRUCTURA_PRODUCTOS/CATEGORIA/FAMILIA">
            if (valor_familia=='<xsl:value-of select="@ID"/>'){          	             
              <xsl:for-each select="SUBFAMILIA">
                <xsl:text disable-output-escaping="yes"><![CDATA[addOption(formu.LLP_SUBFAMILIA,']]></xsl:text><xsl:value-of select="@NOMBRE"/><xsl:text disable-output-escaping="yes"><![CDATA[',']]></xsl:text><xsl:value-of select="@ID"/><xsl:text disable-output-escaping="yes"><![CDATA[');]]></xsl:text>                
              </xsl:for-each>
            }
          </xsl:for-each>               	    	    	   	    	              
          formu.LLP_SUBFAMILIA.selectedIndex=0;           
	 <xsl:text disable-output-escaping="yes"><![CDATA[
	}
	
	function Actualizar() {
	  var formu = window.document.forms[0];	  	  
	    ]]></xsl:text> 	    
	    <xsl:if test="BusquedaProductos/BuscForm/ROWSET/ROW/CATEGORIA[.!='-1']">
	      seleccionarCombo(formu.elements['LLP_CATEGORIA'],'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/CATEGORIA"/>');
	      refillFamilias(formu,'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/CATEGORIA"/>'); 	      
	    </xsl:if>
	    <xsl:if test="BusquedaProductos/BuscForm/ROWSET/ROW/FAMILIA[.!='-1']">
	      seleccionarCombo(formu.elements['LLP_FAMILIA'],'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/FAMILIA"/>');
	      refillSubfamilias(formu,'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/FAMILIA"/>');
	    </xsl:if>

	    <xsl:if test="BusquedaProductos/BuscForm/ROWSET/ROW/SUBFAMILIA[.!='-1']">
	      seleccionarCombo(formu.elements['LLP_SUBFAMILIA'],'<xsl:value-of select="BusquedaProductos/BuscForm/ROWSET/ROW/SUBFAMILIA"/>');
	    </xsl:if>
	    <xsl:text disable-output-escaping="yes"><![CDATA[
	}
	
	function Actua(formu){
	  categoria=formu.elements['LLP_CATEGORIA'].options[formu.elements['LLP_CATEGORIA'].selectedIndex].value;
	  familia=formu.elements['LLP_FAMILIA'].options[formu.elements['LLP_FAMILIA'].selectedIndex].value;
	  subfamilia=formu.elements['LLP_SUBFAMILIA'].options[formu.elements['LLP_SUBFAMILIA'].selectedIndex].value;
	  SetCookie('PROPManten', categoria+':'+familia+':'+subfamilia);	
	  SubmitForm(formu); 
	}
	
	function Load(){
	  if(is_nav==false || navigator.appVersion>5){
	    if(GetCookie('PROPManten')!=null){
	      array=GetCookie('PROPManten').split(":");
	      categoria=array[0];
	      familia=array[1];
	      subfamilia=array[2];
	      if(document.forms[0].elements['LLP_CATEGORIA'].options[document.forms[0].elements['LLP_CATEGORIA'].selectedIndex].value!='-1' && categoria!=""){
	        document.forms[0].elements['LLP_CATEGORIA'].value=categoria;
	        refillFamilias(document.forms[0],categoria);
	      }
	      if(familia!=""){
	        document.forms[0].elements['LLP_FAMILIA'].value=familia;
	        refillSubfamilias(document.forms[0],familia=array[1]);
	      }
	      if(subfamilia!=""){
	        document.forms[0].elements['LLP_SUBFAMILIA'].value=subfamilia;
	      }
	    }
	  }
	}			
	//-->
	</script>	
        ]]></xsl:text>   
      </head>

      <body bgcolor="#EEFFFF">
        <xsl:choose>
          <xsl:when test="//Status">
            <xsl:apply-templates select="//Status"/>
          </xsl:when>
          <xsl:when test="//xsql-error">          
            <xsl:apply-templates select="//xsql-error"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="onLoad">Load();</xsl:attribute>
            <xsl:apply-templates select="BusquedaProductos/BuscForm"/>
            <script>Actualizar();</script>
          </xsl:otherwise>                  	                     
        </xsl:choose>
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="BuscForm">
  <form>
    <xsl:attribute name="name">
      <xsl:value-of select="@name"/>
    </xsl:attribute>

    <xsl:attribute name="method">
      <xsl:value-of select="@method"/>
    </xsl:attribute>
    
    <xsl:attribute name="action">
      <xsl:value-of select="@action"/>
    </xsl:attribute>
    <!--
    <input type="hidden" name="LLP_CERTIFICACION" value="{LLP_CERTIFICACION}"/>        
    <input type="hidden" name="OPERACION" value="{../OP}"/>
    <input type="hidden" name="LLP_ID" value="{ROWSET/ROW/LLP_ID}"/>          
    <input type="hidden" name="LP_ID" value="{ROWSET/ROW/LLP_IDLISTA}"/>
    -->
    <xsl:apply-templates select="ROWSET/ROW/LLP_PROVEEDOR"/>
    <xsl:apply-templates select="ROWSET/ROW/EMP_ID"/>
    
    
    <xsl:apply-templates select="ROWSET/ROW"/>
  </form>
</xsl:template>

<xsl:template match="ROW">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr align="center">
      <td colspan="4" align="center">   
	<xsl:apply-templates select="../../button[1]"/>   
      </td>      	     
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>            
    <tr> 
      <td colspan="4" align="center"><p class="tituloPag">	        	           
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PROP-0010' and @lang=$lang]" disable-output-escaping="yes"/>
        de <xsl:value-of select="LLP_PROVEEDOR"/>	        
        </p></td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>    
    <tr bgcolor="#A0D8D7">
      <td colspan="4"><p class="tituloform"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0400' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>        
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0390' and @lang=$lang]" disable-output-escaping="yes"/>:
      </p></td>
      <td>
        <xsl:variable name="IDAct" >
          <xsl:value-of select="LLP_ORDERBY"/>
        </xsl:variable>
        <xsl:apply-templates select="../../field[@name='ORDERBY']"/>      
      </td>
      <td>
        &nbsp;
      </td>
      <td align="center">
        <xsl:apply-templates select="../../button[@label='CatalogoProductos']"/>
      </td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>                 
    <tr bgcolor="#A0D8D7"> 
      <td colspan="4"><p class="tituloForm">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0110' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
    </tr>
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td width="15%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0150' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td width="35%">  
	<xsl:apply-templates select="LLP_NOMBRE"/>
      </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0380' and @lang=$lang]" disable-output-escaping="yes"/>
        </p></td>
      <td colspan="3">  
        <xsl:variable name="IDAct" select="LLP_TIPO_PRODUCTO_ACTUAL"/>      
	<xsl:apply-templates select="../../field[@name='LLP_TIPO_PRODUCTO']"/>
      </td>
    </tr>
    <tr>
      <td width="15%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0180' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td width="35%">  
	<xsl:apply-templates select="LLP_MARCA"/>
      </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0170' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>
	<xsl:apply-templates select="LLP_FABRICANTE"/>
      </td>      
    </tr>
    <tr>
      <td width="15%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0460' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td width="35%">  
	<xsl:apply-templates select="LLP_REFERENCIA"/>
      </td>      
    </tr>
    <tr align="center" class="tituloForm"> 
      <td colspan="4">&nbsp;</td>
    </tr> 
    <tr align="center" class="tituloForm"> 
      <td colspan="4"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0600' and @lang=$lang]" disable-output-escaping="yes"/></td>
    </tr>   
    <tr> 
      <td colspan="4"><hr/></td>
    </tr>
    <tr>
      <td colspan="4" align="center" valign="top">
        &nbsp;
      </td>
    </tr>
           
    <xsl:apply-templates select="../../../ESTRUCTURA_PRODUCTOS"/>
    <tr> 
      <td colspan="4"><br/></td>
    </tr>    
    <tr align="center">
      <td colspan="4" align="center">   
	<xsl:apply-templates select="../../button[1]"/>   
      </td>      	     
    </tr>        	            	
  </table>    	  
</xsl:template>


<xsl:template match="ESTRUCTURA_PRODUCTOS">        
   <tr>
     <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0120' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>   
     <td colspan="3">
       <select name="LLP_CATEGORIA" size="5">
         <xsl:attribute name="onChange">refillFamilias(this.form,this.options[this.selectedIndex].value);</xsl:attribute>
         <option selected="selected" value="-1"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0240' and @lang=$lang]" disable-output-escaping="yes"/></option>
         <xsl:for-each select="CATEGORIA">
           <option>
             <xsl:attribute name="value"><xsl:value-of select="@ID"/></xsl:attribute>
             <xsl:value-of select="@NOMBRE"/>
           </option>
         </xsl:for-each>
       </select>
     </td>
   </tr>
   <tr>
     <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0130' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>   
     <td colspan="3">
       <select name="LLP_FAMILIA" size="6">
         <xsl:attribute name="onChange">refillSubfamilias(this.form,this.options[this.selectedIndex].value);</xsl:attribute>        
         <option selected="selected" value="-1"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0241' and @lang=$lang]" disable-output-escaping="yes"/></option>
       </select>
     </td> 
   </tr>
   <tr>
     <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0140' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>        
     <td colspan="3"> 
       <select name="LLP_SUBFAMILIA" size="12">        
         <option selected="selected" value="-1"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='LP-0242' and @lang=$lang]" disable-output-escaping="yes"/></option>
       </select>
     </td>
   </tr>   	
</xsl:template>

<xsl:template match="LLP_DESCRIPCION_LINEA">
 <input type="text" SIZE="53" name="LLP_DESCRIPCION_LINEA">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>

<xsl:template match="LLP_NOMBRE">
 <input type="text" size="27" name="LLP_NOMBRE">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>

<xsl:template match="LLP_DESCRIPCION">
 <input type="text" SIZE="71" name="LLP_DESCRIPCION">
 <xsl:attribute name="value">
  <xsl:value-of select="."/>
 </xsl:attribute>
 </input>
</xsl:template>

<xsl:template match="LLP_FABRICANTE">
 <input type="text" size="27" name="LLP_FABRICANTE"  value="{.}"/>
</xsl:template>

<xsl:template match="LLP_REFERENCIA">
 <input type="text" size="27" name="LLP_REFERENCIA"  value="{.}"/>
</xsl:template>

<xsl:template match="LLP_MARCA">
 <input type="text" size="27" name="LLP_MARCA" value="{.}"/>
</xsl:template>

<!-- Es un campo oculto porque queremos filtrar por el proveedor actual -->
<xsl:template match="LLP_PROVEEDOR">
 <input type="hidden" name="LLP_PROVEEDOR" value="{.}"/>
</xsl:template>
<xsl:template match="EMP_ID">
 <input type="hidden" name="EMP_ID" value="{.}"/>
</xsl:template>

<xsl:template match="LLP_PROV_HABITUALES">
  <input type="checkbox" name="LLP_PROV_HABITUALES">
  <xsl:choose>
    <xsl:when test=".='S'">
      <xsl:attribute name="checked">
      checked
      </xsl:attribute>
    </xsl:when>    
  </xsl:choose>      
  </input>
</xsl:template>

<xsl:template match="LLP_VALOR_CERTIFICACION">
  <input type="text" name="LLP_VALOR_CERTIFICACION" value="{.}"/>
</xsl:template>

  <xsl:template match="jumpTo">
    <xsl:variable name="code-img-on">DB-<xsl:value-of select="picture-on"/></xsl:variable>
    <xsl:variable name="code-img-off">DB-<xsl:value-of select="picture-off"/></xsl:variable> 
    <xsl:variable name="code-link"><xsl:value-of select="page"/></xsl:variable>   
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>    
    <xsl:variable name="link"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-link]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="code-status"><xsl:value-of select="status"/></xsl:variable>
    <xsl:variable name="status">
      <xsl:choose>
        <xsl:when test="status">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="code-alt"><xsl:value-of select="alt"/></xsl:variable>
    <xsl:variable name="alt">
      <xsl:choose>
        <xsl:when test="alt">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
	  <a>
	    <xsl:attribute name="href"><xsl:value-of select="$link"/>?LP_ID=<xsl:value-of select="../BuscForm/ROWSET/ROW/LLP_IDLISTA"/></xsl:attribute>
	    <xsl:attribute name="onMouseOver">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
	    <xsl:attribute name="onMouseOut">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
	    <img name="{picture-off}" alt="{$alt}" src="{$draw-off}" border="0"/>
          </a>
            <br/>
            <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>       
  </xsl:template>
</xsl:stylesheet>
