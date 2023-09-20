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

	<!--style-->
	<xsl:call-template name="estiloIndip"/>
	<!--fin de style-->
      
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
	<script type="text/javascript">
	  <!--      
	 /* 
        function LinkaPrivada(dir,f,prod){
          // Esta funcion todavia no esta activada
          var direcc = dir + '?';
          var f = window.document.forms[0];
          direcc += '&PRO_ID=' + prod;
          // Nos falta el codigo de empresa
          direcc += '&SALTAR=' + 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPLista.xsql';
          direcc += '&PRMEXTRA='+agrupaArrayHiddens();
          //direcc += '(LLP_CATEGORIA,'+f.elements['LLP_CATEGORIA'].value+'),';
          //direcc += '(LLP_FAMILIA,'+f.elements['LLP_FAMILIA'].value+'),';
          //direcc += '(LLP_SUBFAMILIA,'+f.elements['LLP_SUBFAMILIA'].value+'),';
          //direcc += '(LLP_NOMBRE,'+f.elements['LLP_NOMBRE'].value+'),';
          //direcc += '(LLP_MARCA,'+f.elements['LLP_MARCA'].value+'),';
          //direcc += '(LLP_DESCRIPCION,'+f.elements['LLP_DESCRIPCION'].value+'),';
          //direcc += '(LLP_FABRICANTE,'+f.elements['LLP_FABRICANTE'].value+'),';
          //direcc += '(LLP_ORDERBY,'+f.elements['LLP_ORDERBY'].value+'),';
          //direcc += '(ULTIMAPAGINA,'+f.elements['ULTIMAPAGINA'].value+'),';
          
          location.href = direcc;	
        }
        */
        
	function LinkaPublica (dir,prod) {//pagina a la que se llama y cod_prod
          var direcc  = dir + '?';
          var f = window.document.forms[0];
          // Anyadimos las opciones
          direcc += '&PRO_ID=' + prod;
          direcc += '&EMP_ID=0';
          direcc += '&SALTAR=' + 'http://www.newco.dev.br/Administracion/Mantenimiento/Productos/PROPLista.xsql';
          direcc += '&PRMEXTRA='+ agrupaArrayHiddens(f.elements['EMP_ID'].value);
          //direcc += '(LLP_CATEGORIA,'+f.elements['LLP_CATEGORIA'].value+'),';
          //direcc += '(LLP_FAMILIA,'+f.elements['LLP_FAMILIA'].value+'),';
          //direcc += '(LLP_SUBFAMILIA,'+f.elements['LLP_SUBFAMILIA'].value+'),';
          //direcc += '(LLP_NOMBRE,'+f.elements['LLP_NOMBRE'].value+'),';
          //direcc += '(LLP_MARCA,'+f.elements['LLP_MARCA'].value+'),';
          //direcc += '(LLP_DESCRIPCION,'+f.elements['LLP_DESCRIPCION'].value+'),';
          //direcc += '(LLP_FABRICANTE,'+f.elements['LLP_FABRICANTE'].value+'),';
          //direcc += '(LLP_ORDERBY,'+f.elements['LLP_ORDERBY'].value+'),';
          //direcc += '(ULTIMAPAGINA,'+f.elements['ULTIMAPAGINA'].value+'),';
          
          //direcc=la direccion y toda la ristra de parametros
          //saltar =es la pagina de retorno
          location.href = direcc;	
	}
	  function Amplia_fichas(formu){
		formu.elements['xml-stylesheet'].value="PROPListaAmpliadaHTML.xsl";
		SubmitForm(formu);
	  }

        var producto = null;	  
       /*
        function MostrarPag(pag){
          if (is_nav){
            ample=parseInt(window.outerWidth*80/100)-50;
            alcada=parseInt(window.innerHeight-23)-50;
            alt=parseInt(window.parent.innerHeight+18)-parseInt(window.innerHeight)+25;
            esquerra = parseInt(window.outerWidth*18/100)+25;
            if (producto && producto.open){
              producto.close();            
            }
            producto=window.open(pag,'procesoVenta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
          }else{
            ample = window.screen.availWidth-window.screenLeft-15-50;
            alcada = document.body.offsetHeight-27-50;
            esquerra = window.screenLeft+25;
            alt = window.screenTop+25;
            if (producto && producto.open && !producto.closed) producto.close();
	    producto=window.open(pag,'procesoVenta','toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
          }
        }
	  */
	function ReordenarConsulta ( sel ) {
	 var neworder;
	 var selelem = sel.options[sel.selectedIndex].value;
 
	   if (sel.name == 'CEmpresas') {
		neworder = 'PROV: '+selelem;		
	   }
	   if (sel.name == 'CNomenclator') {
		neworder = 'NOME: '+selelem;		
	   }
	   
	   //alert('Combo:'+sel.name+' Valor:'+selelem+' neworder:'+neworder);
	   
	   sel.form.elements['LLP_ORDERBY'].value = neworder;
	   sel.form.elements['ULTIMAPAGINA'].value = 0;
	   
	   Navega(sel.form,'0');	   
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
          <td width="40%"><xsl:apply-templates select="button[@label='Ampliadas']"/></td>                   
          <td width="40%"><xsl:apply-templates select="button[1]"/></td>                 
          <td width="10%"><xsl:apply-templates select="ROWSET/BUTTONS/ADELANTE"/></td>            
        </tr>
      </table>
      <br/>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr valign="bottom">        
          <td align="right" class="textoBuscador">
            hhhh <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0010' and @lang=$lang]" disable-output-escaping="yes"/> <span class="textoForm"><xsl:value-of select="(ROWSET/BUTTONS/ACTUAL/@PAG)+1"/></span> <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0020' and @lang=$lang]" disable-output-escaping="yes"/> <span class="textoForm"><xsl:value-of select="ROWSET/TOTALES/TOTAL_PAGINAS"/></span>
             &nbsp;&nbsp;|&nbsp;&nbsp; <span class="textoForm"><xsl:value-of select="ROWSET/TOTALES/TOTAL_FILAS"/></span>
             <xsl:choose>
               <xsl:when test="ROWSET/TOTALES/TOTAL_FILAS[.>1]"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0030' and @lang=$lang]" disable-output-escaping="yes"/>
               </xsl:when>
               <xsl:otherwise><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0040' and @lang=$lang]" disable-output-escaping="yes"/>
               </xsl:otherwise>
               </xsl:choose>
             <!-- | <xsl:value-of select="ROWSET/TOTAL_PROVEEDORES"/> 
             <xsl:choose>
               <xsl:when test="ROWSET/TOTAL_PROVEEDORES[.>1]">
                 <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0050' and @lang=$lang]" disable-output-escaping="yes"/></xsl:when>
                 <xsl:otherwise><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0060' and @lang=$lang]" disable-output-escaping="yes"/></xsl:otherwise></xsl:choose>
             --></td>
         </tr>
         <tr valign="bottom">
           <td align="right">
             <!-- nacho 13/12/2001 declaro la variable si no, casca el template -->
             <xsl:variable name="IDAct">nulo</xsl:variable>
             <xsl:apply-templates select="ROWSET/field_plus[@name='CNomenclator']"/>
           </td>
         </tr>
      
      </table>
      <br/>
      <table width="100%" border="1" align="center" cellpadding="2" cellspacing="0" >
        <tr bgcolor="#A0D8D7">
          <td width="10%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0145' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
          <td width="35%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0150' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
          <td width="15%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0190' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
          <td width="5%" align="right"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0375' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
          <td width="5%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0235' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
          <td width="10%" align="center" colspan="2"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0380' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
          <td width="5%" align="center"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0491' and @lang=$lang]" disable-output-escaping="yes"/></p></td>          
          <td width="5%" align="center"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0520' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
          
        </tr>     
        <xsl:apply-templates select="ROWSET/ROW"/>
      </table>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr align="center" valign="top">
          <td width="10%"><xsl:apply-templates select="ROWSET/BUTTONS/ATRAS"/></td>                     
          <td width="40%"><xsl:apply-templates select="button[@label='Ampliadas']"/></td>                   
          <td width="40%"><xsl:apply-templates select="button[1]"/></td>                
          <td width="10%"><xsl:apply-templates select="ROWSET/BUTTONS/ADELANTE"/></td>            
        </tr>
      </table>
    </form> 
</xsl:template>

<xsl:template match="ROW">
        <tr valign="top">
          <td>
	    <xsl:apply-templates select="REFERENCIA_PROVEEDOR"/>&nbsp;</td>
          
	  <td><a class="tituloCamp" onmouseover="window.status=' ';return true" onmouseup="window.status=' ';return true" onmousedown="window.status=' ';return true">  
	    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>','producto',70,50,0,-50);</xsl:attribute>
	    <xsl:apply-templates select="PRO_NOMBRE"/></a>&nbsp;</td>
          <td>  
            <xsl:apply-templates select="PROVEEDOR"/>&nbsp;</td> 
	  <td align="right">	      	    
	     <xsl:apply-templates select="PRO_UNIDADBASICA"/>&nbsp;
	  </td>
	  <td align="right">	      	    
	     <xsl:value-of select="PRO_UNIDADESPORLOTE"/>&nbsp;
	  </td>
	  <td align="right" colspan="2">      	    
	     <xsl:value-of select="DIV_PREFIJO"/><xsl:value-of select="TARIFAS/TARIFAS_ROW/TRF_IMPORTE[1]"/>
	    &nbsp;<xsl:value-of select="TARIFAS/TARIFAS_ROW/DIV_SUFIJO[1]"/>
	  </td>
	  <td align="center">
	    <!-- Tarifas Publicas -->
	    <xsl:variable name="CodProdAct" select="PRO_ID"/>
	    <xsl:apply-templates select="../../buttonPublicaPrivada[@label='PrecioPeq']"/>
	    </td>	  
	  <td align="right">
	    <xsl:value-of select="PRO_TIPOIVA"/>&nbsp;
	  </td>
	</tr>
</xsl:template> 	

<xsl:template match="PRO_NOMBRE">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="NOM_NOMBRECOMPLETO">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="PRO_REFERENCIA">
  <xsl:value-of select="." />
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
