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
	    alert('Para continuar con el proceso de alta debe seleccionar la casilla de aceptaci�n del contrato.\n\n                        Gracias.');
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
                A continuaci�n deber� aceptar el contrato de afiliaci�n de Medical Virtual Market, <br/>que presenta las 
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
                      <input type="checkBox" name="ACEPTAR_CONTRATO1" onClick="actualizarChecks(document.forms[0],this);"><font size="2"><b>S�, acepto el contrato.</b></font></input>
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
                        1. CONDICIONES GENERALES Y SU ACEPTACI�N 
                        <br/>
                        <br/>
                        <P>Estas condiciones generales (en adelante, las "Condiciones  Generales") regulan el uso del servicio de Medical
                         VM (en adelante, MVM) que MEDICAL VIRTUAL MARKET S.L. (en adelante, "MEDICALVM") pone gratuitamente a disposici�n
                         de los usuarios de Internet.</P>
                        <P>La utilizaci�n del sistema atribuye la condici�n de usuario de MEDICALVM (en adelante, el "Usuario ") y expresa la 
                        aceptaci�n plena y sin reservas del Usuario de todas y cada una de las Condiciones Generales en la versi�n publicada
                         por MEDICALVM en el momento mismo en que el Usuario acceda al sistema.</P>  

                        <P>Asimismo, la utilizaci�n del Servicio se encuentra sometida igualmente a todos los avisos, reglamentos de uso e instrucciones
                          puestos en conocimiento del Usuario por MEDICALVM, que completan lo previsto en estas Condiciones Generales en cuanto no se 
                          opongan a ellas. </P>
                         <br/>
                         <br/>
                         2. OBJETO
                         <br/>
                         <br/>
                         <P>A trav�s del sistema, MVM facilita a los Usuarios el acceso  y la utilizaci�n de diversos servicios y contenidos puestos
                          a disposici�n de los Usuarios por MVM o por terceros usuarios del sistema y/o terceros proveedores de servicios y contenidos
                           (en adelante, los "Servicios").</P> 
                           
                           <P>MVM se reserva el derecho a modificar unilateralmente, en cualquier momento y sin aviso previo, 
                           la presentaci�n y configuraci�n del sistema, as� como los servicios y las condiciones  requeridas para utilizar el sistema y los 
                           servicios.</P>
                         <br/>
                         <br/>      
                         3. CONDICIONES DE ACCESO Y UTILIZACI�N DE MEDICALVM
                         <br/>
                         <br/>
                         </b></font>


        <OL TYPE="I">
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Que MEDICAL 
              VIRTUAL MARKET, S.L. en adelante &quot;MEDICALVM&quot; es una compa��a 
              dedicada a la creaci�n y mantenimiento de programas para Internet 
              destinados a la comercializaci�n de productos de toda �ndole.</SPAN></FONT></DIV>    
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
              como &quot;agente&quot; a toda persona f�sica o jur�dica, representante 
              de una empresa o no, al cual MEDICALVM le ha autorizado por escrito 
              el acceso a MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;Comprador&quot; a todo agente que compre un producto 
              o servicio a trav�s de MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;Vendedor&quot; a todo agente que venda un producto o 
              servicio a trav�s de MEDICALVM.</SPAN></FONT></DIV>
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
              como &quot;Web&quot; toda ubicaci�n colocada en Internet.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;off-line&quot; a toda comunicaci�n realizada fuera de 
              la plataforma MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como &quot;on-line&quot; a todo comunicaci�n realizada dentro de 
              la plataforma MEDICALVM.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como PAP (petici�n de aceptaci�n de pedido) la solicitud de un Comprador 
              a un Vendedor de aceptar un pedido.</SPAN></FONT></DIV>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <DIV align="left"><FONT size="2"><SPAN class="textoForm">Se define 
              como transacci�n el momento en que un Vendedor confirma una PAP.</SPAN></FONT></DIV>
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
              es la �nica entidad con autorizaci�n para dar acceso a un agente 
              a MEDICALVM.</SPAN></FONT></div>
          </LI>
          </P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Toda solicitud 
              de acceso a MEDICALVM se transmitir� directamente al servicio comercial 
              de MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
        </OL>
        <OL START="3" TYPE="a">
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              se reserva el derecho de admisi�n de un agente.</SPAN></FONT></div>
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
              realiza una evaluaci�n de todos los agentes en el momento de la<B> 
              </B>afiliaci�n<B>.</B></SPAN></FONT></div>
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
              claves de acceso falsas o transmitir mensajes an�nimos</SPAN></FONT></div>
          </LI>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">facilitar 
              informaci�n privada sobre personas</SPAN></FONT></div>
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
            <div align="left"><FONT size="2"><SPAN class="textoForm">introducci�n 
              de informaci�n falsa, manipulaci�n de precios, falsas ofertas</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">introducci�n 
              de virus</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">inserci�n 
              no autorizada de links a otras Web.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">fabricaci�n 
              o distribuci�n de software, productos, servicios o datos t�cnicos, 
              a trav�s de MEDICALVM a ning�n pa�s, d�nde tal fabricaci�n o distribuci�n 
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
              indebidos descritos en la cl�usula 2� o cualquier otro que considere 
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
              da�o a si mismo o a terceros.</SPAN></FONT></div>
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
              se reserva el derecho a modificar su pol�tica de tarifas siempre 
              que un contrato privado anterior no lo impida.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">El acceso 
              a MEDICALVM y la utilizaci�n de los servicios de mediaci�n, son 
              de uso gratuito para todo Comprador.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              facturar� un porcentaje por transacci�n a todo Vendedor.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Las tarifas 
              sobre porcentajes por transacci�n ser�n el objeto de un contrato 
              privado entre el Vendedor y MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">En el caso 
              de no existir tal contrato se aplicar�n las tarifas generales.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">QUINTO.- 
          OPERACION INTENCIONADAMENTE INCOMPLETA:</SPAN></FONT></b></P>
        <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">Dado el elevado 
          valor de los servicios aportados, MEDICALVM se reserva el derecho a 
          revocar temporalmente o indefinidamente el acceso de un agente que intente 
          evadir las tarifas de MEDICALVM as� como reclamarla por da�os y perjuicios 
          si los hubieren.</SPAN></FONT></P>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">SEXTO.- NATURALEZA 
          DE MEDICALVM. FUNCIONAMIENTO:</SPAN></FONT></b></P>

        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              act�a �nicamente como intermediario de la transacci�n entre Comprador 
              y Vendedor, sin ser parte de aquella.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">A causa de 
              la imposibilidad de visualizar todas y cada uno de los contenidos 
              introducidos en MEDICALVM, MEDICALVM queda exonerada de cualquier 
              tipo de responsabilidad sobre la informaci�n difundida, control 
              de calidad, seguridad o legalidad de los datos de los productos 
              o servicios contenidos en MEDICALVM y por consiguiente en ning�n 
              caso MEDICALVM avala, garantiza o representa dichos productos o 
              servicios. </SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">En caso de 
              detectar por parte de un agente informaci�n incorrecta se notificar� 
              a MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Toda informaci�n 
              sobre productos o servicios contenidos en MEDICALVM es informaci�n 
              aportada por el Vendedor y en ning�n caso MEDICALVM avala, garantiza 
              o representa dichos productos o servicios no siendo por tanto responsable 
              de la difusi�n de los mismos ni de los actos que se deriven a ra�z 
              de dicha informaci�n ni la veracidad, legitimidad y legalidad.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MedicalVM 
              se reserva el derecho de poner a disposici�n de todo Comprador el 
              servicio de &quot;Urgencias&quot;, el cual permite a todo Comprador 
              alertar a un Vendedor sobre su necesidad de un producto o servicio. 
              Adem�s del canal usual de MedicalVM, MedicalVM podr� enviar mensajes 
              de alerta al Vendedor v�a otros sistemas; ejemplos son Fax, Mail 
              y tel�fono M�vil. MedicalVM no es responsable del correcto e ininterrumpido 
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
              o de la realizaci�n de los servicios.</SPAN></FONT></div>
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
              reclamaci�n sobre la transacci�n deber� hacerse directamente entre 
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
              la transacci�n.</SPAN></FONT></div>
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
              la veracidad de los datos y recuperar la posible informaci�n perdida.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              no est� autorizado a dar ni da consejos m�dicos. Cualquier informaci�n 
              ligada a un producto o servicio debe considerarse �nicamente informativa. 
              MEDICALVM no suplanta en ning�n caso al m�dico.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">DECIMO.- 
          CONFIRMACI�N DE UNA PAP (Petici�n de aceptaci�n de un pedido):</SPAN></FONT></b></P>
        <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">A partir de la 
          confirmaci�n de una PAP de un comprador, por un vendedor, dicha PAP 
          ser� considerada como un pedido en firme a todos sus efectos.</SPAN></FONT></P>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><b><FONT size="2"><SPAN class="textoForm">DECIMOPRIMERO.- 
          MODIFICACI�N DE LOS DATOS:</SPAN></FONT></b></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Todo Vendedor 
              tendr� el control de la informaci�n introducida y podr� modificarla 
              libremente desde su acceso a MEDICALVM.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
              ofrece el servicio de introducci�n de bases de datos.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <P ALIGN="JUSTIFY"><FONT size="2"><b><SPAN class="textoForm">DECIMOSEGUNDO.- 
          SEGURIDAD:</SPAN></b></FONT></P>
        <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM es una 
          web de alta seguridad que cuenta con personal extra dedicado a proteger 
          la informaci�n personal y transaccional, vigilado las 24 horas, 7 d�as 
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
              no se hace responsable de las pr�cticas privadas o de los contenidos 
              de las Webs a las que se accede a trav�s de MEDICALVM.</SPAN></FONT></div>
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
              de alta a un agente MEDICALVM precisar� de datos personales del 
              agente.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">En el caso 
              de que MEDICCALVM compartiese servicios con otras empresas y necesitase 
              tambi�n compartir estos datos el agente ser� notificado con antelaci�n.</SPAN></FONT></div>
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
              y no deber� utilizarse fuera de MEDICALVM a menos que la Ley lo 
              permita.</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">En el caso 
              de que MEDICALVM comparta la propiedad de sistemas o datos con otra 
              empresa asociada las futuras mejoras de dichos sistemas o datos 
              ser� tambi�n compartida bajo las condiciones acordadas por escrito.</SPAN></FONT></div>
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
              no transferible de acuerdo con las condiciones y cl�usulas de este 
              contrato, y para ning�n otro fin o prop�sito.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI></P>
          <P></P>
        </UL>
        <FONT SIZE="2">
        <P ALIGN="JUSTIFY"></P><BR/><BR/>
        <B> 
        <P ALIGN="JUSTIFY"><SPAN class="textoForm">DECIMOS�PTIMO.- POL�TICA DE 
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
                podr� utilizar informaci�n agregada contenida en MEDICALVM.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Esta informaci�n 
                ser� propiedad de MEDICALVM.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
          </UL>
          <P ALIGN="left"> 
          <LI>
            <div align="left"><FONT size="2"><SPAN class="textoForm">Datos individuales: 
              Conforme la Ley de protecci�n de datos:</SPAN></FONT></div>
          </LI></P>
          <P align="left"></P>
          <P ALIGN="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM no 
            podr� difundir informaci�n unitaria sobre un agente tales como:</SPAN></FONT></P>
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
                informaci�n econ�mica o estrat�gica.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Condiciones 
                especiales de MEDICALVM (tarifas, descuentos, etc�).</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Informaci�n 
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
              <div align="left"><FONT size="2"><SPAN class="textoForm">la utilizaci�n 
                sea de buena fe y bajo el respeto de la Ley.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">Para reforzar 
                los derechos de MEDICALVM en la aplicaci�n de este contrato.</SPAN></FONT></div>
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
                se compromete a mantener la m�s alta confidencialidad entre sus 
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
                podr� publicar la lista de empresas compradoras y vendedoras contenidas 
                en MEDICALVM si aquellas lo autorizan.</SPAN></FONT></div>
            </LI></P>
            <P align="left"></P>
            <P ALIGN="left"> 
            <LI>
              <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
                podr� utilizar el e-mail de un agente para:</SPAN></FONT></div>
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
                  con �l.</SPAN></FONT></div>
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
          MODIFICACI�N DE CL�USULAS:</B></FONT></SPAN></P>
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
              a modificar las cl�usulas de este contrato.</FONT></SPAN></li>
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
            <li><SPAN class="textoForm"><FONT SIZE="2">Estas modificaciones se comunicar�n 
              con un mes de antelaci�n por escrito a todos los agentes.</FONT></SPAN></li>
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
            <li><SPAN class="textoForm"><FONT SIZE="2">Estas modificaciones entrar�n 
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
              revisar peri�dicamente este contrato.</FONT></SPAN></li>
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
          errores u omisiones, o no estar alguna de las cl�usulas de acuerdo con 
          Ley vigente del pa�s, dichos errores no desvirtuaran el contrato teniendo 
          plena vigencia las cl�usulas correctas. Asimismo, de detectarse errores, 
          MEDICALVM modificar� dichas cl�usulas.</FONT></SPAN></P>
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
          el derecho a no ejercer alguna de las cl�usulas de este contrato sin 
          que ello signifique que MEDICALVM renuncie a ellas.</FONT></SPAN></P>
        <P align="left">&nbsp;</P>
          <BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOPRIMERO.- 
          SUCESION.</B></FONT></SPAN></P>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2">Este</FONT> <FONT SIZE="2">contrato</FONT> 
          se aplicar� a todo sucesor legal del agente firmante.</SPAN></P>
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
          car�cter indefinido y estar� vigente hasta que alguna de las partes 
          notifique mediante correo ordinario su voluntad de resoluci�n.</FONT></SPAN></P>
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
            <li><SPAN class="textoForm"><FONT SIZE="2">MEDICALVM facturar� al Vendedor 
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
            <li><SPAN class="textoForm"><FONT SIZE="2">El pago ser� obligado en 
              los mencionados plazos y formas, con independencia de las condiciones 
              de entrega y pago pactadas entre Comprador y Vendedor. </FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
          </OL>
        </div><BR/><BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOCUARTO.- 
          FACTURACI�N:</B></FONT></SPAN></P>
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
            <li><SPAN class="textoForm"><FONT SIZE="2">MEDICALVM enviar� al Vendedor 
              por correo ordinario una factura semanal que contendr� las transacciones 
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
            <li><SPAN class="textoForm"><FONT SIZE="2">El Vendedor dispondr� de 
              una cuenta on-line con toda la informaci�n relacionada con cada 
              transacci�n realizada.</FONT></SPAN></li>
          </ul>
          <OL TYPE="a">
          </OL>
        </div>
        <OL TYPE="a">
          <P ALIGN="left"></P>
        </OL><BR/><BR/>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOQUINTO.- 
          RESOLUCI�N DE CONFLICTOS:</B></FONT></SPAN></P>
        <P align="left"><SPAN class="textoForm"><FONT SIZE="2">Para cualquier duda 
          o divergencia que surgiera en la interpretaci�n y aplicaci�n del presente 
          contrato, con renuncia a su fuero si lo tuvieren, ambas partes se someten 
          a los Juzgados y Tribunales de Barcelona.</FONT></SPAN></P>

            
           <br/><br/> 
         <P align="left"><SPAN class="textoForm"><FONT SIZE="2"><B>VIGESIMOSEXTO.- CLAVES DE ACCESO:</B></FONT>
         </SPAN></P><P align="left"><SPAN class="textoForm"><FONT SIZE="2">
             A la firma de este contrato se entregar�n las claves de acceso correspondientes, 
             las cuales tienen una duraci�n de 6 meses y ser�n renovadas autom�ticamente, 
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
                      <input type="checkBox" name="ACEPTAR_CONTRATO2" onClick="actualizarChecks(document.forms[0],this);"><font size="2"><b>S�, acepto el contrato.</b></font></input>
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