<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: P3ListaHTML.xsl
 | Autor.........: Montse
 | Fecha.........: 
 | Descripcion...: Devuelve una lista de productos con todas las informaciones sobre el producto ("Fichas Ampliadas")
 | Funcionamiento: 
 
       |   CUIDADO: Los cambios en campos ocultos se deben copiar en:
       |	 P3EmpresasHTML.xsl
       |	 P3NomenclatorHTML.xsl
       |	 P3ListaHTML.xsl
       |	 P1ListaHTML.xsl
       |	 LLPMantenSaveHTML.xsl
       
 |
 |Modificaciones: 
 |   Fecha: 22/06/2001      Autor: Olivier Jean         Modificacion: presentacion, botones
 |   Fecha: 26/06/2001      Autor: Olivier Jean         Modificacion: supresion de la MULTIOERTA, cambio hacia la OFERTA  |
 |   Fecha: 03/07/2001      Autor: Olivier Jean         Modificacion: Añadir combos Nomenclator + Proveedores
 |
 | Situacion: __Normal__
 |
 |(c) 2001 MedicalVM
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html> 
      <head>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	  <![CDATA[<!--]]>
	  var SeleccionePredet   ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0360' and @lang=$lang]" disable-output-escaping="yes"/>';
	  var UnidadesNoValidas  ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0290'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  var IntrodeceNumLotes  ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0370' and @lang=$lang]" disable-output-escaping="yes"/>';
	  var LaReferencia	 ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0315'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  var EsCorrecta	 ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0320'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  var AsigneReferencia   ='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0300'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  var SeleccionAutomatica='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0510'  and @lang=$lang]" disable-output-escaping="yes"/>';
	  <![CDATA[//-->]]>
	</script>
	<script type="text/javascript" src="http://www.newco.dev.br/Compras/Multioferta/Lista.js">
	</script>
	<script type="text/javascript">
	  <![CDATA[<!--]]>
	  <![CDATA[
	  
	  //
	  //Cambiamos el xml-stylesheet a P1ListaHTML.xsl
	  //Llamamos a la funcion ValidaCampos.	  	 
	  // 	  
	  function Reduce_fichas(formu,NombreCampo){
	    if(ValidaCampos(formu,NombreCampo)){
	      // Actualizo campo hidden LLP_PRODUCTO_DETERMINADO con el valor seleccionado.
	      for(i=0; i<formu.elements.length; i++){
                if (formu.elements[i].type=="radio" && formu.elements[i].checked==true){	    
	          formu.elements['LLP_PRODUCTO_DETERMINADO'].value=formu.elements[i].value;
	        }
	      }	      
	      // Hago submit si hay alguna seleccion
	      if (validaCheckyCantidadSin(formu,'PRO_PREDETERMINADO','CANTIDAD_UNI',IntrodeceNumLotes)){
	        formu.elements['xml-stylesheet'].value="P1ListaHTML.xsl";
	        SubmitForm(formu);
	      }	    
	    }
	  }
	 ]]>
	<![CDATA[//-->]]>
	</script>
        </head>
      <body bgcolor="#FFFFFF">
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
            <div align="center">
              <br/><xsl:apply-templates select="Lista/jumpTo"/>
            </div>
          </xsl:when>	  
	  <xsl:when test="Lista/form/ROWSET/ROW/NoDataFound">
	    <xsl:apply-templates select="Lista/form/ROWSET/ROW/NoDataFound"/>
	  </xsl:when>	                               
          <xsl:otherwise>
            <xsl:attribute name="onLoad">window.status='';Selecciona(document.forms[0],'<xsl:value-of select="Lista/form/LLP_PRODUCTO_DETERMINADO"/>');loadLotesAUnidades();</xsl:attribute>          
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
      
      <input type="hidden" name="xml-stylesheet" value="{../xml-stylesheet}"/>
      
      <!--
       |   CUIDADO: Los cambios en campos ocultos se deben copiar en:
       |	 P3EmpresasHTML.xsl
       |	 P3NomenclatorHTML.xsl
       |	 P3ListaHTML.xsl
       |	 P1ListaHTML.xsl
       |	 LLPMantenSaveHTML.xsl
       +--> 
      
      <xsl:apply-templates select="LLP_CATEGORIA"/>
      <xsl:apply-templates select="LLP_FAMILIA"/>
      <xsl:apply-templates select="LLP_SUBFAMILIA"/>
      <xsl:apply-templates select="LLP_NOMBRE"/>
      <xsl:apply-templates select="LLP_MARCA"/>	  
      <xsl:apply-templates select="LLP_DESCRIPCION"/>
      <xsl:apply-templates select="LLP_FABRICANTE"/>
      <xsl:apply-templates select="LLP_PROVEEDOR"/>
      <xsl:apply-templates select="LLP_HOMOLOGADO"/>	  
      <xsl:apply-templates select="LLP_CERTIFICACION"/>	  
      <xsl:apply-templates select="LLP_NIVEL_CALIDAD"/>	  
      <xsl:apply-templates select="LLP_TIPO_PRODUCTO"/>	        
      <xsl:apply-templates select="LLP_PROV_HABITUALES"/>	  

      <xsl:apply-templates select="LLP_ID"/>
      <xsl:apply-templates select="LP_ID"/>
      <xsl:apply-templates select="OPERACION"/>             
      <xsl:apply-templates select="TCV_ID"/>
      <xsl:apply-templates select="LLP_PRODUCTO_DETERMINADO"/>
      <input type="hidden" name="LLP_ORDERBY" value="{LLP_ORDERBY}"/>      
      <input type="hidden" name="TIPO_BUSQUEDA" value="{TIPO_BUSQUEDA}"/>            
      <xsl:apply-templates select="LLP_PRODUCTO_AUTOMATICO"/>       	  
      <xsl:apply-templates select="ROWSET/CONTROLREGISTRES"/>
      <input type="hidden" name="LLP_IDESPECIALIDAD" value="{LLP_IDESPECIALIDAD}"/>            
      
      <input type="hidden" name="LLP_VARIAS_LINEAS"/>      
      <input type="hidden" name="LLP_REFERENCIA_CLIENTE" value="{LLP_REFERENCIA_CLIENTE}"/>
      <input type="hidden" name="LLP_REFERENCIA_PROVEEDOR" value="{LLP_REFERENCIA_PROVEEDOR}"/>            
      
      <input type="hidden" name="REFERENCIACLIENTE"/> <!-- Variable donde almacenamos el código que el cliente quiere asignar -->
      <input type="hidden" name="SELECCIONARTOTAL"/>                    	  	  
      <input type="hidden" name="ULTIMAPAGINA" value="{ROWSET/BUTTONS/ACTUAL/@PAG}"/>
      <input type="hidden" name="EMPRESATOTAL" value="{EMPRESATOTAL}"/> <!-- Empresas seleccionadas, separadas por comas -->
      
      

      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr align="center" valign="top">
          <td width="10%" align="left">
            <xsl:choose>
              <xsl:when test="ROWSET/BUTTONS/ATRAS">
                <xsl:apply-templates select="ROWSET/BUTTONS/ATRAS"/>
              </xsl:when>
              <xsl:otherwise>&nbsp;
              </xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="20%"align="center"><img align="rigth" src="{ROWSET/BUTTONS/BANNERS/BANNERS_ROW/BN_LOCATION}" alt="{ROWSET/BUTTONS/BANNERS/BANNERS_ROW/BN_TEXTO_ALTERNATIVO}"/></td>          
          <td width="20%" align="center"><xsl:apply-templates select="button[@label='Insertar']"/></td>
          <td width="20%" align="center"><xsl:apply-templates select="button[@label='Reducidas']"/></td>
          <td width="20%"align="center"><img align="rigth" src="{ROWSET/BUTTONS/BANNERS/BANNERS_ROW/BN_LOCATION}" alt="{ROWSET/BUTTONS/BANNERS/BANNERS_ROW/BN_TEXTO_ALTERNATIVO}"/></td>              
          <td width="10%" align="right"><xsl:choose>
              <xsl:when test="ROWSET/BUTTONS/ADELANTE">
                <xsl:apply-templates select="ROWSET/BUTTONS/ADELANTE"/>
              </xsl:when>
              <xsl:otherwise>&nbsp;
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </table>
   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <xsl:if test="ROWSET/TOTALES">	      
      <tr>
        <td align="left" width="30%">
           <!-- nacho 13/12/2001 declaro la variable si no, casca el template -->
           <xsl:variable name="IDAct">nulo</xsl:variable>
           <xsl:apply-templates select="ROWSET/field_plus[@name='CEmpresas']"/>
         </td>
	 <td align="right" class="textoBuscador" width="50%" colspan="2">
	 <!--
           <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0010' and @lang=$lang]" disable-output-escaping="yes"/>
           <span class="textoForm"><xsl:value-of select="(ROWSET/BUTTONS/ACTUAL/@PAG)+1"/></span>
           <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0020' and @lang=$lang]" disable-output-escaping="yes"/> 
           <span class="textoForm"><xsl:value-of select="ROWSET/TOTALES/TOTAL_PAGINAS"/></span>
           <b>&nbsp;&nbsp;|&nbsp;&nbsp;</b>
           <span class="textoForm"><xsl:value-of select="ROWSET/TOTALES/TOTAL_FILAS"/></span>
           <xsl:choose>
             <xsl:when test="ROWSET/TOTALES/TOTAL_FILAS[.>1]">
               <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0030' and @lang=$lang]" disable-output-escaping="yes"/>
             </xsl:when>             
             <xsl:otherwise>
               <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0040' and @lang=$lang]" disable-output-escaping="yes"/>
             </xsl:otherwise>
           </xsl:choose>
           <xsl:variable name="IDAct">nulo</xsl:variable>
           -->
         </td>
         <td width="*">
           &nbsp;
         </td>
      </tr>
    </xsl:if>
      <tr valign="bottom">
         <td align="left" colspan="4">
           <xsl:variable name="IDAct">nulo</xsl:variable>
           <xsl:apply-templates select="ROWSET/field_plus[@name='CNomenclator']"/>
         </td>
      </tr>
      <tr valign="bottom">
        <td aling="left" width="30%">
          <xsl:variable name="IDAct">nulo</xsl:variable>
          <xsl:if test="ROWSET/field_plus[@name='CMarcas']">
            <xsl:variable name="IDAct">nulo</xsl:variable>
            <xsl:apply-templates select="ROWSET/field_plus[@name='CMarcas']"/>
          </xsl:if>
        </td>
        <td  width="20%" align="center" valign="bottom" rowspan="2">
          <br/>
          <xsl:apply-templates select="button[@label='BuscarFino']"/>
        </td>
        <td  width="20%" align="center" valign="bottom" rowspan="2">
          <br/>
          <xsl:apply-templates select="button[@label='Proveedores']"/>
        </td>
        <td width="*" rowspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td align="left" width="30%">
          <xsl:variable name="IDAct">nulo</xsl:variable>
          <xsl:apply-templates select="ROWSET/field_plus[@name='CSeleccionados']"/>
         </td>
      </tr> 
    </table>
    <br/><br/>
    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
      <tr>
        <td class="textoBuscador" align="right">
          <!-- Pagina 1 de 10 -->
           <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0010' and @lang=$lang]" disable-output-escaping="yes"/>
           <span class="textoForm"><xsl:value-of select="(ROWSET/BUTTONS/ACTUAL/@PAG)+1"/></span>
           <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0020' and @lang=$lang]" disable-output-escaping="yes"/> 
           <span class="textoForm"><xsl:value-of select="ROWSET/TOTALES/TOTAL_PAGINAS"/></span>
           <b>&nbsp;&nbsp;|&nbsp;&nbsp;</b>
           <!-- 100 Productos -->
           <span class="textoForm"><xsl:value-of select="ROWSET/TOTALES/TOTAL_FILAS"/></span>
           <xsl:choose>
             <xsl:when test="ROWSET/TOTALES/TOTAL_FILAS[.>1]">
               <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0030' and @lang=$lang]" disable-output-escaping="yes"/>
             </xsl:when>             
             <xsl:otherwise>
               <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0040' and @lang=$lang]" disable-output-escaping="yes"/>
             </xsl:otherwise>
           </xsl:choose>
           <!-- 30 Proveedores -->
           <!-- <xsl:value-of select="ROWSET/TOTALES/TOTAL_PROVEEDORES"/> -->
           <xsl:variable name="IDAct">nulo</xsl:variable>
        </td>
      </tr> 
    </table>    
     <br/>
      <table width="100%" border="0" bgcolor="#A0D8D7" align="center" cellpadding="3" cellspacing="0">
      <tr><td><xsl:for-each select="ROWSET/ROW">
        <xsl:apply-templates select="."/>       
      </xsl:for-each></td></tr>
      </table> 
     <br/>
           
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr align="center" valign="top">
          <td width="10%" align="left">
            <xsl:choose>
              <xsl:when test="ROWSET/BUTTONS/ATRAS">
                <xsl:apply-templates select="ROWSET/BUTTONS/ATRAS"/>
              </xsl:when>
              <xsl:otherwise>&nbsp;
              </xsl:otherwise>
            </xsl:choose>
          </td> 
          <td width="30%"align="center"><img align="rigth" src="{ROWSET/BUTTONS/BANNERS/BANNERS_ROW/BN_LOCATION}" alt="{ROWSET/BUTTONS/BANNERS/BANNERS_ROW/BN_TEXTO_ALTERNATIVO}"/></td>          
          <td width="20%" align="center"><xsl:apply-templates select="button[@label='Insertar']"/></td>
          <td width="30%"align="center"><img align="rigth" src="{ROWSET/BUTTONS/BANNERS/BANNERS_ROW/BN_LOCATION}" alt="{ROWSET/BUTTONS/BANNERS/BANNERS_ROW/BN_TEXTO_ALTERNATIVO}"/></td>             
          <td width="10%" align="right"><xsl:choose>
              <xsl:when test="ROWSET/BUTTONS/ADELANTE">
                <xsl:apply-templates select="ROWSET/BUTTONS/ADELANTE"/>
              </xsl:when>
              <xsl:otherwise>&nbsp;
              </xsl:otherwise>
            </xsl:choose>
          </td>         
        </tr>
      </table>
    </form> 
</xsl:template>

<xsl:template match="ROW">
  <table bgcolor="#EEFFFF" width="100%" align="center" border="0" cellspacing="0" cellpadding="0" valign="top">		
    <tr bgcolor="#A0D8D7"><td colspan="4">   
      <table width="100%" align="center" border="0" cellspacing="0" cellpadding="5">
        <tr>
	  <td valign="top" width="56%" align="left"><a class="tituloCamp" onmouseover="window.status=' ';return true">  
	    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="PRO_ID"/>','producto',70,50,0,-50);</xsl:attribute>
	    <xsl:apply-templates select="PRO_NOMBRE"/></a>
	  </td>
	  <td width="3%" align="center"><xsl:apply-templates select="../../button[@label='EditarPeq']"/></td>
	  <td valign="top" width="20%">
	    <!--<input type="hidden">
	      <xsl:attribute name="name">CANTIDAD<xsl:value-of select="PRO_ID"/></xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select="SELECCIONADO/CANTIDAD"/></xsl:attribute>             	        
            </input>-->
	    <input type="hidden">
	      <xsl:attribute name="name">UNIDADES_POR_LOTE<xsl:value-of select="PRO_ID"/></xsl:attribute>
              <xsl:attribute name="value"><xsl:value-of select="PRO_UNIDADESPORLOTE"/></xsl:attribute>             	        
            </input>	    
	    <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0420' and @lang=$lang]" disable-output-escaping="yes"/>	    
	    <input type="text" size="7" maxlength="7">
	      <xsl:attribute name="OnChange">UnidadesALotes(this.value,'<xsl:value-of select="PRO_UNIDADESPORLOTE"/>',this);alineaCelda(this);</xsl:attribute>
	      <xsl:attribute name="name">CANTIDAD_UNI<xsl:value-of select="PRO_ID"/></xsl:attribute>       
	      <xsl:attribute name="value"><xsl:value-of select="SELECCIONADO/CANTIDAD"/></xsl:attribute>
	    </input>
	    <input type="hidden">
	      <xsl:attribute name="name">NOMBRE<xsl:value-of select="PRO_ID"/></xsl:attribute>
              <xsl:attribute name="value"><xsl:apply-templates select="PRO_NOMBRE"/></xsl:attribute>             	        
            </input> 	    	    
	    <!--<b><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0270' and @lang=$lang]" disable-output-escaping="yes"/></b>-->
	    </p></td>
	  <td align="center"><xsl:apply-templates select="//button[@label='EliminarPeq']"/></td>
	  <td align="right" width="20%">
	    <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0421' and @lang=$lang]" disable-output-escaping="yes"/>
	    <input type="text" size="7" maxlength="7">
	      <xsl:attribute name="OnChange">LotesAUnidades(this.value,'<xsl:value-of select="PRO_UNIDADESPORLOTE"/>',this);alineaCelda(this);</xsl:attribute>
	      <xsl:attribute name="name">CANTIDAD_CAJAS<xsl:value-of select="PRO_ID"/></xsl:attribute>
	      <!--<xsl:attribute name="value"><xsl:if test="SELECCIONADO/CANTIDAD"><xsl:value-of select="PRO_UNIDADESPORLOTE"/></xsl:if></xsl:attribute>-->
	    </input></p>
	  </td>
	  <!--<td align="right" width="10%"><p class="tituloCamp">
	    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0410' and @lang=$lang]" disable-output-escaping="yes"/>        
	    <input type="radio" name="PRO_PREDETERMINADO" onClick="ActivaDesactiva(this,this.form)">
	      <xsl:attribute name="value"><xsl:value-of select="PRO_ID"/></xsl:attribute>   
	    </input>     
	    </p></td>-->
        </tr>
      </table>
      </td></tr>	
    <tr> 
      <td valign="top" width="25%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0390' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td width="25%">  
        <xsl:apply-templates select="REFERENCIA_PROVEEDOR"/></td>      
      <td valign="top" width="20%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0400' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td width="30%">  
        <xsl:apply-templates select="REFERENCIA_CLIENTE"/></td>	     
    </tr>
    <tr> 
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0240' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td colspan="3">  
        <xsl:apply-templates select="NOM_NOMBRECOMPLETO"/></td>     
    </tr>        
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0190' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PROVEEDOR"/></td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0170' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_FABRICANTE"/></td>              
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0180' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_MARCA"/></td>       
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0520' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <xsl:apply-templates select="PRO_TIPOIVA"/></td>      
    </tr>    	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0220' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td>  
        <!--<script>document.write(FormateaVis('<xsl:apply-templates select="PRO_UNIDADBASICA"/>'));</script>&nbsp;-->
        <xsl:apply-templates select="PRO_UNIDADBASICA"/>&nbsp;
      </td>
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
    <tr> 
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0160' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td colspan="3">  
        <xsl:apply-templates select="PRO_DESCRIPCION"/></td>
    </tr>
    <xsl:if test="TARIFAS/TARIFAS_ROW">    
    <tr>
      <td colspan="4" align="center">
        <table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0"><tr><td><table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr bgcolor="#CCCCCC">
	    <td><p class="tituloCamp">
	      <xsl:if test="TARIFAS/@COL='PUB'"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0360' and @lang=$lang]" disable-output-escaping="yes"/></xsl:if>  
	      <xsl:if test="TARIFAS/@COL='PRV'"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0361' and @lang=$lang]" disable-output-escaping="yes"/></xsl:if></p></td>
	    <td align="right"><p class="tituloCamp">
	      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0370' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
	    <td align="right"><p class="tituloCamp">    
	      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0380' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
	    <td><p class="tituloCamp">    
	      &nbsp;<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='P3-0385' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
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
	  </tr>
	  </xsl:for-each>
        </table></td></tr></table></td></tr></xsl:if>
    <tr bgcolor="#EEFFFF"><td colspan="4"><br/></td></tr>        	
  </table>
</xsl:template>   	 
<!--
 |	Los caracteres extraños vienen codificados de la base de datos, hemos de poner:
 |	disable-output-escaping="yes"
 +-->

<xsl:template match="PRO_NOMBRE">
  <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="NOM_NOMBRECOMPLETO">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="PRO_REFERENCIA">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="PROVEEDOR">
   <a style="color:#000000">
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',65,58,0,-50);</xsl:attribute> 
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    <xsl:value-of select="."  disable-output-escaping="yes"/>
   </a>
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

<xsl:template match="ATRAS">    
    <xsl:variable name="code-img-on">DB-Anterior_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-Anterior</xsl:variable>    
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>    
    <a>	    
      <xsl:attribute name="href">javascript:Navega(document.forms[0],'CANTIDAD_UNI','<xsl:value-of select="@PAG"/>');</xsl:attribute>
      <xsl:attribute name="onMouseOver">cambiaImagen('Anterior','<xsl:value-of select="$draw-on"/>');window.status='Retroceder pagina';return true</xsl:attribute>
      <xsl:attribute name="onMouseOut">cambiaImagen('Anterior','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
      <img name="Anterior" alt="Pagina anterior" border="0" src="{$draw-off}"/>
    </a>
    <br/>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0110' and @lang=$lang]" disable-output-escaping="yes"/>
</xsl:template>
	          
<xsl:template match="ADELANTE">	  		  
    <xsl:variable name="code-img-on">DB-Siguiente_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-Siguiente</xsl:variable>    
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>   
    <a>	    
      <xsl:attribute name="href">javascript:Navega(document.forms[0],'CANTIDAD_UNI','<xsl:value-of select="@PAG"/>');</xsl:attribute>
      <xsl:attribute name="onMouseOver">cambiaImagen('Siguiente','<xsl:value-of select="$draw-on"/>');window.status='Avanzar pagina';return true</xsl:attribute>
      <xsl:attribute name="onMouseOut">cambiaImagen('Siguiente','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
      <img name="Siguiente" alt="Siguiente pagina" border="0" src="{$draw-off}"/>
    </a>
    <br/>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0100' and @lang=$lang]" disable-output-escaping="yes"/>
</xsl:template>
  
<xsl:template match="ExtraButtons">   
    <xsl:variable name="code-img-on">DB-<xsl:value-of select="button/@label"/>_mov</xsl:variable>
    <xsl:variable name="code-img-off">DB-<xsl:value-of select="button/@label"/></xsl:variable>    
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>        
    <xsl:variable name="code-status"><xsl:value-of select="@status"/></xsl:variable>
    <xsl:variable name="status">
      <xsl:choose>
        <xsl:when test="button/@status">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="button/@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="code-alt"><xsl:value-of select="button/@alt"/></xsl:variable>
    <xsl:variable name="alt">
      <xsl:choose>
        <xsl:when test="button/@alt">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="button/@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
	  <a>
	    <xsl:attribute name="onMouseOver">cambiaImagen('<xsl:value-of select="button/@label"/>','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
	    <xsl:attribute name="onMouseOut">cambiaImagen('<xsl:value-of select="button/@label"/>','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>	    
            <xsl:attribute name="href">javascript:Linka('http://www.newco.dev.br/Compras/Multioferta/LPLista.xsql?LP_ID=<xsl:value-of select="../form/LP_ID"/>');</xsl:attribute>
	    <img name="{button/@label}" src="{$draw-off}" border="0" alt="{$alt}"/>
          </a>
          <br/>
          <xsl:variable name="caption"><xsl:value-of select="button/@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
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

<xsl:template match="LLP_TIPO_PRODUCTO">
  <input type="hidden" name="LLP_TIPO_PRODUCTO"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
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

<xsl:template match="LLP_PRODUCTO_AUTOMATICO">
  <input type="hidden" name="LLP_PRODUCTO_AUTOMATICO"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_NIVEL_CALIDAD">
  <input type="hidden" name="LLP_NIVEL_CALIDAD"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
</xsl:template>

<xsl:template match="LLP_PROV_HABITUALES">
  <input type="hidden" name="LLP_PROV_HABITUALES"><xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute></input>
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
	    <xsl:attribute name="href"><xsl:value-of select="$link"/>?LLP_ID=<xsl:value-of select="../form/LLP_ID"/>&amp;LP_ID=<xsl:value-of select="../form/LP_ID"/>&amp;OP=<xsl:value-of select="../form/OPERACION"/></xsl:attribute>
	    <xsl:attribute name="onMouseOver">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
	    <xsl:attribute name="onMouseOut">cambiaImagen('<xsl:value-of select="picture-off"/>','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
	    <img name="{picture-off}" alt="{$alt}" src="{$draw-off}" border="0"/>
          </a>
          <br/>
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>       
  </xsl:template>
  
</xsl:stylesheet>
