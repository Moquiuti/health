<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Aquesta versió es per a només Lectura [Read-Only] (només per a veure l'estat 
 |		de la oferta sense poder actuar-hi).
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">

    <html>
      <head> 	
        <title>Oferta</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">	
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        <script type="text/javascript">
        <!--
        function Actualizando(importe_ant){
          if (document.form1.elements['seleccion'][0].checked==true){
            calculoConImporte(importe_ant);           
          }else{
            calculoConDescuento(importe_ant);
          }
        }
        function Reseteando(descuento,transporte,importe_total){       
          document.form1.elements['MO_DESCUENTOGENERAL'].value=FormateaVis(descuento);
          document.form1.elements['MO_COSTELOGISTICA'].value=FormateaVis(transporte);         
          calculoConDescuento(importe_total);          
        }       
	function calculoConDescuento(importe_ant){
	  descuento=AntiformateaVis(document.form1.elements['MO_DESCUENTOGENERAL'].value,document.form1.elements['MO_DESCUENTOGENERAL']);
	  if (isNaN(descuento) || descuento<0 || descuento>100){
	    alert('Introduzca un valor de descuento correcto en %');
	  }else{	
	    var subtotal=0;
	    var importeiva=0;
	    for(k=0;k<document.form1.elements.length;k++){
	      if (document.form1.elements[k].name.substr(0,7)=='IMPORTE' && document.form1.elements[k].name!='IMPORTE_FINAL_PEDIDO'){
	        importe=AntiformateaVis(document.form1.elements[k].value);
	        iva=(document.form1.elements['IVA'+importe].value);
	        importeiva+=importe*(iva/100);
                subtotal+=importe*(1+iva/100);	      
	      }
	    }
	    subtotal*=(1-descuento/100);
	    transporte=AntiformateaVis(document.form1.elements['MO_COSTELOGISTICA'].value,document.form1.elements['MO_COSTELOGISTICA']);
	    document.form1.elements['MO_IMPORTEIVA'].value=FormateaVis(Decimales_con_punto(importeiva, 0, 0));	    
	    //alert(subtotal+transporte);
	    document.form1.elements['IMPORTE_FINAL_PEDIDO'].value=FormateaVis(Decimales_con_punto(subtotal+transporte, 0, 0));
	  }
	}
	function calculoConImporte(importe_ant){
	  importefinal=AntiformateaVis(document.form1.elements['IMPORTE_FINAL_PEDIDO'].value,document.form1.elements['IMPORTE_FINAL_PEDIDO']);
	  if (isNaN(importe)){
	    alert('Introduzca un valor de importe correcto');
	  }else{	
	    var subtotal=0;
	    var importeiva=0;
	    for(k=0;k<document.form1.elements.length;k++){
	      if (document.form1.elements[k].name.substr(0,7)=='IMPORTE' && document.form1.elements[k].name!='IMPORTE_FINAL_PEDIDO'){
	        importe=AntiformateaVis(document.form1.elements[k].value);
	        iva=(document.form1.elements['IVA'+importe].value);
	        importeiva+=importe*(iva/100);
                subtotal+=importe*(1+iva/100);	      
	      }
	    }
	    transporte=AntiformateaVis(document.form1.elements['MO_COSTELOGISTICA'].value,document.form1.elements['MO_COSTELOGISTICA']);
	    document.form1.elements['MO_IMPORTEIVA'].value=FormateaVis(Decimales_con_punto(importeiva, 0, 0));
	    //alert(100*(subtotal-importefinal+transporte)/subtotal, 2, 0);
	    document.form1.elements['MO_DESCUENTOGENERAL'].value=FormateaVis(Decimales_con_punto(100*(subtotal-importefinal+transporte)/subtotal, 2, 0));
	  }
	}
	function Valida(formu){
	  if (checkNumber(formu.elements['LPP_IMPORTE'].value,formu.elements['LPP_IMPORTE'])){ 
	    formu.elements['LPP_IMPORTE'].value=AntiformateaVis(formu.elements['LPP_IMPORTE'].value);
	    if (test(formu)) SubmitForm(formu);
	  }
	}
	function HayComent(formu){
	  if(formu.elements['NMU_COMENTARIOS'].value!=""){
	    return true;
	  }else {
	    alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0400' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');
	    return false;
	  }
	}
	function Eliminar(formu,accion){
          AsignarAccion(formu,accion);
          if (ConfirmarBorrado(formu))SubmitForm(formu);	
	}
	function Anadir(formu,accion){	
	  AsignarAccion(formu,accion);Valida(formu);
	}
	function NoInteresa(formu,accion){
	  AsignarAccion(formu,accion);if (HayComent(formu))SubmitForm(formu);
	}
	function Actua(formu,accion){
	  AsignarAccion(formu,accion);
	  SubmitForm(formu);
	}
	function Actua_Check_Number(formu,accion){
	  //Mira si todos los campos numericos son correctos. 
	  //Si es asi los antifromatea para la base de datos y hace submit. 
	  if (checkNumber(formu.elements['MO_DESCUENTOGENERAL'].value,formu.elements['MO_DESCUENTOGENERAL']) && checkNumber(formu.elements['MO_COSTELOGISTICA'].value,formu.elements['MO_COSTELOGISTICA']) && checkNumber(formu.elements['MO_IMPORTEIVA'].value,formu.elements['MO_IMPORTEIVA']) && checkNumber(formu.elements['IMPORTE_FINAL_PEDIDO'].value,formu.elements['IMPORTE_FINAL_PEDIDO'])){
	    formu.elements['MO_DESCUENTOGENERAL'].value = AntiformateaVis(formu.elements['MO_DESCUENTOGENERAL'].value);
	    formu.elements['MO_COSTELOGISTICA'].value = AntiformateaVis(formu.elements['MO_COSTELOGISTICA'].value);
	    formu.elements['MO_IMPORTEIVA'].value = AntiformateaVis(formu.elements['MO_IMPORTEIVA'].value);
	    formu.elements['IMPORTE_FINAL_PEDIDO'].value = AntiformateaVis(formu.elements['IMPORTE_FINAL_PEDIDO'].value);
	    AsignarAccion(formu,accion);
	    formu.elements['MO_IMPORTEIVA'].disabled=false;
	    //alert('IVA:'+formu.elements['MO_IMPORTEIVA'].value+' d:'+formu.elements['MO_IMPORTEIVA'].disabled+' IMPORTE_FIN:'+formu.elements['IMPORTE_FINAL_PEDIDO'].value);
	    SubmitForm(formu);
	  }
	}
        // CodigoProducto, Cliente, MO_ID, ROL 
	function SaltaTarifas(codprod,cliente,mo_id,rol){
	  var saltar = "http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql";
	  var prmextra = "(MO_ID,"+mo_id+"),(ROL,"+rol+")";
	  var newlocation = "http://www.newco.dev.br/Administracion/Mantenimiento/Tarifas/TRFManten.xsql"
	  newlocation=newlocation + "?EMP_ID="+cliente;
	  newlocation=newlocation +"&PRO_ID="+codprod;
	  newlocation=newlocation +"&MO_ID="+mo_id;
	  newlocation=newlocation +"&SALTAR="+saltar;
	  newlocation=newlocation +"&PRMEXTRA="+prmextra;
	 // newlocation=newlocation +"&xml-stylesheet=none";
	 // prompt(newlocation,newlocation);
          window.location = newlocation;
        }      
	//-->        
        </script>
        ]]></xsl:text>        
      </head> 
	
      <body bgcolor="#EEFFFF">
        <xsl:apply-templates select="Multioferta/MULTIOFERTA"/>
	<table width="100%" border="0">
	  <tr align="center">        
	    <td><xsl:apply-templates select="Multioferta/jumpTo"/></td>
	    <td width="80%">&nbsp;</td>
	    <td><xsl:apply-templates select="Multioferta/button"/></td></tr></table>	
      </body>
    </html>
  </xsl:template>

<xsl:template match="MULTIOFERTA">

   <!--
    |   
    |   
    +-->
    <xsl:choose>
      <xsl:when test="MO_STATUS[.='6']">
	<p class="tituloPag" align="center"><a class="tituloPag" align="center" href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={MO_IDCLIENTE}"><xsl:value-of select="CLIENTE"/>&nbsp;<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0101' and @lang=$lang]" disable-output-escaping="yes"/></a>&nbsp;        
          <xsl:if test="LP_VISIBILIDAD/@NUM">(<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0107' and @lang=$lang]" disable-output-escaping="yes"/><xsl:value-of select="LP_VISIBILIDAD/@NUM"/>&nbsp;<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0108' and @lang=$lang]" disable-output-escaping="yes"/>)</xsl:if>
        </p>
      </xsl:when>
      <xsl:when test="MO_STATUS[.='7']">
	<p class="tituloPag" align="center"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0102' and @lang=$lang]" disable-output-escaping="yes"/>&nbsp;<xsl:value-of select="PROVEEDOR"/><br/>(<xsl:value-of select="VENDEDOR"/>).</p>            
      </xsl:when>
      <xsl:when test="MO_STATUS[.='8'] | MO_STATUS[.='12']">
	<p class="tituloPag" align="center"><xsl:value-of select="PROVEEDOR"/>&nbsp;<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0360' and @lang=$lang]" disable-output-escaping="yes"/></p>	              
      </xsl:when>
      <xsl:when test="MO_STATUS[.='9']">
	<p class="tituloPag" align="center"><xsl:value-of select="CLIENTE"/>&nbsp;<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0360' and @lang=$lang]" disable-output-escaping="yes"/></p>	           
      </xsl:when>
      <xsl:when test="MO_STATUS[.='10']">
	<p class="tituloPag" align="center"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0103' and @lang=$lang]" disable-output-escaping="yes"/></p>	              
      </xsl:when>
      <xsl:when test="MO_STATUS[.='11']">
	<p class="tituloPag" align="center"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0104' and @lang=$lang]" disable-output-escaping="yes"/></p>	              
      </xsl:when>
      <xsl:when test="MO_STATUS[.='13']">
	<p class="tituloPag" align="center"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0105' and @lang=$lang]" disable-output-escaping="yes"/></p>	              
      </xsl:when>
      <xsl:when test="MO_STATUS[.='15']">
	<p class="tituloPag" align="center"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0106' and @lang=$lang]" disable-output-escaping="yes"/></p>	              
      </xsl:when>  
      <xsl:when test="MO_STATUS[.='17']">
	<p class="tituloPag" align="center"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0116' and @lang=$lang]" disable-output-escaping="yes"/></p>	              
      </xsl:when>             
      <xsl:otherwise>
	<p class="tituloPag" align="center"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0100' and @lang=$lang]" disable-output-escaping="yes"/></p>	      
      </xsl:otherwise>	      	      
    </xsl:choose>	    	    

<table width="100%" align="center" border="0" cellspacing="0" cellpadding="0" bgcolor="#EEFFFF">
   <!--
    |    Solo mostramos el numero de pedido cuando existe y estamos en pantallas
    |           del cliente.
    +-->  
  <xsl:choose>
  <xsl:when test="MO_STATUS[.='10'] or MO_STATUS[.='11'] or MO_STATUS[.='12'] or MO_STATUS[.='13'] or MO_STATUS[.='15'] or MO_STATUS[.='17']">
  <tr>
    <td>     
      <xsl:choose><xsl:when test="PED_NUMERO"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0135' and @lang=$lang]" disable-output-escaping="yes"/>:</p></xsl:when>
      <xsl:otherwise><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0136' and @lang=$lang]" disable-output-escaping="yes"/>:</p></xsl:otherwise></xsl:choose></td>
    <td>
      <xsl:choose><xsl:when test="PED_NUMERO"><xsl:value-of select="PED_NUMERO"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="MO_NUMERO"/></xsl:otherwise></xsl:choose></td>
    <xsl:choose><xsl:when test="MO_STATUS[.='10'] or MO_STATUS[.='12'] or MO_STATUS[.='13'] or MO_STATUS[.='17']"> 
      <td width="20%">
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0111' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td width="30%">
        <xsl:value-of select="PROVEEDOR"/></td></xsl:when>
    <xsl:otherwise>          
      <td width="20%">
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0109' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
      <td width="30%">
        <xsl:value-of select="CLIENTE"/></td></xsl:otherwise></xsl:choose></tr></xsl:when></xsl:choose>
  <tr valign="top">
    <td width="20%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0210' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
    <td width="30%">
      <xsl:value-of select="LP_FECHAEMISION"/>&nbsp;</td>
    <td width="20%">
      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0210' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
    <td width="30%">
      <xsl:value-of select="LP_FECHADECISION"/>&nbsp;</td></tr>
  <tr valign="top">
    <td>
      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0220' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
    <td>
      <xsl:value-of select="LP_FECHAENTREGA"/>&nbsp;</td>                        
    <td width="20%">
      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0112' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
    <td width="40%"><xsl:value-of select="CENTRO/CEN_DIRECCION"/><br/><xsl:value-of select="CENTRO/CEN_CPOSTAL"/>-<xsl:value-of select="CENTRO/CEN_POBLACION"/><br/><xsl:value-of select="CENTRO/CEN_PROVINCIA"/></td></tr>          
  <tr>            
    <td>
      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0110' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
    <td colspan="3">
      <xsl:value-of select="MO_FORMAPAGO"/>&nbsp;</td></tr>       
  <tr>
    <td>
      <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0120' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>
    <td colspan="3">
      <xsl:value-of select="MO_CONDICIONESGENERALES"/></td></tr>       
  <tr>
    <td colspan="4"><xsl:apply-templates select="LINEASMULTIOFERTA"/></td></tr>
    <!--</xsl:when>
  </xsl:choose>          -->
  <tr>
    <td colspan="4">
      <br/>
      <xsl:apply-templates select="LINEASPAGO"/></td></tr>      
  <tr>
    <td colspan="4">
      <xsl:apply-templates select="NEGOCIACION"/>
      <br/></td></tr></table>
</xsl:template>

<xsl:template match="LINEASMULTIOFERTA">
  <br/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td colspan="9">
  <table width="100%" border="1" cellspacing="0" cellpadding="0">
    <tr bgcolor="#CCCCCC" align="center">
      <td width="5%">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0140' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="40%">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0150' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <xsl:if test="not(../MO_STATUS[.=13] or ../MO_STATUS[.=15])">
      <td width="10%">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0165' and @lang=$lang]" disable-output-escaping="yes"/></p></td></xsl:if>       
      <td width="10%">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0155' and @lang=$lang]" disable-output-escaping="yes"/></p></td>       
      <td width="10%">   
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0160' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="5%">
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0175' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="10%">
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0170' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="5%">&nbsp;</td></tr>
    
    <xsl:for-each select="LINEASMULTIOFERTA_ROW">   
    <tr>
      <xsl:apply-templates select="."/>
    </tr>
    </xsl:for-each></table></td></tr>
    
   <!--
    |   
    +-->
    <tr><td colspan="9"><br/></td></tr>    
    <tr>
      <td align="right" colspan="7" width="80%">
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0270' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>     
      <td align="right" width="10%">
        <xsl:value-of select="../DIV_PREFIJO"/><xsl:value-of select="../IMPORTE_TOTAL_FORMATO"/></td>
      <td align="left" width="5%">&nbsp;<xsl:value-of select="../DIV_SUFIJO"/></td>                
    </tr>
    <tr><td colspan="9"><br/></td></tr>    
    <tr>   
      <td colspan="7" align="right">
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0260' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>     
      <td align="right">
        <xsl:value-of select="../MO_DESCUENTOGENERAL"/>
      </td>
      <td width="5%">&nbsp;%</td>            
    </tr>
    <tr>
      <td colspan="7" align="right">
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0240' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>     
      <td align="right">
        <xsl:value-of select="../DIV_PREFIJO"/><xsl:value-of select="../MO_COSTELOGISTICA_FORMATO"/>
      </td>
      <td width="5%">&nbsp;<xsl:value-of select="../DIV_SUFIJO"/>&nbsp;</td>                 
    </tr>
    <tr> 
      <td colspan="7" align="right">
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0235' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>       
      <td align="right">
        <xsl:value-of select="../DIV_PREFIJO"/><xsl:value-of select="../MO_IMPORTEIVA_FORMATO"/>
      </td>      
      <td width="5%">&nbsp;<xsl:value-of select="../DIV_SUFIJO"/>&nbsp;</td>     
    </tr>
    <tr> 
      <td colspan="7" align="right">
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0230' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>       
      <td align="right">
        <xsl:value-of select="../DIV_PREFIJO"/><xsl:value-of select="../IMPORTE_FINAL_PEDIDO"/>
      </td>
      <td width="5%">&nbsp;<xsl:value-of select="../DIV_SUFIJO"/>&nbsp;</td>      
    </tr>    
    <!--
    </xsl:when>
            
    </xsl:choose>      
    -->
  </table>   
</xsl:template>



<!--
 |   Lineas de la multioferta
 |   
 +-->
<xsl:template match="LINEASMULTIOFERTA_ROW">
   <!--
    |   
    |   
    +-->
  <xsl:choose>
    <xsl:when test="../../MO_STATUS[.=6]">
      <input type="hidden" name="IMPORTE{IMPORTESINFORMATO}" value="{IMPORTESINFORMATO}"/>
      <input type="hidden" name="IVA{IMPORTESINFORMATO}" value="{LMO_TIPOIVA}"/>
    </xsl:when>
  </xsl:choose>

   <!--
    |   
    |   
    +-->
      <td>
        <xsl:apply-templates select="LMO_IDPRODUCTO"/></td>      
      <td>
        <xsl:value-of select="PRO_NOMBRE"/>&nbsp;</td>      
      <xsl:if test="not(../../MO_STATUS[.=13] or ../../MO_STATUS[.=15])">      
      <td align="right">       
        <i><xsl:apply-templates select="LMO_PRECIOANT"/>&nbsp;</i>
        </td></xsl:if>
      <td align="right">       
        <xsl:apply-templates select="LMO_PRECIO"/> 
      </td>
      <td align="right">       
        <xsl:apply-templates select="LMO_CANTIDAD"/>        
        </td>
      <td align="right"> 
        <xsl:value-of select="LMO_TIPOIVA"/>%
        </td>
      <td align="right"> 
        <xsl:value-of select="DIV_PREFIJO"/><xsl:value-of select="IMPORTE"/>
        </td>
      <td width="5%">&nbsp;<xsl:value-of select="DIV_SUFIJO"/>&nbsp;</td>
</xsl:template>

<!--
 |   
 |   
 +-->
<xsl:template match="LINEASPAGO">
  <xsl:apply-templates select="LPP_IDPEDIDO"/>
    <table width="100%" border="0" cellpadding="2" cellspacing="0">
    <tr>
    <td colspan="6" align="left">
        <p class="tituloBloque">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0308' and @lang=$lang]" disable-output-escaping="yes"/>
    </p></td></tr>
    <tr><td colspan="6" align="left">&nbsp;</td></tr>    
      <tr bgcolor="#A0D8D7">
        <td>
          <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0310' and @lang=$lang]" disable-output-escaping="yes"/>
          <span style="font-size: 9pt;font-weight:normal"><br/>(<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0315' and @lang=$lang]" disable-output-escaping="yes"/>)
          </span></p></td>
        <td>
          <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0320' and @lang=$lang]" disable-output-escaping="yes"/>
          </p></td> 
        <td align="right">
          <p class="tituloCamp" style="margin-right:10px"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0330' and @lang=$lang]" disable-output-escaping="yes"/>
          </p></td> 
        <td align="center">
          <!--<p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0340' and @lang=$lang]" disable-output-escaping="yes"/>
          </p>-->&nbsp;</td>        
        <td align="center">
          <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0350' and @lang=$lang]" disable-output-escaping="yes"/>
          </p></td>
        <td>&nbsp;</td>                                
      </tr>
      
      <xsl:choose>
        <xsl:when test="../MO_STATUS[.='11'] or ../MO_STATUS[.='12'] or ../MO_STATUS[.='13'] or ../MO_STATUS[.='15'] or ../MO_STATUS[.='17']">
          <xsl:for-each select="LINEASPAGO_ROW">
            <tr >
	      <td><xsl:value-of select="LPP_FECHA"/>
	      </td>
	      <td>          
		<xsl:value-of select="FP_DESCRIPCION"/>
	      </td> 
	      <td align="right"><p style="margin-right:10px"><xsl:value-of select="DIV_PREFIJO"/><xsl:value-of select="LPP_IMPORTE"/>
	        </p></td> 
	      <td>
		<xsl:value-of select="DIV_SUFIJO"/>        
	      </td> 
	      <td>
	        <xsl:value-of select="LPP_COMENTARIOS"/>       
	      </td>
	      <td>        
		&nbsp;
              </td>
            </tr>
          </xsl:for-each> 
        </xsl:when>
      </xsl:choose>                       
      
    </table>    
</xsl:template>  

<xsl:template match="NEGOCIACION">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <xsl:for-each select="NEGOCIACION_ROW">
    <tr>
	  <xsl:choose>
	    <xsl:when test="@COL='A'">
	      <td colspan="3" >
		<p class="tituloCamp">
	          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0280' and @lang=$lang]" disable-output-escaping="yes"/><xsl:value-of select="EMPRESA"/>:&nbsp;	  
		</p></td>
	      <td >
	        <xsl:value-of select="NMU_COMENTARIOS"/>                       
	      </td>
	    </xsl:when>
	    <xsl:when test="@COL='B'">
	      <td colspan="3" bgcolor="#A0D8D7">
		<p class="tituloCamp">
	          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0280' and @lang=$lang]" disable-output-escaping="yes"/><xsl:value-of select="EMPRESA"/>:&nbsp;	  
	        </p></td>
	      <td bgcolor="#A0D8D7">
	        <xsl:value-of select="NMU_COMENTARIOS"/>                       
	      </td>
	    </xsl:when>
	    <xsl:otherwise>
	      <td colspan="3" bgcolor="#A0D8D7">
		<p class="tituloCamp">
	          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0280' and @lang=$lang]" disable-output-escaping="yes"/><xsl:value-of select="EMPRESA"/>:&nbsp;	  
	        </p></td>
	      <td bgcolor="#A0D8D7">
	        <xsl:value-of select="NMU_COMENTARIOS"/>                       
	      </td>
	    </xsl:otherwise> 	               
	  </xsl:choose>
    </tr>
    </xsl:for-each>                     
  </table>
</xsl:template>

<xsl:template match="MO_COSTELOGISTICA">
  <input type="text" name="MO_COSTELOGISTICA" size="12" maxlength="12" style="text-align:right;" >
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="LMO_DESCUENTO">
  <input type="text" name="LMO_DESCUENTO" size="6" maxlength="6" style="text-align:right;">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="MO_STATUS">
  <input type="hidden" name="MO_STATUS">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="MO_ID">
  <input type="hidden" name="MO_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="ROL">
  <input type="hidden" name="ROL">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>


<xsl:template match="MO_IDPEDIDO">
  <input type="hidden" name="PED_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>


<xsl:template match="LPP_IDPEDIDO">
  <input type="hidden" name="PED_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

<xsl:template match="LPP_ID">
  <input type="hidden" name="LPP_ID">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </input>
</xsl:template>

</xsl:stylesheet>
