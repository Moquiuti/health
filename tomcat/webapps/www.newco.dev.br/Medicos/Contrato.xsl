<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	Lista de Solicitudes de Alta en MEdicalVM por parte de Medicos
 |
 |	(c) 7/5/2001 ET
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        
	<title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='USD-1010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	
	<title><xsl:value-of select="TITULO" disable-output-escaping="yes"/></title>
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>
	<!--   Para pruebas con XMLReader
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
        ]]></xsl:text>
	-->
      </head>
      <body bgcolor="#EEFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
        <xsl:choose>
      	<!-- ET Desactivado control errores: Habra que reactivarlo
          <xsl:when test="ListaDerechosUsuarios/xsql-error">
            <xsl:apply-templates select="ListaDerechosUsuarios/xsql-error"/>          
          </xsl:when>
		-->
        <xsl:when test="Contrato/ROWSET/ROW/Sorry">
          <xsl:apply-templates select="Contrato/ROWSET/ROW/Sorry"/> 
        </xsl:when>
        <xsl:otherwise>
        <b>
        <table width="100%" border="1" cellpadding="20" bgcolor="#eeffff" bordercolor="#000000">
        <tr>
           <td>
            <!--           
            <DIV align="justify"> 
			-->
			<font size="2"><span class="textoFormUnderline">1.CONDICIONES GENERALES Y SU ACEPTACIÓN</span><br/>
              <P><span class="textoForm">Estas condiciones generales (en adelante, las "Condiciones Generales") 
                regulan el uso del servicio de Medical VM (en adelante, MVM) que 
                MEDICAL VIRTUAL MARKET S.L. (en adelante, "MEDICALVM") pone gratuitamente 
                a disposición de los usuarios de Internet.</span></P>
              <P><span class="textoForm">La utilización del sistema atribuye la condición de usuario de 
                MEDICALVM (en adelante, el "Usuario ") y expresa la aceptación 
                plena y sin reservas del Usuario de todas y cada una de las Condiciones 
                Generales en la versión publicada por MEDICALVM en el momento 
                mismo en que el Usuario acceda al sistema.</span></P>
              <P><span class="textoForm">Asimismo, la utilización del Servicio se encuentra sometida igualmente 
                a todos los avisos, reglamentos de uso e instrucciones puestos 
                en conocimiento del Usuario por MEDICALVM, que completan lo previsto 
                en estas Condiciones Generales en cuanto no se opongan a ellas. 
              </span></P>
              <br/>
              <br/>
              <br/>
              <span class="textoFormUnderline">2. OBJETO </span><br/>
              <P><span class="textoForm">A través del sistema, MVM facilita a los Usuarios el acceso y 
                la utilización de diversos servicios y contenidos puestos a disposición 
                de los Usuarios por MVM o por terceros usuarios del sistema y/o 
                terceros proveedores de servicios y contenidos (en adelante, los 
                "Servicios").</span></P>
              <P><span class="textoForm">MVM se reserva el derecho a modificar unilateralmente, en cualquier 
                momento y sin aviso previo, la presentación y configuración del 
                sistema, así como los servicios y las condiciones requeridas para 
                utilizar el sistema y los servicios.</span></P>
              <br/>
              <br/>
              <br/>
              <span class="textoFormUnderline">3. CONDICIONES DE ACCESO Y UTILIZACIÓN 
              DE MEDICALVM </span><br/>
              </font> 
              <OL TYPE="I">
                <LI> 
                  <DIV align="left"> <span class="textoForm"><FONT size="2"> Que 
                    MEDICAL VIRTUAL MARKET, S.L. en adelante "MEDICALVM" es una 
                    compañía dedicada a la creación y mantenimiento de programas 
                    para Internet destinados a la comercialización de productos 
                    de toda índole. </FONT></span> </DIV>
                </LI>
                <LI> 
                  <DIV align="left"><span class="textoForm"><FONT size="2"> Que 
                    se define como MEDICALVM la plataforma medicalvm.com propiedad 
                    de MEDICALVM, S.L.</FONT></span></DIV>
                </LI>
                <LI> 
                  <DIV align="left"><FONT size="2" class="textoForm">Se define 
                    como "agente" a toda persona física o jurídica, representante 
                    de una empresa o no, al cual MEDICALVM le ha autorizado por 
                    escrito el acceso a MEDICALVM.</FONT></DIV>
                </LI>
                <LI><FONT size="2" class="textoForm">Se define como "Comprador" 
                  a todo agente que compre un producto o servicio a través de 
                  MEDICALVM.</FONT> </LI>
                <LI><FONT size="2" class="textoForm">Se define como "Vendedor" 
                  a todo agente que venda un producto o servicio a través de MEDICALVM.</FONT> 
                </LI>
                <LI> 
                  <DIV align="left"><span class="textoForm"><FONT size="2">Se 
                    define como PAP (petición de aceptación de pedido) la solicitud 
                    de un Comprador a un Vendedor de aceptar un pedido.</FONT></span></DIV>
                </LI>
                <LI> 
                  <DIV align="left"><span class="textoForm"><FONT size="2">Se 
                    define como transacción el momento en que un Vendedor confirma 
                    una PAP.</FONT></span></DIV>
                </LI>
                <LI><SPAN class="textoForm">Se define como "link" todo enlace situado 
                  en MEDICALVM que da acceso a otra web. </SPAN></LI>
              </OL> 
              <br/>
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">PRIMERO.- 
                ACCESO:</SPAN></FONT></P>
        <OL TYPE="a">
                <LI><FONT size="2"><SPAN class="textoForm">MEDICALVM es la única entidad 
                  con autorización para dar acceso a un agente a MEDICALVM.</SPAN></FONT></LI>
          <LI>
                  <FONT size="2" class="textoForm">Toda solicitud 
                    de acceso a MEDICALVM se transmitirá directamente al servicio 
                    comercial de MEDICALVM.</FONT>
          </LI>
                <LI><SPAN class="textoForm">MEDICALVM se reserva el derecho de admisión 
                  de un agente.</SPAN></LI>
                <LI> 
                  <div align="left"><span class="textoForm"><FONT size="2">MEDICALVM 
                    se reserva el derecho a revocar el acceso a un agente.</FONT></span></div>
                </LI>
                <LI> 
                  <div align="left"><FONT size="2" class="textoForm">MEDICALVM 
                    realiza una evaluación de todos los agentes en el momento 
                    de la afiliación. </FONT></div>
                </LI>
                <LI> 
                  <div align="left" class="textoForm">A la firma de este contrato 
                    se entregarán las claves de acceso correspondientes, las cuales 
                    tienen una duración de 6 meses y serán renovadas automáticamente, 
                    sino presenta objeciones ninguna de las dos partes.</div>
                </LI>
              </OL>
        <br/><br/>
        <FONT SIZE="2"> 
         
              <P ALIGN="JUSTIFY"><SPAN class="textoForm"><span class="textoFormUnderline">SEGUNDO.- 
                USOS PROHIBIDOS:</span></SPAN></P>
               </FONT> 
              <P ALIGN="left" class="textoForm">MEDICALVM se reserva el derecho 
                a visualizar contenidos para detectar usos indebidos del sistema, 
                incluidos pero no limitados a:</P>
              <UL>
                <LI> 
                  <div align="left"><FONT size="2"><SPAN class="textoForm">utilizar 
                    claves de acceso falsas o transmitir mensajes anónimos</SPAN></FONT></div>
                </LI>
                <LI> 
                  <div align="left"><FONT size="2" class="textoForm">facilitar 
                    información privada sobre personas</FONT></div>
                </LI>
                <LI><span class="textoForm">venta de material robado</span></LI>
                <LI class="textoForm">introducción de información falsa, manipulación 
                  de precios, falsas ofertas</LI>
                <LI> 
                  <div align="left"><FONT size="2"><SPAN class="textoForm">introducción 
                    de virus</SPAN></FONT></div>
                </LI>
                <LI class="textoForm">inserción no autorizada de links a otras 
                  Web.</LI>
                <LI> 
                  <div align="left"><span class="textoForm"><FONT size="2">fabricación 
                    o distribución de software, productos, servicios o datos técnicos, 
                    a través de MEDICALVM a ningún país, dónde tal fabricación 
                    o distribución sea ilegal.</FONT></span></div>
                  <FONT size="2"><SPAN class="textoForm"></SPAN></FONT><br/>
                  <br/>
                </LI>
              </UL>
              <P ALIGN="JUSTIFY"><SPAN class="textoForm"><SPAN class="textoFormUnderline">TERCERO.- TARIFAS 
                Y FORMA DE PAGO:</SPAN></SPAN></P>
              <UL>
                <LI class="textoForm">MEDICALVM facturará al Vendedor una comisión 
                  del 2,5% sobre el importe total del pedido, en el momento en 
                  que el Vendedor confirme la PAP de un Comprador.</LI>
                <LI class="textoForm">MEDICALVM facturará al agente por los servicios 
                  prestados, con un vencimiento de 30 días fecha factura.</LI>
                <LI class="textoForm">El pago será obligado en los mencionados 
                  plazos y formas, con independencia de las condiciones de entrega 
                  y pago pactadas entre Comprador y Vendedor.</LI>
              </UL>
              <br/>
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">CUARTO.- 
                NATURALEZA DE MEDICALVM. FUNCIONAMIENTO:</SPAN></FONT></P>

              <UL>
                <LI> 
                  <div align="left"><span class="textoForm"><FONT size="2">MEDICALVM 
                    actúa únicamente como intermediario de la transacción entre 
                    Comprador y Vendedor, sin ser parte de aquella.</FONT></span></div>
                </LI>
                <LI class="textoForm">A causa de la imposibilidad de visualizar 
                  todas y cada uno de los contenidos introducidos en MEDICALVM, 
                  MEDICALVM queda exonerada de cualquier tipo de responsabilidad 
                  sobre la información difundida, control de calidad, seguridad 
                  o legalidad de los datos de los productos o servicios contenidos 
                  en MEDICALVM y por consiguiente en ningún caso MEDICALVM avala, 
                  garantiza o representa dichos productos o servicios. </LI>
                <LI> 
                  <div align="left"><span class="textoForm"><FONT size="2">En 
                    caso de detectar por parte de un agente información incorrecta 
                    se notificará a MEDICALVM.</FONT></span></div>
                </LI>
                <LI><span class="textoForm">Toda información sobre productos o 
                  servicios contenidos en MEDICALVM es información aportada por 
                  el Vendedor y en ningún caso MEDICALVM avala, garantiza o representa 
                  dichos productos o servicios no siendo por tanto responsable 
                  de la difusión de los mismos ni de los actos que se deriven 
                  a raíz de dicha información ni la veracidad, legitimidad y legalidad.</span></LI>

              </UL>
              <br/>
        
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">QUINTO.- 
                SERVICIOS DE URGENCIAS:</SPAN></FONT></P>

              <UL>
                <LI> 
                  <div align="left"><span class="textoForm"><FONT size="2">MedicalVM 
                    se reserva el derecho de poner a disposición de todo Comprador 
                    el servicio de "Urgencias", el cual permite a todo Comprador 
                    alertar a un Vendedor sobre su necesidad de un producto o 
                    servicio. Además del canal usual de MedicalVM, MedicalVM podrá 
                    enviar mensajes de alerta al Vendedor vía otros sistemas; 
                    ejemplos son Fax, Mail y teléfono Móvil. MedicalVM no es responsable 
                    del correcto e ininterrumpido funcionamiento del servicio 
                    de "Urgencias" , ni de la compatibilidad y/o del correcto 
                    e ininterrumpido funcionamiento de los sistemas del Vendedor.</FONT></span></div>
                </LI>
              </UL>
              <br/>
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">SEXTO.- 
                ERRORES U OMISIONES.</SPAN></FONT></P>
        
              <UL>
                <LI> 
                  <div align="left"><FONT size="2" class="textoForm">MEDICALVM 
                    no es responsable de los errores u omisiones que puedan aparecer 
                    en MEDICALVM.</FONT></div>
                </LI>
                <LI> 
                  <div align="left"><FONT size="2" class="textoForm">MEDICALVM 
                    no es responsable del incumplimiento o cumplimiento defectuoso 
                    de la transacción.</FONT></div>
                  <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI>
                <LI><span class="textoForm"> MEDICALVM no puede garantizar el 
                  funcionamiento ininterrumpido de MEDICALVM. </span></LI>
                <LI><span class="textoForm"> MEDICALVM no puede garantizar la 
                  seguridad en el acceso a MEDICALVM. El agente es responsable 
                  de tomar las medidas de seguridad oportunas, controlar la veracidad 
                  de los datos y recuperar la posible información perdida.</span></LI>
                <LI><span class="textoForm"> MEDICALVM no está autorizado a dar 
                  ni da consejos médicos. Cualquier información ligada a un producto 
                  o servicio debe considerarse únicamente informativa. MEDICALVM 
                  no suplanta en ningún caso al médico.</span></LI>
                <LI><span class="textoForm"> MEDICALVM puede contener enlaces 
                  hacia otras direcciones de Internet.</span></LI>
                <LI class="textoForm"> MEDICALVM no se hace responsable de las 
                  prácticas privadas o de los contenidos de los enlaces a los 
                  que se accede a través de MEDICALVM.&nbsp; </LI>
              </UL>
              <br/>
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">SEPTIMO.- 
                CONFIRMACIÓN DE UNA PAP (Petición de aceptación de un pedido):</SPAN></FONT></P>
          
              <P ALIGN="left"><FONT size="2" class="textoForm">A partir de la 
                confirmación de una PAP de un comprador, por un vendedor, dicha 
                PAP será considerada como un pedido en firme a todos sus efectos.</FONT></P>
              <br/>
        
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">OCTAVO.- 
                MODIFICACIÓN DE LOS DATOS:</SPAN></FONT></P>
              <div align="left"> 
                <UL>
                </UL>
              </div>
              <UL>
                <LI><span class="textoForm">Todo Vendedor tendrá el control de 
                  la información introducida y podrá modificarla libremente desde 
                  su acceso a MEDICALVM.</span></LI>
                <LI><span class="textoForm">MEDICALVM ofrece el servicio de introducción 
                  de bases de datos. Todo agente podrá solicitar gratuitamente 
                  un presupuesto a MedicalVM.</span><FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI>
              </UL>
              <br/>
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">NOVENO.- 
                SEGURIDAD:</SPAN></FONT></P>
              <P ALIGN="left"><FONT size="2" class="textoForm">MEDICALVM es un 
                servicio de alta seguridad que cuenta con personal dedicado a 
                proteger la información personal y transaccional, funcionando 
                las 24 horas, 7 días por semana, siendo protegidas todas las transacciones 
                e informaciones personales. Sin embargo, tal y como ya se ha manifestado, 
                MEDICALVM no se hace responsable de la veracidad y legalidad de 
                los contenidos.</FONT></P>
              <p>&nbsp;</p>
              <p align="JUSTIFY"><font size="2"><span class="textoFormUnderline">DECIMO.- 
                PROTECCIÓN DE DATOS:</span></font></p>
              <font size="2"></font> 
              <div align="left"> 
                <ol type="a">
                </ol>
              </div>
              <ol type="a">
                <li> 
                  <div align="left"><font size="2"><span class="textoForm">Datos 
                    agregados:</span></font></div>
                </li>
                <div align="left"> 
                  <ul>
                  </ul>
                </div>
                <ul>
                  <li class="textoForm">MEDICALVM podrá utilizar información agregada 
                    contenida en MEDICALVM.</li>
                  <li class="textoForm">Esta información será propiedad de MEDICALVM.</li>
                </ul>
                <li><span class="textoForm"><font size="2">Datos individuales: 
                  Conforme la Ley de protección de datos</font></span><br/>
                  <br/>
                  <ul>
                    <li class="textoForm"> Para dar de alta a un agente MEDICALVM 
                      precisará de datos personales del agente. </li>
                    <li class="textoForm"> En el caso de que MEDICCALVM compartiese 
                      servicios con otras empresas y necesitase también compartir 
                      estos datos el agente será notificado con antelación. </li>
                    <li> <span class="textoForm">MEDICALVM no podrá difundir información 
                      unitaria sobre un agente tales como:</span><br/>
                      <br/>
                      <ul>
                        <li> 
                          <div align="left"><font size="2"><span class="textoForm">Precios</span></font></div>
                        </li>
                        <li> 
                          <div align="left"><font size="2"><span class="textoForm">Productos</span></font></div>
                        </li>
                        <li> 
                          <div align="left"><font size="2"><span class="textoForm">Clientes 
                            y Proveedores</span></font></div>
                        </li>
                        <li> 
                          <div align="left"><font size="2"><span class="textoForm">Cualquier 
                            información económica o estratégica.</span></font></div>
                        </li>
                        <li> 
                          <div align="left"><font size="2"><span class="textoForm">Condiciones 
                            especiales de MEDICALVM (tarifas, descuentos, etc…).</span></font></div>
                        </li>
                      </ul>
                    </li>
                    <br/>
                    <p align="JUSTIFY"><span class="textoForm">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A 
                      menos que:</span></p>
                    <ul>
                      <li> 
                        <div align="left"><font size="2"><span class="textoForm">el 
                          agente lo autorice por escrito.</span></font></div>
                      </li>
                      <li> 
                        <div align="left"><font size="2"><span class="textoForm">la 
                          utilización sea de buena fe y bajo el respeto de la 
                          Ley.</span></font></div>
                      </li>
                      <li> 
                        <div align="left"><font size="2"><span class="textoForm">para 
                          proteger los derechos de MEDICALVM o terceros.</span></font></div>
                      </li>
                    </ul>
                  </ul>
                  <br/>
                </li>
                <li> 
                  <div align="left"><font size="2"><span class="textoForm">HONCode:</span></font></div>
                </li>
                <div align="left"> 
                  <ul>
                  </ul>
                </div>
                <ul>
                  <li> 
                    <div align="left"><span class="textoForm"><font size="2">MEDICALVM 
                      suscribe los principios de HONCode (Health On the Net Foundation).</font></span></div>
                  </li>
                  <li> 
                    <div align="left"><span class="textoForm"><font size="2">MEDICALVM 
                      se compromete a mantener la más alta confidencialidad entre 
                      sus agentes.</font></span></div>
                  </li>
                </ul>
                <li><span class="textoForm">MEDICALVM podrá utilizar el e-mail 
                  de un agente para:<font size="2"><span class="textoForm">:</span></font></span></li>
                <div align="left"> 
                  <ul>
                  </ul>
                </div>
                <ul>
                  <li> 
                    <div align="left"><font size="2" class="textoForm">enviar 
                      información relativa a MedicalVM y/o al sector.</font></div>
                  </li>
                  <li> 
                    <div align="left" class="textoForm">informar del registro 
                      de un agente en MEDICALVM.</div>
                  </li>
                </ul>
              </ol>
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">DECIMOPRIMERO.- 
                PROPIEDAD INTELECTUAL:</SPAN></FONT></P>
              <div align="left"> 
                <UL>
                </UL>
              </div>
              <UL>
                <LI> 
                  <div align="left"><span class="textoForm"><FONT size="2">Todo 
                    el sistema y contenido de MEDICALVM ha sido registrado en 
                    propiedad de MEDICALVM y no deberá utilizarse fuera de MEDICALVM 
                    a menos que la Ley lo permita.</FONT></span></div>
                </LI>
              </UL>
              <p>&nbsp;</p>
              <UL>
              </UL>
              <P ALIGN="JUSTIFY"><FONT size="2"><SPAN class="textoFormUnderline">DECIMOSEGUNDO.- 
                LICENCIA:</SPAN></FONT></P>
        <div align="left">
          <UL>
          </UL>
        </div>
        <UL>
          <LI>
                  <div align="left"><FONT size="2"><SPAN class="textoForm">MEDICALVM 
                    garantiza a todo agente una licencia de MEDICALVM para su 
                    uso personal, no transferible de acuerdo con las condiciones 
                    y cláusulas de este contrato, y para ningún otro fin o propósito.</SPAN></FONT></div>
            <FONT size="2"><SPAN class="textoForm"></SPAN></FONT></LI>
        </UL>
              <br/>
              <FONT SIZE="2"></FONT> 
              <P align="left"><SPAN class="textoForm"><FONT SIZE="2">DECIMOTERCERO.- 
                MARCO DEL CONTRATO:</FONT></SPAN></P>
              <div align="left"> 
                <ul>
                  <li class="textoForm">MEDICALVM se reserva el derecho a proponer 
                    modificaciones en las cláusulas de este contrato.<br/>
                    <br/>
                  </li>
                  <li><SPAN class="textoForm">Estas modificaciones se comunicarán 
                    con un mes de antelación por escrito a todos los agentes.<br/>
                    <br/>
                    </SPAN></li>
                  <li class="textoForm">El agente se compromete a revisar periódicamente 
                    este contrato.<br/>
                    <br/>
                  </li>
                  <li class="textoForm">En el caso de detectarse errores u omisiones, 
                    o no estar alguna de las cláusulas de acuerdo con Ley vigente 
                    del país, dichos errores no desvirtuaran el contrato teniendo 
                    plena vigencia las cláusulas correctas. Asimismo, de detectarse 
                    errores, MEDICALVM modificará dichas cláusulas.<br/>
                    <br/>
                  </li>
                  <li class="textoForm">MEDICALVM se reserva el derecho a no ejercer 
                    alguna de las cláusulas de este contrato sin que ello signifique 
                    que MEDICALVM renuncie a ellas.<br/>
                    <br/>
                  </li>
                  <li class="textoForm">Este contrato se aplicará a todo sucesor 
                    legal del agente firmante.<br/>
                    <br/>
                  </li>
                  <li class="textoForm">Este contrato tiene carácter indefinido 
                    y estará vigente hasta que alguna de las partes notifique 
                    mediante correo ordinario certificado o fax, su voluntad de 
                    resolución.</li>
                </ul>
        </div>
          <br/>
              <P align="left"><SPAN class="textoForm"><FONT SIZE="2">DECIMOCUARTO.- 
                GESTIÓN:</FONT></SPAN></P>        
              <P align="left" class="textoForm">El Agente dispondrá de una cuenta 
                on-line con toda la información relacionada con cada transacción 
                realizada.</P>
        <div align="left">
          <OL TYPE="a">
          </OL>
        </div>
              <OL TYPE="a">
                <P ALIGN="left"><br/>
                </P>
              </OL>
              <P align="left"><SPAN class="textoForm"><FONT SIZE="2">DECIMOQUINTO.- 
                RESOLUCIÓN DE CONFLICTOS.</FONT></SPAN></P>
              <P align="left"><span class="textoForm">Para cualquier duda o divergencia 
                que surgiera en la interpretación y aplicación del presente contrato, 
                con renuncia a su fuero si lo tuvieren, ambas partes se someten 
                a los Juzgados y Tribunales de Barcelona.</span><br/>
                <!-- hasta aqui --> <br/><br/><br/> </P>
        <P>&nbsp;</P>
        <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >
			<tr>
				<td>
				<p><span class="textoForm">En representación de los Centros:</span></p>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
          	<xsl:for-each select="Contrato/ROW/CENTROS/CENTROS_ROW">
			<tr>
				<td class="textoForm">*&nbsp;
				<xsl:value-of select="./NOMBRE"/>
				,&nbsp;domiciliado en&nbsp;
				<xsl:value-of select="./DIRECCION"/>
				&nbsp;(Población:&nbsp;
				<xsl:value-of select="./POBLACION"/>,
				<xsl:value-of select="./PROVINCIA"/>)
				,&nbsp;con N.I.F.&nbsp;<xsl:value-of select="./NIF"/>
				</td>
			</tr>
		  	</xsl:for-each>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td class="textoForm">El abajo firmante,
                <xsl:value-of select="Contrato/ROW/NOMBRE"/>
				, domiciliado en&nbsp;
				<xsl:value-of select="Contrato/ROW/DIRECCION"/>&nbsp;
				(<xsl:value-of select="Contrato/ROW/CODPOSTAL"/>&nbsp;
				<xsl:value-of select="Contrato/ROW/POBLACION"/>,&nbsp;
				<xsl:value-of select="Contrato/ROW/PROVINCIA"/>)
				,&nbsp;con N.I.F.&nbsp;<xsl:value-of select="Contrato/ROW/NIF"/>,
				en fecha de&nbsp;<xsl:value-of select="Contrato/ROW/FECHAFIRMA"/>
				acepta el Contrato y firma como responsable:
				</td>
			</tr>
            <!--<tr><td colspan="6"><hr/></td></tr>-->
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
        </table> 
		</td></tr>
		</table></b>
        <br/><br/>
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
  
  

</xsl:stylesheet>
