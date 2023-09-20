<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |Fichero: 
 |Descripcion: 
 |Funcionamiento: 
 |		  Mostramos el contrato
 |
 |Modificaciones:
 |Fecha		Autor		Modificacion
 |
 |
 |
 |Situacion: __Modificacion__
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
        <title>Contrato</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
        <!--
        
         function actualizarChecks(form,checkBox){
           for(var i=0;i<form.length;i++){
             if(checkBox.name=='ACEPTAR_CONTRATO1')
               form.elements['ACEPTAR_CONTRATO2'].checked=checkBox.checked;
             else
               form.elements['ACEPTAR_CONTRATO1'].checked=checkBox.checked;
           }
           
         }
        
         function validarContrato(form){
           if (form.elements['ACEPTAR_CONTRATO1'].checked==false) 
	    alert('Para continuar con el proceso de alta debe seleccionar la casilla de aceptación del contrato.\n\n                        Gracias.');
	   else 
	     SubmitForm(document.forms[0]);
         }
         			
         -->
	</script>
        ]]></xsl:text>
        
        <STYLE>
          .tituloPagForm {COLOR: #015e4b; FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; FONT-SIZE: 14pt; FONT-WEIGHT: bold}
          .tituloForm {COLOR: #015e4b; FONT-SIZE: 10pt; FONT-WEIGHT: bold}
          .subTituloForm {COLOR: #018167; FONT-SIZE: 9pt; FONT-WEIGHT: bold}      
          .textoForm {COLOR: #000000; FONT-SIZE: 10pt; FONT-WEIGHT: bold}
          .textoLegal {COLOR: #000000; FONT-SIZE: 7pt}
        </STYLE>
      </head>
      <body bgcolor="#FFFFFF" marginwidth="0" marginheight="0">  
      <form name="form1" action="./FormContratoSave.xsql" method="post">    
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloForm">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>
            
            <table width="100%" border="0" >
             <tr>
              <td><p align="center"><font size="+0">
                A continuación deberá aceptar el contrato de afiliación de Medical Virtual Market, <br/>que presenta las 
                condiciones de servicio ofrecidas a los usuarios.
                </font>
                </p>
              </td> 
             </tr>
             <tr><td>
                <table width="100%" border="0">
                  <tr>
                    <td width="35%">
                      &nbsp;
                    </td>
                    <td width="15%">
                      &nbsp;
                    </td>
                    <td width="15%">
                      &nbsp;
                    </td>
                    <td align="center" width="35%">
                      <input type="checkBox" name="ACEPTAR_CONTRATO1" onClick="actualizarChecks(document.forms[0],this);"><font size="2"><b>Sí, acepto el contrato.</b></font></input>
                    </td>
                  </tr>
                  <tr>
                    <td align="center" width="35%">
	              <input type="button" name="anterior" value="Anterior" onClick="history.go(-1)"/>
	            </td>
                    <td width="15%">
	              <input type="hidden" name="CODIGO_ALTA">
	                <xsl:attribute name="value"><xsl:value-of select="Contrato/CODIGO_ALTA"/></xsl:attribute>
	              </input>
	            </td>
                    <td width="15%">
                      <input type="hidden" name="CONTRATO" value="OK"/>
                    </td>
                    <td align="center" width="35%">
	              <input type="button" name="CONTINUAR" value="Continuar" onClick="validarContrato(document.forms[0]);"/>
	            </td>
                  </tr>
                </table>
              </td></tr>
            
              <tr class="tituloPagForm" height="60pt">
                <td align="center">
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVG-0296' and @lang=$lang]" disable-output-escaping="yes"/><br/><br/>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="1" cellpadding="20" bgcolor="#000000" bordercolor="#eeffff">
                    <tr bgcolor="#eeffff">
                      <td bgcolor="#eeffff">
                       <DIV align="justify"> <font size="2"><b>
                        1. CONDICIONES GENERALES Y SU ACEPTACIÓN 
                        <br/>
                        <br/>
                        <P>Estas condiciones generales (en adelante, las "Condiciones  Generales") regulan el uso del servicio de Medical
                         VM (en adelante, MVM) que MEDICAL VIRTUAL MARKET S.L. (en adelante, "MEDICALVM") pone gratuitamente a disposición
                         de los usuarios de Internet.</P>
                        <P>La utilización del sistema atribuye la condición de usuario de MEDICALVM (en adelante, el "Usuario ") y expresa la 
                        aceptación plena y sin reservas del Usuario de todas y cada una de las Condiciones Generales en la versión publicada
                         por MEDICALVM en el momento mismo en que el Usuario acceda al sistema.</P>  

                        <P>Asimismo, la utilización del Servicio se encuentra sometida igualmente a todos los avisos, reglamentos de uso e instrucciones
                          puestos en conocimiento del Usuario por MEDICALVM, que completan lo previsto en estas Condiciones Generales en cuanto no se 
                          opongan a ellas. </P>
                         <br/>
                         <br/>
                         2. OBJETO
                         <br/>
                         <br/>
                         <P>A través del sistema, MVM facilita a los Usuarios el acceso  y la utilización de diversos servicios y contenidos puestos
                          a disposición de los Usuarios por MVM o por terceros usuarios del sistema y/o terceros proveedores de servicios y contenidos
                           (en adelante, los "Servicios").</P> 
                           
                           <P>MVM se reserva el derecho a modificar unilateralmente, en cualquier momento y sin aviso previo, 
                           la presentación y configuración del sistema, así como los servicios y las condiciones  requeridas para utilizar el sistema y los 
                           servicios.</P>
                         <br/>
                         <br/>      
                         3. CONDICIONES DE ACCESO Y UTILIZACIÓN DE MEDICALVM
                         <br/>
                         <br/>
                         </b></font>


        <OL TYPE="I">
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Que MEDICAL 
              VIRTUAL MARKET, S.L. en adelante &quot;MEDICALVM&quot; es una compañía 
              dedicada a la creación y mantenimiento de programas para Internet 
              destinados a la comercialización de productos de toda índole.</SPAN></FONT></DIV>    
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Que se define 
              como MEDICALVM la plataforma medicalvm.com propiedad de MEDICALVM, 
              S.L.</SPAN></FONT></DIV>   
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;agente&quot; a toda persona física o jurídica, representante 
              de una empresa o no, al cual MEDICALVM le ha autorizado por escrito 
              el acceso a MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;Comprador&quot; a todo agente que compre un producto 
              o servicio a través de MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;Vendedor&quot; a todo agente que venda un producto o 
              servicio a través de MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              se reserva el derecho a definir aquellos casos en que un agente 
              sea al mismo tiempo Comprador y Vendedor.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;Web&quot; toda ubicación colocada en Internet.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;off-line&quot; a toda comunicación realizada fuera de 
              la plataforma MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;on-line&quot; a todo comunicación realizada dentro de 
              la plataforma MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como PAP (petición de aceptación de pedido) la solicitud de un Comprador 
              a un Vendedor de aceptar un pedido.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como transacción el momento en que un Vendedor confirma una PAP.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;link&quot; todo enlace situado en MEDICALVM que da acceso 
              a otra web.</SPAN></FONT></DIV>
           </LI>
           </P>
         </OL> 
         
         
         <!-- empieza aqui-->
         <BR/><BR/>
         
         <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">PRIMERO.- 
          ACCESO:</SPAN></FONT></b></P>

        <OL TYPE="a">
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              es la única entidad con autorización para dar acceso a un agente 
              a MEDICALVM.</SPAN></FONT></div>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Toda solicitud 
              de acceso a MEDICALVM se transmitirá directamente al servicio comercial 
              de MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
        </OL>
        <OL START="3" TYPE="a">
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              se reserva el derecho de admisión de un agente.</SPAN></FONT></div>
          </LI>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              se reserva el derecho a revocar el acceso a un agente.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              realiza una evaluación de todos los agentes en el momento de la<B> 
              </B>afiliación<B>.</B></SPAN></FONT></div>
          </LI></P></P>
        </OL>
    
   <!--  hasta aqui-->     
        <BR/><BR/>
        <FONT SIZE="2"> 
        <P ALIGN="JUSTIFY"></P>
        <B> 
        <P ALIGN="JUSTIFY"><SPAN class="textoForm">SEGUNDO.- USOS PROHIBIDOS:</SPAN></P>
        </B> </FONT>
        <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM se reserva 
          el derecho a visualizar contenidos para detectar usos indebidos del 
          sistema, incluidos pero no limitados a:</SPAN></FONT></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">utilizar 
              claves de acceso falsas o transmitir mensajes anónimos</SPAN></FONT></div>
          </LI>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">facilitar 
              información privada sobre personas</SPAN></FONT></div>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">venta de 
              material robado</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">introducción 
              de información falsa, manipulación de precios, falsas ofertas</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">introducción 
              de virus</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">inserción 
              no autorizada de links a otras Web.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">fabricación 
              o distribución de software, productos, servicios o datos técnicos, 
              a través de MEDICALVM a ningún país, dónde tal fabricación o distribución 
              sea ilegal.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI>
          </P></P>
        </UL>
        <FONT SIZE="2"><B><U> 
        <P ALIGN="JUSTIFY"></P>
        </U></B></FONT> 
        
        
        
        
        <!--hasta aqui-->
        
        
        
        
        <BR/><BR/>
        <P ALIGN="JUSTIFY"><SPAN class="textoForm">TERCERO.- AVISOS Y SUSPENSOS:</SPAN></P>
       
        <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM se reserva 
          el derecho a avisar, suspender o revocar el acceso a cualquier usuario, 
          en los casos que, incluye pero no limita a :</SPAN></FONT></P>

        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">por usos 
              indebidos descritos en la cláusula 2ª o cualquier otro que considere 
              MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">se detecte 
              que infringe el acuerdo.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">no se puedan 
              comprobar sus datos de agente</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">pueda causar 
              daño a si mismo o a terceros.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P>
        <BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">CUARTO.- 
          TARIFAS:</SPAN></FONT></b></P>

        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              se reserva el derecho a modificar su política de tarifas siempre 
              que un contrato privado anterior no lo impida.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">El acceso 
              a MEDICALVM y la utilización de los servicios de mediación, son 
              de uso gratuito para todo Comprador.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              facturará un porcentaje por transacción a todo Vendedor.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Las tarifas 
              sobre porcentajes por transacción serán el objeto de un contrato 
              privado entre el Vendedor y MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">En el caso 
              de no existir tal contrato se aplicarán las tarifas generales.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">QUINTO.- 
          OPERACION INTENCIONADAMENTE INCOMPLETA:</SPAN></FONT></b></P>
        <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">Dado el elevado 
          valor de los servicios aportados, MEDICALVM se reserva el derecho a 
          revocar temporalmente o indefinidamente el acceso de un agente que intente 
          evadir las tarifas de MEDICALVM así como reclamarla por daños y perjuicios 
          si los hubieren.</SPAN></FONT></P>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">SEXTO.- NATURALEZA 
          DE MEDICALVM. FUNCIONAMIENTO:</SPAN></FONT></b></P>

        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              actúa únicamente como intermediario de la transacción entre Comprador 
              y Vendedor, sin ser parte de aquella.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">A causa de 
              la imposibilidad de visualizar todas y cada uno de los contenidos 
              introducidos en MEDICALVM, MEDICALVM queda exonerada de cualquier 
              tipo de responsabilidad sobre la información difundida, control 
              de calidad, seguridad o legalidad de los datos de los productos 
              o servicios contenidos en MEDICALVM y por consiguiente en ningún 
              caso MEDICALVM avala, garantiza o representa dichos productos o 
              servicios. </SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">En caso de 
              detectar por parte de un agente información incorrecta se notificará 
              a MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Toda información 
              sobre productos o servicios contenidos en MEDICALVM es información 
              aportada por el Vendedor y en ningún caso MEDICALVM avala, garantiza 
              o representa dichos productos o servicios no siendo por tanto responsable 
              de la difusión de los mismos ni de los actos que se deriven a raíz 
              de dicha información ni la veracidad, legitimidad y legalidad.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MedicalVM 
              se reserva el derecho de poner a disposición de todo Comprador el 
              servicio de &quot;Urgencias&quot;, el cual permite a todo Comprador 
              alertar a un Vendedor sobre su necesidad de un producto o servicio. 
              Además del canal usual de MedicalVM, MedicalVM podrá enviar mensajes 
              de alerta al Vendedor vía otros sistemas; ejemplos son Fax, Mail 
              y teléfono Móvil. MedicalVM no es responsable del correcto e ininterrumpido 
              funcionamiento del servicio de &quot;Urgencias&quot; , ni de la 
              compatibilidad y/o del correcto e ininterrumpido funcionamiento 
              de los sistemas del Vendedor.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P>
        
        
        
        <!-- hasta aqui -->
        
        
        
        <BR/><BR/>
        <P ALIGN="JUSTIFY"><FONT size="2"><b><SPAN class="textoForm">SEPTIMO.- 
          TRANSPORTE Y PAGO:</SPAN></b></FONT></P>

        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no es responsable ni se hace cargo del transporte de los productos 
              o de la realización de los servicios.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no es responsable ni se hace cargo del pago de los productos o servicios.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Cualquier 
              reclamación sobre la transacción deberá hacerse directamente entre 
              los agentes implicados en ella exonerando a MEDICALVM de cualquier 
              tipo de responsabilidad.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><FONT size="2"><b><SPAN class="textoForm">OCTAVO.- 
          ERRORES U OMISIONES.</SPAN></b></FONT></P>
        
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no es responsable de los errores u omisiones que puedan aparecer 
              en MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no es responsable del incumplimiento o cumplimiento defectuoso de 
              la transacción.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P>
        
        
        
        
        <!-- hasta aqui-->
        
        
        
        <BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">NOVENO.- 
          FUNCIONAMIENTO.</SPAN></FONT></b></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no garantiza el funcionamiento ininterrumpido de MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no garantiza la seguridad en el acceso a MEDICALVM. El agente es 
              responsable de tomar las medidas de seguridad oportunas, controlar 
              la veracidad de los datos y recuperar la posible información perdida.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no está autorizado a dar ni da consejos médicos. Cualquier información 
              ligada a un producto o servicio debe considerarse únicamente informativa. 
              MEDICALVM no suplanta en ningún caso al médico.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">DECIMO.- 
          CONFIRMACIÓN DE UNA PAP (Petición de aceptación de un pedido):</SPAN></FONT></b></P>
        <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">A partir de la 
          confirmación de una PAP de un comprador, por un vendedor, dicha PAP 
          será considerada como un pedido en firme a todos sus efectos.</SPAN></FONT></P>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">DECIMOPRIMERO.- 
          MODIFICACIÓN DE LOS DATOS:</SPAN></FONT></b></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Todo Vendedor 
              tendrá el control de la información introducida y podrá modificarla 
              libremente desde su acceso a MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              ofrece el servicio de introducción de bases de datos.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><FONT size="2"><b><SPAN class="textoForm">DECIMOSEGUNDO.- 
          SEGURIDAD:</SPAN></b></FONT></P>
        <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM es una 
          web de alta seguridad que cuenta con personal extra dedicado a proteger 
          la información personal y transaccional, vigilado las 24 horas, 7 días 
          por semana, siendo encriptadas todas las transacciones e informaciones 
          personales, sin embargo, tal y como ya se ha manifestado, MEDICALVM 
          no se hace responsable de la veracidad y legalidad de los contenidos.</SPAN></FONT></P>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">DECIMOTERCERO.- 
          LINKS A OTRAS WEBS:</SPAN></FONT></b></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              puede contener links hace otras Webs.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no se hace responsable de las prácticas privadas o de los contenidos 
              de las Webs a las que se accede a través de MEDICALVM.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><br/><br/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">DECIMOCUARTO.- 
          DATOS PERSONALES.</SPAN></FONT></b></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Para dar 
              de alta a un agente MEDICALVM precisará de datos personales del 
              agente.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">En el caso 
              de que MEDICCALVM compartiese servicios con otras empresas y necesitase 
              también compartir estos datos el agente será notificado con antelación.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P>
        
        
        <!-- hasta aqui -->
        
        <BR/><BR/>
        <P ALIGN="JUSTIFY"><FONT size="2"><b><SPAN class="textoForm">DECIMOQUINTO.- 
          PROPIEDAD INTELECTUAL:</SPAN></b></FONT></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Todo el sistema 
              y contenido de MEDICALVM ha sido registrado en propiedad de MEDICALVM 
              y no deberá utilizarse fuera de MEDICALVM a menos que la Ley lo 
              permita.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">En el caso 
              de que MEDICALVM comparta la propiedad de sistemas o datos con otra 
              empresa asociada las futuras mejoras de dichos sistemas o datos 
              será también compartida bajo las condiciones acordadas por escrito.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><FONT size="2"><b><SPAN class="textoForm">DECIMOSEXTO.- 
          LICENCIA:</SPAN></b></FONT></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              garantiza a todo agente una licencia de MEDICALVM para su uso personal, 
              no transferible de acuerdo con las condiciones y cláusulas de este 
              contrato, y para ningún otro fin o propósito.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <FONT SIZE="2">
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <B> 
        <P ALIGN="JUSTIFY"><SPAN class="textoForm">DECIMOSÉPTIMO.- POLÍTICA DE 
          PRIVACIDAD:</SPAN></P>
        </B></FONT><FONT SIZE="2"><B></B></FONT> 
        <div align="left">
          <OL TYPE="a">
          </OL>
        </div>
        <OL TYPE="a">
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Datos agregados:</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <div align="left">
            <UL>
            </UL>
          </div>
          <UL>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
                podrá utilizar información agregada contenida en MEDICALVM.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Esta información 
                será propiedad de MEDICALVM.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
          </UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Datos individuales: 
              Conforme la Ley de protección de datos:</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM no 
            podrá difundir información unitaria sobre un agente tales como:</SPAN></FONT></P>
          <div align="left">
            <UL>
            </UL>
          </div>
          <UL>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Precios</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Productos</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Clientes 
                y Proveedores</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Cualquier 
                información económica o estratégica.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Condiciones 
                especiales de MEDICALVM (tarifas, descuentos, etc…).</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Información 
                sobre la empresa del agente.</SPAN></FONT></div>
              <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
            <P></P>
          </UL> 
            
          <P ALIGN="JUSTIFY"><SPAN class="textoForm">A menos que:</SPAN></P>
          <div align="left">
            <UL>
            </UL>
          </div>
          <UL>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">el agente 
                lo autorice por escrito.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">la utilización 
                sea de buena fe y bajo el respeto de la Ley.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Para reforzar 
                los derechos de MEDICALVM en la aplicación de este contrato.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">para proteger 
                los derechos de MEDICALVM o terceros.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
          </UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">HONCode:</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <div align="left">
            <UL>
            </UL>
          </div>
          <UL>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
                suscribe los principios de HONCode (Health On the Net Foundation).</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
                se compromete a mantener la más alta confidencialidad entre sus 
                agentes.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
          </UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Anuncios:</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <div align="left">
            <UL>
            </UL>
          </div>
          <UL>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
                podrá publicar la lista de empresas compradoras y vendedoras contenidas 
                en MEDICALVM si aquellas lo autorizan.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
                podrá utilizar el e-mail de un agente para:</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <div align="left">
              <UL>
              </UL>
            </div>
            <UL>
              <P ALIGN="left"> 
              <LI>
                <div align="left"><FONT size="2"><SPAN class="textoForm">comunicarse 
                  con él.</SPAN></FONT></div>
              </LI></P>
              <P align="left"></P>
              <P ALIGN="left"> 
              <LI>
                <div align="left"><FONT size="2"><SPAN class="textoForm">hacer 
                  saber a un Comprador que su PAP ha sido aceptada.</SPAN></FONT></div>
              </LI></P>
              <P align="left"></P>
              <P ALIGN="left"> 
              <LI>
                <div align="left"><FONT size="2"><SPAN class="textoForm">hacer 
                  saber a un Vendedor que su oferta ha sido aceptada.</SPAN></FONT></div>
              </LI></P>
              <P align="left"></P>
              <P ALIGN="left"> 
              <LI>
                <div align="left"><FONT size="2"><SPAN class="textoForm">confirmar 
                  registro de un agente en MEDICALVM.</SPAN></FONT></div>
                <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
            </UL>
          </UL> 
            <blockquote> 
              <P>&nbsp;</P>
            </blockquote>
          </OL>
          
          
          
          <!-- hasta aqui -->
          
          
          <BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>DECIMOOCTAVO.- 
          MODIFICACIÓN DE CLÁUSULAS:</B></FONT></SPAN></P>
        <div align="left">
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P ALIGN="left"> </P>
          </UL>
        </OL>
        <div align="left">
          <ul>
            <li><SPAN class="textoForm"><FONT SIZE="2">MEDICALVM se reserva el derecho 
              a modificar las cláusulas de este contrato.</FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P align="left"></P>
            <P ALIGN="left"> </P>
          </UL>
        </OL>
        <div align="left">
          <ul>
            <li><SPAN class="textoForm"><FONT SIZE="2">Estas modificaciones se comunicarán 
              con un mes de antelación por escrito a todos los agentes.</FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P align="left"></P>
            <P ALIGN="left"></P> 
          </UL>
        </OL>
        <div align="left">
          <ul>
            <li><SPAN class="textoForm"><FONT SIZE="2">Estas modificaciones entrarán 
              en vigor a partir de que el agente entre en el sistema.</FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P align="left"></P>
            <P ALIGN="left"> </P>
          </UL>
        </OL>
        <div align="left">
          <ul>
            <li><SPAN class="textoForm"><FONT SIZE="2">El agente se compromete a 
              revisar periódicamente este contrato.</FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P align="left"></P>
          </UL>
          <P ALIGN="left"></P>
        </OL><BR/><BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>DECIMONOVENO.- 
          ERRORES:</B></FONT></SPAN></P>
          
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2">En el caso de detectarse 
          errores u omisiones, o no estar alguna de las cláusulas de acuerdo con 
          Ley vigente del país, dichos errores no desvirtuaran el contrato teniendo 
          plena vigencia las cláusulas correctas. Asimismo, de detectarse errores, 
          MEDICALVM modificará dichas cláusulas.</FONT></SPAN></P>
        <div align="left">
          <OL TYPE="a">
          </OL>
        </div>
        <OL TYPE="a">
          <P ALIGN="left"></P>
          <P ALIGN="left">&nbsp;</P> 
          </OL>
          <BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMO.- NO 
          RENUNCIA.</B></FONT></SPAN></P>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2">MEDICALVM se reserva 
          el derecho a no ejercer alguna de las cláusulas de este contrato sin 
          que ello signifique que MEDICALVM renuncie a ellas.</FONT></SPAN></P>
        <P align="left">&nbsp;</P>
          <BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOPRIMERO.- 
          SUCESION.</B></FONT></SPAN></P>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2">Este</FONT> <FONT SIZE="2">contrato</FONT> 
          se aplicará a todo sucesor legal del agente firmante.</SPAN></P>
        <div align="left">
          <OL TYPE="a">
          </OL>
        </div>
        <OL TYPE="a">
          <P ALIGN="left"></P>
        </OL><BR/><BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIOMOSEGUNDO.- 
          PLAZO DE VIGENCIA:</B></FONT></SPAN></P>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2">Este contrato tiene 
          carácter indefinido y estará vigente hasta que alguna de las partes 
          notifique mediante correo ordinario su voluntad de resolución.</FONT></SPAN></P>
        <P align="left">&nbsp;</P><BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOTERCERO.- 
          DEVENGO Y FORMA DE PAGO:</B></FONT></SPAN></P>
        <div align="left">
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P ALIGN="left"></P> 
          </UL>
        </OL>
        <div align="left">
          <ul>
            <li><SPAN class="textoForm"><FONT SIZE="2">MEDICALVM facturará al Vendedor 
              en el momento en que el Vendedor confirme la PAP de un Comprador, 
              con un vencimiento acordado en el contrato privado entre el Vendedor 
              y MEDICALVM, en momento y formas negociadas.</FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P align="left"></P>
            <P ALIGN="left"></P> 
          </UL>
        </OL>
        <div align="left">
          <ul>
            <li><SPAN class="textoForm"><FONT SIZE="2">El pago será obligado en 
              los mencionados plazos y formas, con independencia de las condiciones 
              de entrega y pago pactadas entre Comprador y Vendedor. </FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
          </OL>
        </div><BR/><BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOCUARTO.- 
          FACTURACIÓN:</B></FONT></SPAN></P>
        <div align="left">
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P ALIGN="left"> </P>
          </UL>
        </OL>
        <div align="left">
          <ul>
            <li><SPAN class="textoForm"><FONT SIZE="2">MEDICALVM enviará al Vendedor 
              por correo ordinario una factura semanal que contendrá las transacciones 
              (PAP) confirmadas y realizadas durante dicho periodo.</FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
            <UL>
            </UL>
          </OL>
        </div>
        <OL TYPE="a">
          <UL>
            <P align="left"></P>
            <P ALIGN="left"> </P>
          </UL>
        </OL>
        <div align="left">
          <ul>
            <li><SPAN class="textoForm"><FONT SIZE="2">El Vendedor dispondrá de 
              una cuenta on-line con toda la información relacionada con cada 
              transacción realizada.</FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
          </OL>
        </div>
        <OL TYPE="a">
          <P ALIGN="left"></P>
        </OL><BR/><BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOQUINTO.- 
          RESOLUCIÓN DE CONFLICTOS:</B></FONT></SPAN></P>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2">Para cualquier duda 
          o divergencia que surgiera en la interpretación y aplicación del presente 
          contrato, con renuncia a su fuero si lo tuvieren, ambas partes se someten 
          a los Juzgados y Tribunales de Barcelona.</FONT></SPAN></P>

            
           <br/><br/> 
         <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOSEXTO.- CLAVES DE ACCESO:</B></FONT>
         </SPAN></P><P align="left"><SPAN class="textoForm"><FONT SIZE="2">
             A la firma de este contrato se entregarán las claves de acceso correspondientes, 
             las cuales tienen una duración de 6 meses y serán renovadas automáticamente, 
             sino presenta objeciones ninguna de las dos partes.</FONT></SPAN></P>

            
          <!-- hasta aqui -->
        <br/><br/><br/>  
                    
<!-- fin aqui -->

</DIV>
           
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <br/><br/>
                </td>
              </tr>
              <tr>
                <table width="100%" border="0">
                  <tr>
                    <td width="35%">
                      &nbsp;
                    </td>
                    <td width="15%">
                      &nbsp;
                    </td>
                    <td width="15%">
                      &nbsp;
                    </td>
                    <td align="center" width="35%">
                      <input type="checkBox" name="ACEPTAR_CONTRATO2" onClick="actualizarChecks(document.forms[0],this);"><font size="2"><b>Sí, acepto el contrato.</b></font></input>
                    </td>
                  </tr>
                  <tr>
                    <td align="center" width="35%">
	              <input type="button" name="anterior" value="Anterior" onClick="history.go(-1)"/>
	            </td>
                    <td width="15%">
	              <input type="hidden" name="CODIGO_ALTA">
	                <xsl:attribute name="value"><xsl:value-of select="Contrato/CODIGO_ALTA"/></xsl:attribute>
	              </input>
	            </td>
                    <td width="15%">
                      <input type="hidden" name="CONTRATO" value="OK"/>
                    </td>
                    <td align="center" width="35%">
	              <input type="button" name="CONTINUAR" value="Continuar" onClick="validarContrato(document.forms[0]);"/>

	            </td>
                  </tr>
                </table>
              </tr>
            </table>
	    
          </xsl:otherwise>
        </xsl:choose>
        </form>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="Contrato">
  [X] aceptar Contrato
</xsl:template>

</xsl:stylesheet>



<!--  

                         

-->