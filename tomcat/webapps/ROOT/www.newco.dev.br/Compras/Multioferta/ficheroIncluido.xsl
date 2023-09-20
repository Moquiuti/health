<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |Fichero: MultiofertaHTML.xsl
 |Descripcion: Proceso entero de Multioferta
 |Funcionamiento: Los estados son: 6,7,8,9,10,11,12,13,15,16,17.
 |
 |Modificaciones:
 |Fecha: 20/06/01  Autor Modificacion: Olivier
 |Fecha: 28/06/01  Autor Modificacion: Olivier -> Adaptar el fichero al proceso READ_ONLY
 |Fecha: 09/07/01  Autor Modificacion: Olivier -> Introduzco el estado 17: proceso terminado.
 |Fecha: 20/08/01  Autor Modificacion: Olivier -> Campo FORMA DE PAGO editable en la cabecera.
 |Fecha: 20/08/01  Autor Modificacion: Olivier -> Introduzco el estado 16: Pago recibido por el proveedor.
 |me he actualizado!!
 |
 |Situacion: __Normal__
 |
 |(c) 2001 MedicalVM
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
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
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
        <script type="text/javascript" src="http://www.newco.dev.br/General/divisas.js"></script>
        <script type="text/javascript">
        <!--
        
	var estado = ]]></xsl:text><xsl:value-of select="Multioferta/MULTIOFERTA/MO_STATUS"/><xsl:text disable-output-escaping="yes"><![CDATA[;
	var divisaIni = ]]></xsl:text><xsl:value-of select="//@current"/><xsl:text disable-output-escaping="yes"><![CDATA[;
	
	var msg_ImporteVacio = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
	var msgNoExplicacion="Rogamos comunique a su cliente el motivo del rechazo.";
	var msg_ImporteVacio = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
        var msgGeneraIncidencia="El rechazo de un pedido en este estado generará una incidencia en su contra. ¿Desea continuar?";
	var msgFaltaComentario = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0400' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
	
	function MensajeAyudaComentarioCliente () {
	 alert("Por favor, introduzca un comentario para el proveedor.\n\n * Preparar pedido: Para dar por finalizado el proceso de negociación. \n * Responder: Para continuar con la negociación.  \n * Terminar petición de oferta: Para dar por terminada la oferta. \n * Pendiente: Para dejar esta oferta pendiente.\n");
	}
	
	function MensajeAyudaComentarioClienteGen () {
	 alert("Por favor, introduzca un comentario para el proveedor.");
	}
	
	function MensajeAyudaComentarioProveedor () {
	 alert("Por favor, introduzca un comentario para el cliente.\n\n * Enviar: Para continuar con la negociación.  \n * Terminar petición de oferta: Para dar por terminada la oferta. \n * Pendiente: Para dejar esta oferta pendiente.\n");
	}
	function MensajeAyudaComentarioProveedorGen () {
	 alert("Por favor, introduzca un comentario para el cliente.");
	}

	function Actua(formu,accion){
	  comentariosToForm1(document.forms['comentarios'], document.forms['form1'],'NMU_COMENTARIOS');
	  AsignarAccion(formu,accion);
	  SubmitForm(formu);
        }
	
	
	// 
	// Ferran Foz - nextret.net - 25.4.2001
	//    No pedimos confirmación cuando el proveedor rechaza un pedido.
	//
	
	function Rechazar(formu,accion){
	  if (formu.elements['NMU_COMENTARIOS'].value==""){
	    alert(msgNoExplicacion);
	  }else{
	      AsignarAccion(formu,accion);
	      SubmitForm(formu);	
	  }
	}
	
	function calculaFecha(nom,mas){ // nom:nombre del combo; mas:incremento del "delay" cf sabado, domingo...
    /*
      
      Modificado por Nacho Garcia
      fecha: 14/9/2001
      
      A la hora de calcular la fecha hay un caso especial que es que la fecha de entrega no se quiera informar.
      en ese caso la fecha es NULL
      
      Modificado por E.T.
      fecha: 31/12/2001
      
      Modificado por Nacho
      fecha: 15/01/2002
 
      Cambios introducidos:
      - Utiliza las funciones de suma de fechas de Javascript
      - Separar el tratamiento de los controles del tratamiento de las fechas
      - Corrección del error en Netscape y Mozilla que presenta la fecha 101 en lugar de 2001
      - Corrección del error en todas las plataformas que presenta fecha 0/mm/yyyy
    */

          var hoy=new Date();  
          var Resultado=sumaDiasAFecha(hoy, mas);
          
          // gestion de los sabados y domingos...
          diaSemana = Resultado.getDay();
          
          if (diaSemana==0) 
            Resultado=sumaDiasAFecha(Resultado,1);
          else 
            if (diaSemana==6) 
              Resultado=sumaDiasAFecha(Resultado,2);

          // imprimir datos en los textbox en el formato dd/mm/aaaa....
          
          var elDia=Resultado.getDate();
          var elMes=Number(Resultado.getMonth())+1;
          var elAnyo=Resultado.getFullYear();
          var laFecha=elDia+'/'+elMes+'/'+elAnyo;
          
            document.forms['anadir'].elements['FECHANO_'+nom].value = laFecha;   
    }        
                
                
        function sumaDiasAFecha(fechainicio,incremento)
    {   
        return sumaFechas(fechainicio,incremento*24*60*60*1000);
        
    }  
    
    
    function sumaFechas(fecha1,fecha2)
    { 
          //    primero asegura la conversión a un formato fecha
        
        var fFecha1=new Date(fecha1);
        var fFecha2=new Date(fecha2);
        var Resultado=parseInt(fFecha1.getTime()+fFecha2.getTime());
        var fResultado=new Date(Resultado);
        
        return fResultado;
    }     
    
    //Copiar la zona de texto NMU_COMENTARIOS del form comentarios en el campo hidden NMU_COMENTARIOS del form1
        function comentariosToForm1(formOrigen, formDestino,elemento) {
           
           /*
           for(var n=0;n<document.forms.length;n++){
             //alert('form: '+document.forms[n].name+' '+'longitud: '+' '+document.forms[n].length);
             for(var i=0;i<document.forms[n].length;i++){
               //alert(document.forms[n].elements[i].name+' '+document.forms[n].elements[i].value);
             }
           }
           
           //alert('nombre: '+elemento);
           //alert('origen: '+formOrigen.name+' '+formOrigen.elements[elemento].value);
           //alert('destino: '+formDestino.name+' '+formDestino.elements[elemento].value);
          */
           formDestino.elements[elemento].value=formOrigen.elements[elemento].value;
        }        
	     
	//-->        
        </script>
        ]]></xsl:text> 
               
      </head> 
      <body bgcolor="#FFFFFF"> 
            
	
        <xsl:choose>
           <xsl:when test="Multioferta/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>        
           </xsl:when>
           <xsl:when test="Multioferta/Status">
             <xsl:apply-templates select="//Status"/>        
           </xsl:when>           
        </xsl:choose>        	
	<xsl:apply-templates select="Multioferta/MULTIOFERTA"/>	
      </body>
    </html>
  </xsl:template>

  <xsl:template match="MULTIOFERTA">

  <!-- **************************************************************************************************************
   |
   |  						TITULO DE LA PANTALLA.
   |
   + ************************************************************************************************************** -->
   

    <table width="100%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="#015E4B">
	<tr class="oscuro"><td colspan="6" align="center">
	<xsl:value-of select="CLIENTE"/>&nbsp;<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0104' and @lang=$lang]" disable-output-escaping="yes"/>
        </td></tr>
        
  
    <!-- **************************************************************************************************************
   |
   |  					CREACION DEL FORM CON CAMPOS HIDDEN
   |				Para estados 6,7,8,9,12: FORM=FORM1, sino FORM=COMENTARIOS
   |			
   + **************************************************************************************************************   -->
          <form method="post" name="form1">       
            <xsl:apply-templates select="MO_STATUS"/>
            <xsl:apply-templates select="MO_ID"/>
            <xsl:apply-templates select="/Multioferta/ROL"/>
            <xsl:apply-templates select="/Multioferta/TIPO"/>
            <input type="hidden" name="STRING_CANTIDADES"/>
            <input type="hidden" name="STRING_PRECIOS"/>
            <input type="hidden" name="NMU_COMENTARIOS"/>
            <xsl:element name="input"> 
             <xsl:attribute name="name">IDDIVISA</xsl:attribute>
             <xsl:attribute name="type">hidden</xsl:attribute>
             <xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
    	   </xsl:element>
      
  <!-- **************************************************************************************************************
   |
   |  						CABECERA DE LA MULTIOFERTA
   |
   |		Nota: Solo mostramos el numero de pedido cuando existe y estamos en pantallas del cliente.
   + ************************************************************************************************************** -->  
       
       
       <tr class="blanco"> 
    <td colspan="6"> 
      <table width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr> 
          <td align="center"> 
            <table width="95%" border="0" class="muyoscuro" cellpadding="3" cellspacing="1">
              <tr class="oscuro">
                <td valign="top" colspan="2">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">
                  <tr> 
                    <td class="oscuro" colspan="2" align="left">
                      
                      Cliente: <b><xsl:value-of select="DATOSCLIENTE/EMP_NOMBRE"/></b>
                      <xsl:if test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                      &nbsp;Centro: <b><xsl:value-of select="CENTRO/CEN_NOMBRE"/></b>
                      </xsl:if>
                    </td>
                    <td class="oscuro" colspan="2" align="right">
                      Nif:
                      <xsl:choose>
                        <xsl:when test="DATOSCLIENTE/EMP_NIF!=CENTRO/CEN_NIF and CENTRO/CEN_NIF!=''">
                          <b><xsl:value-of select="CENTRO/CEN_NIF"/></b>
                        </xsl:when>
                        <xsl:otherwise> 
                          <b><xsl:value-of select="DATOSCLIENTE/EMP_NIF"/></b>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr class="blanco"> 
                <td class="claro" colspan="2">
                  Dirección:
                </td>
              </tr>
              <tr class="blanco"> 
                <td colspan="2">
                  <table align="left">
                    <tr>
                      <td>
                        &nbsp;&nbsp;
                      </td>
                      <td>
                        <xsl:choose>
                          <xsl:when test="DATOSCLIENTE/EMP_NOMBRE!=CENTRO/CEN_NOMBRE">
                            <xsl:call-template name="direccionCentro">
                              <xsl:with-param name="path" select="CENTRO"/>
                            </xsl:call-template>
                          </xsl:when>
                          
                          <xsl:otherwise>
                            <xsl:call-template name="direccion">
                              <xsl:with-param name="path" select="DATOSCLIENTE"/>
                            </xsl:call-template>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr class="blanco"> 
                <td align="center" class="claro">
                  Comprador:
                </td>
                <td align="center">
                  <xsl:value-of select="COMPRADOR"/>
                </td>
              </tr>
            </table>
          </td>
          <td align="center"> 
            <table width="95%" border="0" class="muyoscuro" cellpadding="3" cellspacing="1">
              <tr class="oscuro">
                <td colspan="2">
                <table width="100%" cellpadding="0" cellspacing="0" height="100%">
                  <tr> 
                    <td class="oscuro" align="left">
                      Proveedor: <b><xsl:value-of select="DATOSPROVEEDOR/EMP_NOMBRE"/></b>
                    </td>
                    <td class="oscuro" align="right">
                      Nif: <b><xsl:value-of select="DATOSPROVEEDOR/EMP_NIF"/></b>
                    </td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr class="blanco"> 
                <td class="claro" colspan="2">
                  Dirección:
                </td>
              </tr>
              <tr class="blanco"> 
                <td colspan="2">
                  <table align="left">
                    <tr>
                      <td>
                        &nbsp;&nbsp;
                      </td>
                      <td>
                        <xsl:call-template name="direccion">
                          <xsl:with-param name="path" select="DATOSPROVEEDOR"/>
                        </xsl:call-template>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr class="blanco"> 
                <td align="center" class="claro">
                  Comercial:
                </td>
                <td align="center">
                  <xsl:value-of select="VENDEDOR"/>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br/>
    </td>
  </tr>
  <tr class="oscuro"> 
    <td colspan="4">
      <table>
        <tr>
          <td width="90%">
            Datos del Pedido
          </td>
      </tr>
    </table>
    </td>
  </tr>
    <tr class="blanco"> 
      <td class="claro" width="20%">
        Número de pedido:
      </td>
      <td class="blanco" width="25%">
        <font color="NAVY" size="2">
        <b><xsl:value-of select="PED_NUMERO"/></b>
        </font>
      </td>
      <td class="claro" width="20%">
        Fecha del pedido:
      </td>
      <td class="blanco">
        <font color="NAVY" size="2">
        <!-- ET 13/8/2002 <b><xsl:value-of select="LP_FECHAEMISION"/></b>-->
        <b><xsl:value-of select="PED_FECHA"/></b>
        </font>
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro">
        Fecha de entrega:
      </td>
      <td class="blanco">
        <xsl:value-of select="LP_FECHAENTREGA"/>
        <input type="hidden" name="FECHANO_ENTREGA" size="12" maxlength="10" value="{LP_FECHAENTREGA}" onFocus="this.blur();" class="inputOcultoPar"/>
      </td>
      <td class="claro" rowspan="3">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0125' and @lang=$lang]" disable-output-escaping="yes"/>:
      </td>
      <td class="blanco" rowspan="3">
        <xsl:copy-of select="//MO_CONDICIONESGENERALESHTML"/>
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro">
        Fecha de pago:
      </td>
      <td class="blanco">
        <xsl:choose>
          <xsl:when test="PLAZOPAGO='Otras'">
            <xsl:value-of select="LINEASPAGO/LINEASPAGO_ROW/LPP_FECHA"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="PLAZOPAGO"/> 
          </xsl:otherwise>
        </xsl:choose>
        <input type="hidden" name="FECHANO_PAGO" size="12" maxlength="10" value="{LINEASPAGO/LINEASPAGO_ROW/LPP_FECHA}" onFocus="this.blur();" class="inputOcultoPar"/>
      </td>
    </tr>
    <tr class="blanco"> 
      <td class="claro">
        Forma de pago:
      </td>
      <td class="blanco">
      
        <xsl:if test="FORMASPAGO/field/@current!='999'">
          <xsl:value-of select="FORMAPAGO"/>
          <br/>
        </xsl:if>
        <input type="hidden" name="{FORMASPAGO/field/@name}" value="{FORMASPAGO/field/@current}"/>
        <input type="hidden" name="{PLAZOSPAGO/field/@name}" value="{PLAZOSPAGO/field/@current}"/>
        
        <xsl:value-of select="MO_FORMAPAGO"/>
        
        <input type="hidden" name="MO_FORMAPAGO" value="{MO_FORMAPAGO}" size="30"/>
      </td>
    </tr>
      
    
<!-- **************************************************************************************************************
   |
   |  						DETALLE DE PRODUCTOS
   |
   |			Nota: TODOS los templates  tambien difieren segun el estado.
   + ************************************************************************************************************** --> 
    
<tr bgcolor="#FFFFFF">
 <td colspan="6">  
  <br/><!-- quitar borde -->
  <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td colspan="9">
  <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#015E4B" align="center">
        <xsl:element name="input"> 
          <xsl:attribute name="name">IDDIVISA</xsl:attribute>
          <xsl:attribute name="type">hidden</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="//@current"/></xsl:attribute>
    	</xsl:element>
  
    <tr class="oscuro" align="center">
      <td width="8%" align="center">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0145' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="8%">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0140' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="40%">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0150' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="10%">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0165' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
       
      <td width="10%" class="tituloCamp" align="center">
         <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0740' and @lang=$lang]" disable-output-escaping="yes"/>
       </td> 
      <td width="10%">     
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0155' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      
      <td width="5%">   <!-- Unidades -->
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0160' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="5%">    
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0166' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      
      <td width="5%">	 <!-- Tipo IVA -->
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0175' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td width="10%">   <!-- Importe -->
        <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0170' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
    <td width="4%" class="tituloCamp">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0340' and @lang=$lang]" disable-output-escaping="yes"/>
    </td>
    </tr>
 
 <!--
  |  FOR EACH PARA CADA LINEA DE PRODUCTO 
  |   
  +-->    
 <xsl:for-each select="LINEASMULTIOFERTA/LINEASMULTIOFERTA_ROW">
 <tr>
   <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">claro</xsl:when><xsl:otherwise>blanco</xsl:otherwise></xsl:choose></xsl:attribute>   
  <td>
        <xsl:choose>
          <xsl:when test="REFERENCIA_PRIVADA!=''">
            <xsl:apply-templates select="REFERENCIA_PRIVADA"/>&nbsp;    
          </xsl:when>
          <xsl:otherwise>
            &nbsp;
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:apply-templates select="PRO_REFERENCIA"/>&nbsp;</td>      
      <td>
    <a>
      <xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of select="LMO_IDPRODUCTO"/>','producto',70,50,0,-50)</xsl:attribute>
      <xsl:attribute name="onMouseOver">window.status='Ver detalle del producto';return true;</xsl:attribute>
      <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
      <xsl:value-of select="PRO_NOMBRE"/>
    </a>&nbsp;
  </td>
      <td align="center">
        <!--<i><xsl:apply-templates select="LMO_PRECIOANT"/>&nbsp;</i>-->
        <!--<input type="text" name="PrecioAnt_{LMO_ID}" size="7" maxlength="7" style="text-align:right;" value="{LMO_PRECIOANT}" OnFocus="this.blur();" class="inputOcultoPar"/>-->
        <xsl:choose>
        <xsl:when test="LMO_PRECIO/@TIPO='PUB'">
	  <input type="text" name="PrecioAnt_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:red;" value="{LMO_PRECIOANT}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:when>
	<xsl:when test="LMO_PRECIO/@TIPO='PRV'">
	  <input type="text" name="PrecioAnt_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:blue;" value="{LMO_PRECIOANT}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:when>
	<xsl:otherwise>
	  <input type="text" name="PrecioAnt_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:black;" value="{LMO_PRECIOANT}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:otherwise>                   
      </xsl:choose> 
      </td>
   <td align="center">
     <xsl:choose>
       <xsl:when test="PRO_UNIDADBASICA">
         <xsl:value-of select="PRO_UNIDADBASICA"/>
       </xsl:when>
       <xsl:otherwise>
         &nbsp;
       </xsl:otherwise>
     </xsl:choose>
       
   </td>   
   <!-- en todos los estados mostramos "PRECIO UNITARIO" -->
   <td align="center">
     	<!--<xsl:apply-templates select="LMO_PRECIO"/>&nbsp;-->
     	<!--<input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right" value="{LMO_PRECIO}" OnFocus="this.blur();" class="inputOcultoPar"/>-->
     	<xsl:choose>
        <xsl:when test="LMO_PRECIO/@TIPO='PUB'">
	  <input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:red;" value="{LMO_PRECIO}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:when>
	<xsl:when test="LMO_PRECIO/@TIPO='PRV'">
	  <input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:blue;" value="{LMO_PRECIO}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:when>
	<xsl:otherwise>
	  <input type="text" name="NuevoPrecio_{LMO_ID}" size="8" maxlength="7" style="text-align:right;color:black;" value="{LMO_PRECIO}" OnFocus="this.blur();">
	    <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
	</xsl:otherwise>                   
      </xsl:choose> 
   </td>   
   
   <td align="right">
       <input type="text" name="NuevaCantidad_{LMO_ID}" size="8" maxlength="7" style="text-align:center" value="{LMO_CANTIDAD_SINFORMATO}" onFocus="this.blur();">
         <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
   </td>
<td align="center">
    <xsl:apply-templates select="PRO_UNIDADESPORLOTE"/>&nbsp;
  </td>
   <td align="center">   
       <xsl:if test="LMO_TIPOIVA"><xsl:value-of select="LMO_TIPOIVA"/><!--%--></xsl:if>&nbsp;
   </td>
   
   <td align="right"> 
        <input type="text" name="NuevoImporte_{LMO_ID}" size="12" maxlength="12" style="text-align:right;font-weight:bold;" value="{IMPORTE}" onFocus="this.blur();">
       <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
     </input> 
   </td>
    <td>
      <input type="text" name="divisa_{LMO_ID}" onFocus="this.blur();" size="4" value="{//DIV_SUFIJO}" style="text-align:center">
        <xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2">inputOcultoImpar</xsl:when><xsl:otherwise>inputOcultoPar</xsl:otherwise></xsl:choose></xsl:attribute>  
        </input>
    </td>
  </tr>  
 </xsl:for-each>
</table>

</td>
</tr>	        

	    
<!-- **************************************************************************************************************
   |
   |  						ZONA de TOTALES
   |			
   + ************************************************************************************************************** --> 

    <tr class="blanco"><td colspan="9"><br/></td></tr>    
    <tr class="blanco">
      <td colspan="6" width="60%" valign="top">
       &nbsp;
      </td>
      <td align="right" width="20%">
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0270' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>     
      <td align="right" width="10%">
        <xsl:value-of select="DIV_PREFIJO"/><xsl:apply-templates select="IMPORTE_TOTAL_FORMATO"/>&nbsp;</td>
        <!-- divisa del total -->
          <td width="4%">
            <input type="text" name="divisa_subtotal" onFocus="this.blur();" value="{DIV_SUFIJO}" class="inputOcultoPar" style="text-align:center" size="3"/> 
            &nbsp; 
          </td>
    </tr> 
     
    <tr class="blanco">
      <td colspan="9">&nbsp;</td>
    </tr>    
          
     <xsl:variable name="numeroSpan">7</xsl:variable> 

    <tr class="blanco">      
      <td align="right">
        <xsl:attribute name="colspan"><xsl:value-of select="$numeroSpan"/></xsl:attribute>
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0260' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>     
      <td align="right" width="10%">
        <input type="text" name="MO_DESCUENTOGENERAL" size="6" maxlength="6" style="text-align:right;font-weight:bold;" value="{MO_DESCUENTOGENERAL}" class="inputOcultoBlancoBold" onFocus="this.blur();"/>
        </td>
      <td align="center">%</td>
    </tr>
    
    <tr class="blanco">
      <td align="right">
        <xsl:attribute name="colspan"><xsl:value-of select="$numeroSpan"/></xsl:attribute>    
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0240' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>     
      <td align="right">
        <xsl:value-of select="DIV_PREFIJO"/>
        <xsl:apply-templates select="MO_COSTELOGISTICA"/>
        </td>
      <td align="center">&nbsp;<xsl:value-of select="DIV_SUFIJO"/>&nbsp;</td>
    </tr>
    
    <tr class="blanco"> 
      <td align="right">
        <xsl:attribute name="colspan"><xsl:value-of select="$numeroSpan"/></xsl:attribute>    
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0235' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>       
      <td align="right">
        <xsl:value-of select="DIV_PREFIJO"/><input type="text" name="MO_IMPORTEIVA" size="12" maxlength="12" style="text-align:right;" class="inputOcultoBlancoBold" onFocus="this.blur();" value="{MO_IMPORTEIVA_FORMATO}"/>
        
        </td>      
      <td align="center">&nbsp;<xsl:value-of select="DIV_SUFIJO"/>&nbsp;</td>
    </tr>
    
    <tr class="blanco"> 
      <td align="right">
        <xsl:attribute name="colspan"><xsl:value-of select="$numeroSpan"/></xsl:attribute>      
        <p class="tituloCamp" style="margin-right:10px;"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0230' and @lang=$lang]" disable-output-escaping="yes"/>:</p></td>       
      <td align="right">
        <input type="text" name="IMPORTE_FINAL_PEDIDO" size="12" maxlength="12" style="text-align:right" class="inputOcultoBlancoBold" onFocus="this.blur();" value="{IMPORTE_FINAL_PEDIDO}"/>
        </td>
      <td align="center">&nbsp;<xsl:value-of select="DIV_SUFIJO"/>&nbsp;</td>
    </tr>
 </table>      
</td>
</tr>  

</form>
     
  
<!-- **************************************************************************************************************
   |
   |  						ZONA DE LINEAS DE PAGO
   |					(fecha|forma|importe|comentarios) + Boton Añadir(*)
   |			
   + ************************************************************************************************************** -->       
       
            
   
   <xsl:apply-templates select="LINEASPAGO/LPP_IDPEDIDO"/> 
   <form name="anadir" method="post">
	        <xsl:apply-templates select="MO_IDPEDIDO"/>
	        <xsl:apply-templates select="MO_STATUS"/>       
	        <xsl:apply-templates select="MO_ID"/>       	        
	        <!--<xsl:apply-templates select="BOTONS"/>-->
                <xsl:apply-templates select="/Multioferta/ROL"/>
                <xsl:apply-templates select="/Multioferta/TIPO"/>
              </form>

              


  <!-- **************************************************************************************************************
   |
   |  						ZONA DE NEGOCIACION
   |					     Comentarios de + EMPRESA
   |			
   + ************************************************************************************************************** -->      

 
    <tr class="blanco">
      <td colspan="6">
         <xsl:apply-templates select="NEGOCIACION"/>
       <br/>
      </td>
    </tr>
  
   
<!-- **************************************************************************************************************
   |
   |  						ZONA DE COMENTARIOS
   |					Para Estados que no sean un rechazo
   |			
   + ************************************************************************************************************** -->       
 
      <xsl:if test="(MO_STATUS[.='6'] | MO_STATUS[.='7'] | MO_STATUS[.='10'] | MO_STATUS[.='11'] |MO_STATUS[.='13']) and not(READ_ONLY)" > 
         <form name="comentarios" method="post">  
           <tr class="oscuro">
	      <!-- "Introduzca sus comentarios" + TEXTAREA -->      
	          <td colspan="6" align="center">
	            <xsl:if test="MO_STATUS[.='7']">
	              <xsl:attribute name="bgcolor">#DDDDDD</xsl:attribute>
	            </xsl:if>
		    <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0285' and @lang=$lang]" disable-output-escaping="yes"/>:</p> 
		  </td>
		</tr>
		  <tr class="blanco">
		  <td colspan="6" align="center">
	            <textarea name="NMU_COMENTARIOS" cols="50" rows="3" maxlength="300" onChange="comentariosToForm1(document.forms['comentarios'], document.forms['form1'],'NMU_COMENTARIOS');"/>
	          </td>
	   </tr>
	</form>
     </xsl:if>
     
      <!-- texto: "La aceptacion de este pedido generara una comision de..."      
        <xsl:choose>
         <xsl:when test="MO_STATUS[.='11'] and //ROL[.='V']">
         <tr class="blanco">
           <td colspan="6">
	  <table width="100%" cellpadding="0" cellspacing="0" border="0">
	   <tr align="center" class="blanco">
	    <td>
	      <br/>
	      <p class="nota"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0690' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
	   </tr>
	  </table>
	  </td>
	  </tr>
	 </xsl:when>
        </xsl:choose> 
        -->   
   </table>
   
   <br/>
   <br/>  
	  <table width="100%" border="0">
	    <tr align="center">
 	      <td>
 	        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0760' and @lang=$lang]" disable-output-escaping="yes"/>
 	        <br/><br/>
 	      </td>
 	    </tr>
 	  </table>
   
 
	<table width="100%" border="0">
	  <tr align="center">        
 	    <td width="25%">
 	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='AceptacionPendiente']"/>
 	      </xsl:call-template>
 	    </td>
	    <td width="25%">
	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='RechazarPedido']"/>
 	      </xsl:call-template>
	    </td>
	    <td width="25%">
	      <xsl:apply-templates select="//Multioferta/BOTONS/button[2]"/>
	      <xsl:call-template name="boton">
 	        <xsl:with-param name="path" select="//Multioferta/BOTONS_NUEVO/button[@label='AceptarPedido']"/>
 	      </xsl:call-template>
	    </td>  
	  </tr>
	</table>
</xsl:template>

 <!-- **************************************************************************************************************
   |
   |  						TEMPLATES
   |
   |			
   + ************************************************************************************************************** --> 

<!--
 | NEGOCIACION
 |
 + -->  
<xsl:template match="NEGOCIACION">    
  <br/>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="muyoscuro">
    <tr>
      <td colspan="2" class="oscuro">
        Negociación
      </td>
    </tr>
  <xsl:for-each select="NEGOCIACION_ROW">
    <tr>
      <xsl:choose> 
        <xsl:when test="not(@COL='A')"> <!-- caso de COLor='B' o no informado -->
          <xsl:attribute name="class">blanco</xsl:attribute>
        </xsl:when>
        <xsl:otherwise> <!-- caso de COLor='B' o no informado -->
          <xsl:attribute name="class">claro</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <td valign="top" width="25%"> 
        <p class="tituloCamp">
	  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0280' and @lang=$lang]" disable-output-escaping="yes"/><xsl:value-of select="EMPRESA"/>:&nbsp;
	  <br/>
	  (<xsl:value-of select="NMU_FECHA"/>) 	  
	</p>
      </td>
      <td>   
        &nbsp;<xsl:copy-of select="NMU_COMENTARIOS"/>                        
      </td>  
    </tr>
  </xsl:for-each>                     
  </table>
  
</xsl:template>

<xsl:template match="IMPORTE_TOTAL_FORMATO">
      <input type="text" name="MO_SUBTOTAL" size="12" maxlength="12" style="text-align:right;" value="{.}" class="inputOcultoBlancoBold" onFocus="this.blur();"/>
</xsl:template>

<xsl:template match="MO_COSTELOGISTICA">
  <input type="text" name="MO_COSTELOGISTICA" size="12" maxlength="12" style="text-align:right;font-weight:bold;">
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
    <xsl:attribute name="onFocus">this.blur();</xsl:attribute>
    <xsl:attribute name="class">inputOcultoBlancoBold</xsl:attribute>
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

<xsl:template match="TIPO">
  <input type="hidden" name="TIPO">
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

  <xsl:template match="fieldTipoIVA">
  <xsl:variable name="IDAct" select="$IDAct"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="../@name"/><xsl:value-of select="../LMO_IDPRODUCTO"/></xsl:attribute>
      <xsl:attribute name="onChange">actualizaIVA('<xsl:value-of select="../LMO_IDPRODUCTO"/>',this.options[this.selectedIndex].value)</xsl:attribute>
      <xsl:for-each select="listElem">
      <xsl:value-of select="$IDAct"/>
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  <xsl:template name="fieldTipoIVA_funcion">
    <xsl:param name="path"/>
    <xsl:param name="IDAct"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="$path/../@name"/><xsl:value-of select="$path/../LMO_IDPRODUCTO"/></xsl:attribute>
      <xsl:attribute name="onChange">actualizaIVA('<xsl:value-of select="$path/../LMO_IDPRODUCTO"/>',this.options[this.selectedIndex].value)</xsl:attribute>
      <xsl:for-each select="$path/listElem">
      <xsl:value-of select="$IDAct"/>
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  <xsl:template name="direccion">
    <xsl:param name="path"/>
    <xsl:value-of select="$path/EMP_DIRECCION"/>
    <br/>
    <xsl:value-of select="$path/EMP_CPOSTAL"/>-<xsl:value-of select="$path/EMP_POBLACION"/>
    <br/>
    <xsl:value-of select="$path/EMP_PROVINCIA"/>
    <br/><br/>
    <xsl:choose>
      <xsl:when test="$path/EMP_TELEFONO!=''">
        telf:&nbsp;<xsl:value-of select="$path/EMP_TELEFONO"/>
      </xsl:when>
      <xsl:otherwise>
        &nbsp;
      </xsl:otherwise>
    </xsl:choose>
    <br/>
    <xsl:choose>  
      <xsl:when test="$path/EMP_FAX!=''">
    fax:&nbsp;<xsl:value-of select="$path/EMP_FAX"/>
    </xsl:when>
    <xsl:otherwise>
        &nbsp;
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="direccionCentro">
    <xsl:param name="path"/>
    <xsl:value-of select="$path/CEN_DIRECCION"/>
    <br/>
    <xsl:value-of select="$path/CEN_CPOSTAL"/>-<xsl:value-of select="$path/CEN_POBLACION"/>
    <br/>
    <xsl:value-of select="$path/CEN_PROVINCIA"/>
    <br/><br/>
    <xsl:choose>
      <xsl:when test="$path/CEN_TELEFONO!=''">
        telf:&nbsp;<xsl:value-of select="$path/CEN_TELEFONO"/>
      </xsl:when>
      <xsl:otherwise>
        &nbsp;
      </xsl:otherwise>
    </xsl:choose>
    <br/>
    <xsl:choose>  
      <xsl:when test="$path/CEN_FAX!=''">
    fax:&nbsp;<xsl:value-of select="$path/CEN_FAX"/>
    </xsl:when>
    <xsl:otherwise>
        &nbsp;
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
