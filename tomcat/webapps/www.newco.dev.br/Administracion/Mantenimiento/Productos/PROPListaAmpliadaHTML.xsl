<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |   Copia de P3ListaHTML.xsl
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html> 
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
	<script type="text/javascript">
	  <!--      
        function LinkaPrivada(dir,f,prod){
          // Esta funcion todavia no esta activada
          var direcc = dir + '?';
          var f = window.document.forms[0];
          direcc += '&PRO_ID=' + prod;
          // Nos falta el codigo de empresa
          direcc += '&SALTAR=' + 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPLista.xsql';
          direcc += '&PRMEXTRA=(EMP_ID,'+f.elements['EMP_ID'].value+'),';
          direcc += '(LLP_CATEGORIA,'+f.elements['LLP_CATEGORIA'].value+'),';
          direcc += '(LLP_FAMILIA,'+f.elements['LLP_FAMILIA'].value+'),';
          direcc += '(LLP_SUBFAMILIA,'+f.elements['LLP_SUBFAMILIA'].value+'),';
          direcc += '(LLP_NOMBRE,'+f.elements['LLP_NOMBRE'].value+'),';
          direcc += '(LLP_MARCA,'+f.elements['LLP_MARCA'].value+'),';
          direcc += '(LLP_DESCRIPCION,'+f.elements['LLP_DESCRIPCION'].value+'),';
          direcc += '(LLP_FABRICANTE,'+f.elements['LLP_FABRICANTE'].value+'),';
          direcc += '(LLP_ORDERBY,'+f.elements['LLP_ORDERBY'].value+'),';
          direcc += '(ULTIMAPAGINA,'+f.elements['ULTIMAPAGINA'].value+'),';
          
          location.href = direcc;	
        }
        
	function LinkaPublica (dir,prod) {
          var direcc  = dir + '?';
          var f = window.document.forms[0];
          // Anyadimos las opciones
          direcc += '&PRO_ID=' + prod;
          direcc += '&EMP_ID=0';   
          direcc += '&SALTAR=' + 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPLista.xsql';
          direcc += '&PRMEXTRA=(EMP_ID,'+f.elements['EMP_ID'].value+'),';
          direcc += '(LLP_CATEGORIA,'+f.elements['LLP_CATEGORIA'].value+'),';
          direcc += '(LLP_FAMILIA,'+f.elements['LLP_FAMILIA'].value+'),';
          direcc += '(LLP_SUBFAMILIA,'+f.elements['LLP_SUBFAMILIA'].value+'),';
          direcc += '(LLP_NOMBRE,'+f.elements['LLP_NOMBRE'].value+'),';
          direcc += '(LLP_MARCA,'+f.elements['LLP_MARCA'].value+'),';
          direcc += '(LLP_DESCRIPCION,'+f.elements['LLP_DESCRIPCION'].value+'),';
          direcc += '(LLP_FABRICANTE,'+f.elements['LLP_FABRICANTE'].value+'),';
          direcc += '(LLP_ORDERBY,'+f.elements['LLP_ORDERBY'].value+'),';
          direcc += '(ULTIMAPAGINA,'+f.elements['ULTIMAPAGINA'].value+'),';

          location.href = direcc;	
	}
	  function Reduce_fichas(formu,NombreCampo){    
	        formu.elements['xml-stylesheet'].value="PROPListaHTML.xsl";
	        SubmitForm(formu);
	  }		
	  //-->
	</script>
        ]]></xsl:text>       
      </head>
      <body bgcolor="#EEFFFF">
        <xsl:choose>
          <xsl:when test="Lista/form/xsql-error">      
            <xsl:apply-templates select="Lista/form/xsql-error"/>          
          </xsl:when>
          <xsl:when test="Lista/form/Status">      
            <xsl:apply-templates select="Lista/form/Status"/>           
          </xsl:when>
          
          <xsl:when test="Lista/form/ROWSET/ROW/TooManyRows">       
            <p class="tituloPag">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0220' and @lang=$lang]" disable-output-escaping="yes"/>
              <hr/>
            </p>
            <p class="tituloForm">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0230' and @lang=$lang]" disable-output-escaping="yes"/>
            </p>            
            <form name="button" method="post">
              <center><br/>
                <xsl:apply-templates select="Lista/jumpTo"/>
              </center>
            </form>
          </xsl:when>

          <xsl:when test="Lista/form/ROWSET/ROW/NoDataFound">       
            <xsl:apply-templates select="Lista/form/ROWSET/ROW/NoDataFound"/>              
          </xsl:when>
                              
          <xsl:otherwise>
            <xsl:apply-templates select="Lista/form"/>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  

<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="form">               
    <!-- Formulario de datos -->
    <form>    
      <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>	
      <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>	   
      <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
      <input type="hidden" name="xml-stylesheet" value="{//xml-stylesheet}"/>
      
      <input type="hidden" name="EMP_ID" value="{EMP_ID}"/>
      <xsl:apply-templates select="LLP_CATEGORIA"/>
      <xsl:apply-templates select="LLP_FAMILIA"/>
      <xsl:apply-templates select="LLP_SUBFAMILIA"/>
      <xsl:apply-templates select="LLP_NOMBRE"/>
      <xsl:apply-templates select="LLP_MARCA"/>	  
      <xsl:apply-templates select="LLP_DESCRIPCION"/>
      <xsl:apply-templates select="LLP_FABRICANTE"/>
      <input type="hidden" name="LLP_TIPO_PRODUCTO" value="{LLP_TIPO_PRODUCTO}"/>
      <input type="hidden" name="LLP_REFERENCIA" value="{LLP_REFERENCIA}"/>
      
<!--      
      <xsl:apply-templates select="LLP_PROVEEDOR"/>
      <xsl:apply-templates select="LLP_HOMOLOGADO"/>	  
      <xsl:apply-templates select="LLP_CERTIFICACION"/>	  
      <xsl:apply-templates select="LLP_NIVEL_CALIDAD"/>	  
      <xsl:apply-templates select="LLP_PROV_HABITUALES"/>	
-->        

      <xsl:apply-templates select="LLP_ID"/>
      <xsl:apply-templates select="LP_ID"/>
      <xsl:apply-templates select="OPERACION"/>             
      <xsl:apply-templates select="TCV_ID"/>
      <xsl:apply-templates select="LLP_PRODUCTO_DETERMINADO"/>
      <xsl:apply-templates select="LLP_ORDERBY"/>
             	  
      <xsl:apply-templates select="ROWSET/CONTROLREGISTRES"/>
      <input type="hidden" name="REFERENCIACLIENTE"/>
      <input type="hidden" name="SELECCIONARTOTAL"/>                    	  	  
      <input type="hidden" name="ULTIMAPAGINA" value="{ROWSET/BUTTONS/ACTUAL/@PAG}"/>
      
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr align="center" valign="top">
          <td width="10%"><xsl:apply-templates select="ROWSET/BUTTONS/ATRAS"/></td>                    
          <td width="40%"><xsl:apply-templates select="button[@label='Reducidas']"/></td>                   
          <td width="40%"><xsl:apply-templates select="button[1]"/></td>                
          <td width="10%"><xsl:apply-templates select="ROWSET/BUTTONS/ADELANTE"/></td>            
        </tr>
      </table>
      <br/>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr valign="bottom">        
          <td align="right" class="tituloCamp">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0010' and @lang=$lang]" disable-output-escaping="yes"/> <xsl:value-of select="(ROWSET/BUTTONS/ACTUAL/@PAG)+1"/> <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0020' and @lang=$lang]" disable-output-escaping="yes"/> <xsl:value-of select="ROWSET/TOTAL_PAGINAS"/>
             | <xsl:value-of select="ROWSET/TOTAL_FILAS"/>
             <xsl:choose>
               <xsl:when test="ROWSET/TOTAL_FILAS[.>1]"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0030' and @lang=$lang]" disable-output-escaping="yes"/></xsl:when>
               <xsl:otherwise><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0040' and @lang=$lang]" disable-output-escaping="yes"/></xsl:otherwise></xsl:choose>
             <!-- | <xsl:value-of select="ROWSET/TOTAL_PROVEEDORES"/> 
             <xsl:choose>
               <xsl:when test="ROWSET/TOTAL_PROVEEDORES[.>1]">
                 <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0050' and @lang=$lang]" disable-output-escaping="yes"/></xsl:when>
                 <xsl:otherwise><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0060' and @lang=$lang]" disable-output-escaping="yes"/></xsl:otherwise></xsl:choose>
              -->   
                 </td></tr></table>
      <br/>            
      <xsl:for-each select="ROWSET/ROW">
        <xsl:apply-templates select="."/>       
      </xsl:for-each>      
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr align="center" valign="top">
          <td width="10%"><xsl:apply-templates select="ROWSET/BUTTONS/ATRAS"/></td>                     
          <td width="40%"><xsl:apply-templates select="button[@label='Reducidas']"/></td>                   
          <td width="40%"><xsl:apply-templates select="button[1]"/></td>                 
          <td width="10%"><xsl:apply-templates select="ROWSET/BUTTONS/ADELANTE"/></td>            
        </tr>
      </table>
    </form> 
</xsl:template>

<xsl:template match="ROW">
  <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0" >		
    <tr bgcolor="#A0D8D7"><td colspan="4">   
      <table width="100%" align="center" border="0" cellspacing="0" cellpadding="5">
        <tr valign="middle">
	  <td width="10%">
	    <xsl:apply-templates select="PRO_ENLACE"/>
	  </td>
	  <td><p class="tituloCamp">  
	    <xsl:apply-templates select="PRO_NOMBRE"/></p></td>
	  <td align="right" width="25%"><p class="tituloCamp">
	    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0490' and @lang=$lang]" disable-output-escaping="yes"/>        
	    </p></td>
	  <td align="right" width="10%">
	    <!-- Tarifas Publicas -->
	    <xsl:variable name="CodProdAct" select="PRO_ID"/>
	    <xsl:apply-templates select="../../buttonPublicaPrivada[1]"/>
	    </td> 
	  <!--<xsl:choose>
	  <xsl:when test="../../buttonPublicaPrivada[2]">
        	  <td align="right"><p class="tituloCamp">
        	    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0500' and @lang=$lang]" disable-output-escaping="yes"/>        
        	    </p></td>
        	  <td>-->
        	    <!-- Tarifas Privadas -->	  
        	    <!--<xsl:variable name="CodProdAct" select="PRO_ID"/>	    
        	    <xsl:apply-templates select="../../buttonPublicaPrivada[2]"/>
        	    </td>
	   </xsl:when>
	   <xsl:otherwise>
	        <td><td/>
	   </xsl:otherwise>
	   </xsl:choose>-->
        </tr>
      </table>
      </td></tr>	
    <tr> 
      <td width="25%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0390' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td width="25%">  
        <xsl:apply-templates select="REFERENCIA_PROVEEDOR"/></td>      
      <td width="20%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0400' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td width="30%">  
        <xsl:apply-templates select="REFERENCIA_CLIENTE"/></td>      
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0240' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td colspan="3">  
        <xsl:apply-templates select="NOM_NOMBRECOMPLETO"/></td>      
    </tr>       
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0190' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td colspan="3">  
        <xsl:apply-templates select="PROVEEDOR"/></td>      
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0170' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_FABRICANTE"/></td>      
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0180' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_MARCA"/></td>      
    </tr>    	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0160' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td colspan="3">  
        <xsl:apply-templates select="PRO_DESCRIPCION"/></td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0220' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_UNIDADBASICA"/></td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0235' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_UNIDADESPORLOTE"/></td> 
    </tr>    
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0210' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_HOMOLOGADO"/></td>
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0200' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_CERTIFICADOS"/></td>      
    </tr>
    <xsl:if test="TARIFAS/TARIFAS_ROW">    
    <tr>
      <td colspan="4" align="center">
        <table width="95%" border="0" cellpadding="0" cellspacing="0" bgcolor="#A0D8D7">
	  <tr bgcolor="CCCCCC">
	    <td><p class="tituloCamp">
	      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0360' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
	    <td align="right"><p class="tituloCamp">
	      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0370' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
	    <td align="right"><p class="tituloCamp">    
	      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0380' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
	    <td><p class="tituloCamp">    
	      &nbsp;<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0385' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
	    <td align="right"><p class="tituloCamp">
	      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0520' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
	  </tr>
	  <xsl:for-each select="TARIFAS/TARIFAS_ROW">
	  <tr>
	    <td>&nbsp;</td>	  
	    <td align="right">
	      <p>
	      <xsl:attribute name="style">
	        <xsl:if test="../@COL='PUB'">color='red'</xsl:if>
		<xsl:if test="../@COL='PRV'">color='blue'</xsl:if>	        
	      </xsl:attribute>	      	    
	      <xsl:value-of select="TRF_CANTIDAD"/>
	      </p></td>
	    <td align="right">
	      <p>
	      <xsl:attribute name="style">
	        <xsl:if test="../@COL='PUB'">color='red'</xsl:if>
		<xsl:if test="../@COL='PRV'">color='blue'</xsl:if>	        
	      </xsl:attribute>	      	    
	      <xsl:value-of select="DIV_PREFIJO"/><xsl:value-of select="TRF_IMPORTE"/>
	      </p></td>
	    <td>
	      <p>
	      <xsl:attribute name="style">
	        <xsl:if test="../@COL='PUB'">color='red'</xsl:if>
		<xsl:if test="../@COL='PRV'">color='blue'</xsl:if>	        
	      </xsl:attribute>	      	    
	      &nbsp;<xsl:value-of select="DIV_SUFIJO"/>
	      </p></td>
	    <td align="right"><xsl:value-of select="../../PRO_TIPOIVA"/></td>	      
	  </tr>
	  </xsl:for-each>
        </table>
      </td>
    </tr></xsl:if>
    <tr bgcolor="#EEFFFF"><td colspan="4"><br/></td></tr>        	
  </table>
</xsl:template>   	 

<xsl:template match="PRO_NOMBRE">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="NOM_NOMBRECOMPLETO">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="PRO_REFERENCIA">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="PROVEEDOR">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="PRO_FABRICANTE">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="PRO_MARCA">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="PRO_DESCRIPCION">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="PRO_HOMOLOGADO"> 
  <input type="checkbox" name="HOMOLOGADO" disabled="disabled">
  <xsl:choose>
    <xsl:when test=".=1">
      <xsl:attribute name="checked">checked</xsl:attribute>
    </xsl:when>    
  </xsl:choose>      
  </input>
</xsl:template>

<xsl:template match="PRO_CERTIFICADOS">  
    <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="PRO_UNIDADBASICA">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="PRO_UNIDADESPORLOTE">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="PRO_IMAGEN">
  <a class="tituloCamp"><xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0340' and @lang=$lang]" disable-output-escaping="yes"/></a>
</xsl:template>

<xsl:template match="PRO_ENLACE">
  <a class="tituloCamp">
    <xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
    <img>
      <xsl:attribute name="src"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='DB-005' and @lang=$lang]" disable-output-escaping="yes"/></xsl:attribute>
    </img>  
  </a>
</xsl:template>


<!--
  Modificamos el template boton anyadiendo el parametro PRO_ID al final de 
  la llamada a la funcion Javascript.
+-->

<xsl:template match="buttonPublicaPrivada">
    <xsl:variable name="code-img-on">DB-<xsl:value-of select="@label"/>_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-<xsl:value-of select="@label"/></xsl:variable>    
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="code-status"><xsl:value-of select="@status"/></xsl:variable>
    <xsl:variable name="code-status"><xsl:value-of select="@status"/></xsl:variable>
    <xsl:variable name="status">
      <xsl:choose>
        <xsl:when test="@status">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="code-alt"><xsl:value-of select="alt"/></xsl:variable>
    <xsl:variable name="alt">
      <xsl:choose>
        <xsl:when test="@alt">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>	  
    <a>
	      <xsl:attribute name="href">javascript:<xsl:value-of select="name_function"/>(<xsl:for-each select="param">
	          <xsl:choose>
	            <xsl:when test="not(position()=last()) or (../param_msg)"><xsl:value-of select="."/>,</xsl:when>
	            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
	          </xsl:choose>
	          </xsl:for-each>
	          <xsl:for-each select="param_msg">
	          <xsl:choose>
	            <xsl:when test="not(position()=last())"><xsl:value-of select="."/>,</xsl:when>
	            <xsl:otherwise><xsl:variable name="msg"><xsl:value-of select="."/></xsl:variable>'<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$msg and @lang=$lang]" disable-output-escaping="yes"/>'</xsl:otherwise>
	          </xsl:choose>	          
	        </xsl:for-each>,'<xsl:value-of select="$CodProdAct"/>');</xsl:attribute>	  
	    <img name="{@label}" src="{$draw-off}" border="0" alt="{$alt}"/>
          </a>
          <br/>
          <xsl:choose>
            <xsl:when test="@text"><xsl:value-of select="@text"/></xsl:when>
            <xsl:when test="@caption">
              <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
            </xsl:when>           
          </xsl:choose>
</xsl:template>


<!--CAMPS OCULTS-->

<xsl:template match="LLP_CATEGORIA">
  <input type="hidden" name="LLP_CATEGORIA"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_FAMILIA">
  <input type="hidden" name="LLP_FAMILIA"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_SUBFAMILIA">
  <input type="hidden" name="LLP_SUBFAMILIA"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_NOMBRE">
  <input type="hidden" name="LLP_NOMBRE"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_DESCRIPCION">
  <input type="hidden" name="LLP_DESCRIPCION"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_FABRICANTE">
  <input type="hidden" name="LLP_FABRICANTE"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_MARCA">
  <input type="hidden" name="LLP_MARCA"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_PROVEEDOR">
  <input type="hidden" name="LLP_PROVEEDOR"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_HOMOLOGADO">
  <input type="hidden" name="LLP_HOMOLOGADO"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_CERTIFICACION">
  <input type="hidden" name="LLP_CERTIFICACION"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_NIVEL_CALIDAD">
  <input type="hidden" name="LLP_NIVEL_CALIDAD"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_PROV_HABITUALES">
  <input type="hidden" name="LLP_PROV_HABITUALES"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_ID">
  <input type="hidden" name="LLP_ID"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LP_ID">
  <input type="hidden" name="LP_ID"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="OPERACION">
  <input type="hidden" name="OPERACION"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="TCV_ID">
  <input type="hidden" name="TCV_ID"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_ORDERBY">
  <input type="hidden" name="LLP_ORDERBY"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="CONTROLREGISTRES">
  <input type="hidden" name="CONTROLREGISTRES"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="REGISTROSPORPAGINA">
  <input type="hidden" name="REGISTROSPORPAGINA"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_PRODUCTO_DETERMINADO">
  <input type="hidden" name="LLP_PRODUCTO_DETERMINADO"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_NIVEL_CALIDAD">
  <input type="hidden" name="LLP_NIVEL_CALIDAD"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_PROV_HABITUALES">
  <input type="hidden" name="LLP_PROV_HABITUALES"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>
 
</xsl:stylesheet>
