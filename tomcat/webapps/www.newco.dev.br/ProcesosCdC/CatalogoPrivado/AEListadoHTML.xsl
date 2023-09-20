<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |   Lista las Sugerencias pendientes para el usuario.
 |
 |   Dependiendo del estado del documento llamamos al proceso correspondiente.  
 
  **** Usar USDetalle.xsql para el detalle de los usuarios *****
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/Multiofertas">
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        <script type="text/javascript">
        <!--
        Actualitza_Cookie('MOListado','Iniciar');              
        function Visualiza(sel){	
	  var seleccionado=sel.options[sel.selectedIndex].value;	          		
          document.location.href="]]></xsl:text>IEListado.xsql?ROL=<xsl:value-of select="/Multiofertas/ROL"/>&amp;TIPO=<xsl:value-of select="/Multiofertas/TIPO"/>&amp;ID=<xsl:text disable-output-escaping="yes"><![CDATA["+seleccionado;
        }
        //-->
        </script>        
        ]]></xsl:text>
      </head>
      <body bgcolor="#FFFFFF" class="tituloCamp"><!--onLoad="Actualitza_Cookie('MOListado','Terminar')"-->
          
          <xsl:choose><!-- error -->
          <xsl:when test="//xsql-error">
             <xsl:apply-templates select="//xsql-error"/>         
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
             <xsl:apply-templates select="//SESION_CADUCADA"/>         
          </xsl:when>
          <xsl:otherwise><!--  no error -->  
            <!--<xsl:apply-templates select="jumpTo"/><br/>-->
				<center> 
				<p class="tituloPag"><xsl:value-of select="/Multiofertas/LISTATAREAS/TITULO"/></p>
		    	</center> 
			<br/>                        
		<table  width="90%" bgColor="#015E4B" border="0" align="center" cellspacing="1" cellpadding="1">
			<!--
              <tr bgcolor="#EEFFFF">
                <td colspan="4">
                  <xsl:apply-templates select="jumpTo"/>
                </td>                
              </tr>
              <tr><td colspan="4">&nbsp;</td></tr>                      
              <tr bgColor="#015E4B" >
                <td colspan="4" align="center">
                </td></tr>                           
	        <tr><td colspan="4">&nbsp;</td></tr>--> 
	  <xsl:choose><!--  no error /sorry -->
	    <xsl:when test="//Sorry"> 
	      <tr><td colspan="4" align="center">    
	        <xsl:apply-templates select="//Sorry"/></td></tr>
	    </xsl:when>  
	    <xsl:otherwise><!--  no error / no sorry -->              
	     
	     <!-- ********** CABECERA ********* -->
	    
              <tr class="oscuro">
                <td align="center" width="8%">
                  <!-- numero --><p class="tituloCamp">	          
                  Número
                  </p></td>
                <td align="center" width="8%">
                  <!-- fecha --><p class="tituloCamp">	          
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0365' and @lang=$lang]"/>
                  </p></td>                
                  
                <!-- Si es usuario gerente mostramos los datos del usuario. -->
                <xsl:if test="LISTATAREAS/GERENTE">
                  <td align="center" width="15%">
                  <p class="tituloCamp">
                   <!-- usuario -->        
                   <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0375' and @lang=$lang]"/>
                  </p></td>
                  <td align="center" width="15%">
                  <p class="tituloCamp">
                   <!-- centro del usuario -->        
                   <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0377' and @lang=$lang]"/>
                  </p></td>
                </xsl:if>
                  
                <td align="center" width="*"><p class="tituloCamp">
                  <!-- empresa -->	
                  <xsl:value-of select="LISTATAREAS/TITULOEMPRESA"/>
                  <!--<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0370' and @lang=$lang]"/>
				  -->
	          </p></td>
                <td align="center" width="15%"><p class="tituloCamp">
                  <!-- Estado -->	          
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0380' and @lang=$lang]"/>
                  </p></td>
                <xsl:choose><!-- no error / no sorry / comprador -->                 
                 <xsl:when test="LISTATAREAS/ROL[.='C']">
                  <td align="center" width="15%">
                  <p class="tituloCamp">
                   <!-- plantilla -->        
                   <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0305' and @lang=$lang]"/>
                  </p></td>
                 </xsl:when>   
				 <!--              
                 <xsl:otherwise>
                   <td>&nbsp;</td>
                 </xsl:otherwise>
				 -->
                </xsl:choose>  
                <td align="center" width="8%"><p class="tituloCamp">
                  <!-- Fecha 2 -->	          
                  <xsl:value-of select="LISTATAREAS/TITULOFECHA2"/>
                  </p></td>
              </tr>
              
              <!-- ********** DATOS ********* -->
              
              <xsl:for-each select="LISTATAREAS/TAREA">
              
                <!--<xsl:choose>
                  <xsl:when test="/Multiofertas/TIPO [.='O']"><!- - cuando sea oferta  - -> 
                    <xsl:choose>
                      <xsl:when test="MO_STATUS &lt; 11"><!- - si es mas peq de 11, (Status=OFERTA) - ->-->
                        <tr class="blanco">
                          <xsl:apply-templates select="MO_ID"/> 
                          <td align="center" width="8%">
          					<b>
                  			<a>
                  			<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActaEvaluacion.xsql?IDACTA=<xsl:value-of select="ID"/>','ActaEvaluacion');</xsl:attribute>
                  			<xsl:attribute name="onMouseOver">window.status='Abrir acta.';return true;</xsl:attribute>
	          				<xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  			<xsl:attribute name="class">color:blue</xsl:attribute>
                  			<xsl:apply-templates select="NUMERO"/>
                  			</a>
                 			</b>
                          </td>
                          <td align="center">
                            <xsl:apply-templates select="FECHA"/>
                          </td>                 
                            <xsl:if test="../GERENTE">
                              <td>
                                <xsl:apply-templates select="MO_USUARIO"/>
                              </td>                 
                              <td>
                                <xsl:apply-templates select="CENTRO"/>
                              </td>                 
                            </xsl:if> 
	                  <td>
	                        <xsl:apply-templates select="PRODUCTO"/>               
	                  </td>
	                  <td>
	                    <!--<xsl:apply-templates select="ERW_DESCRIPCION_BANDEJA"/>-->
	                    
          	<b>
                  <a>
                  <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActaEvaluacion.xsql?IDACTA=<xsl:value-of select="ID"/>','ActaEvaluacion');</xsl:attribute>
                  <xsl:attribute name="onMouseOver">window.status='Abrir oferta pendiente de acción.';return true;</xsl:attribute>
	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                  <xsl:attribute name="class">color:blue</xsl:attribute>
                  <xsl:value-of select="ERW_DESCRIPCION_BANDEJA"/>
                  </a>
                 </b>
	                  </td>
                      <xsl:choose>
                      	<xsl:when test="/Multiofertas/LISTATAREAS/ROL[.='C']">                  
	                  		<td>
	                    		<xsl:apply-templates select="LP_NOMBRE"/> <!-- presentamos el nombre de la plant. -->
	                    	</td>                  
                      	</xsl:when>  
                      </xsl:choose> 
	                  <td align="right">
	                    <xsl:value-of select="FECHA2"/>
	                  </td>
	                </tr>
              </xsl:for-each>
              </xsl:otherwise></xsl:choose><!-- error -->
            </table>
            <!--<xsl:apply-templates select="jumpTo"/>-->
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
    

  <xsl:template match="MO_ID">
  </xsl:template>   

  <xsl:template match="PRODUCTO">
   <a>
    <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActaEvaluacion.xsql?IDACTA=<xsl:value-of select="../ID"/>','ActaEvaluacion');</xsl:attribute>
    <xsl:attribute name="onMouseOver">window.status='Información sobre el producto.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    <xsl:value-of select="."/>
   </a>
  </xsl:template>

  <xsl:template match="MO_USUARIO">
	     <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="CENTRO2">
     <i><a>
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/CENDetalle.xsql?CEN_ID=<xsl:value-of select="../CEN_ID2"/>&amp;VENTANA=NUEVA','Centro',60,45,0,-50)</xsl:attribute>
    <xsl:attribute name="onMouseOver">window.status='Información sobre el centro.';return true;</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    <xsl:value-of select="."/>
   </a></i>
  </xsl:template>
  
  <xsl:template match="CENTRO">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="LP_NOMBRE">
	     <xsl:value-of select="."/>
  </xsl:template>
  
  <xsl:template match="FECHA_ENTRADA">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="ERW_DESCRIPCION_BANDEJA">
	    <a>
	     <xsl:attribute name="href">http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/ActaEvaluacion.xsql?IDACTA=<xsl:value-of select="../ID"/></xsl:attribute>
	     <xsl:attribute name="onMouseOver">window.status='Abrir acta.';return true;</xsl:attribute>
	     <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
	     <!--<xsl:attribute name="href">Multioferta.xsql?MO_ID=<xsl:value-of select="../MO_ID"/>&amp;ROL=<xsl:value-of select="/Multiofertas/ROL"/>&amp;TIPO=<xsl:value-of select="/Multiofertas/TIPO"/>&amp;xml-stylesheet=none</xsl:attribute>-->
             <xsl:value-of select="."/>
	    </a>
  </xsl:template>
  
  <xsl:template match="Sorry">
    <p class="tituloCamp"><font color="#EEFFFF">
		<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0000' and @lang=$lang]"	disable-output-escaping="yes"/>
	</font></p>
  </xsl:template>  
  
</xsl:stylesheet>
