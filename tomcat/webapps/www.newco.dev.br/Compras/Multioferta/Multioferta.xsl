<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  
  
  
  <!--
         template del titulo
  -->
  <xsl:template name="tituloMultioferta">
   <p class="tituloPag" align="center">
     <a class="tituloPag" align="center" href="http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID={MO_IDCLIENTE}">
       <xsl:value-of select="CLIENTE"/>
       &nbsp;
       <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0101' and @lang=$lang]" disable-output-escaping="yes"/>
     </a>
   </p> 
  </xsl:template>
  
  
  
  <!--
      template con la info de oferta pedido
      numero de oferta y fecha de emision
  -->
  
  <xsl:template name="numOfertaPedido">
    <xsl:param name="tipo"/>
    
    <tr bgcolor="#d0f8f7">
        <xsl:if test="$tipo='O'">
          <td width="15%">
            <br/>
            <b>
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0660' and @lang=$lang]" disable-output-escaping="yes"/>:
            </b>
            <br/><br/>
          </td>
          <td width="35%" bgcolor="#EEFFFF">
            <br/>
            <xsl:value-of select="MO_NUMERO"/>
            <br/><br/>
          </td>
          <td width="15%">
            <br/>
            <b>
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0720' and @lang=$lang]" disable-output-escaping="yes"/>:
            </b>
            <br/><br/>
          </td>
          <td width="35%" bgcolor="#EEFFFF">
            <br/>
            <xsl:value-of select="LP_FECHAEMISION"/>
            <br/><br/>
          </td>
        </xsl:if>
    </tr>
  </xsl:template>
  
  <xsl:template name="datosUsuario">
    <xsl:param name="rol"/>
    
    <tr bgcolor="#EEFFFF">
      <td colspan="4">
        <table width="100%">
          <tr>
            <td bgcolor="#d0f8f7">
              datos del cliente:
            </td>
          </tr>
            <xsl:choose>
              <xsl:when test="$rol='C'">
                <tr>
                  <td colspan="4">
                    datos Proveedor:
                  </td>
                </tr>
                <tr>
                  <td>
                    <xsl:call-template name="datosComercial"/>
                  </td>
                </tr>
              </xsl:when>
              <xsl:otherwise> 
                <tr>
                  <td colspan="4">
                    datos cliente:
                  </td>
                </tr>
                <tr>
                  <td>
                    <xsl:call-template name="datosComprador"/>
                  </td>
                </tr>
                </xsl:otherwise>	
              </xsl:choose>
        </table>
      </td>
    </tr>
  </xsl:template>
  
  <!--
   
   template para los datos del proveedor
   
  -->
  
  <xsl:template name="datosComercial">
    <table width="100%" align="center" class="claro">
      <tr align="center">
        <td>
          <b> 
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0710' and @lang=$lang]" disable-output-escaping="yes"/>
          </b>
          &nbsp;
          <xsl:value-of select="VENDEDOR"/>
          ,&nbsp;
          <b>
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0111' and @lang=$lang]" disable-output-escaping="yes"/>
          </b>
          &nbsp;
          <xsl:value-of select="PROVEEDOR"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <!--
  
     template para los datos del cliente
  
  -->
  
  <xsl:template name="datosComprador">
    <table width="100%" align="center" class="claro">
      <tr align="center">
        <td>
          <b> 
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0700' and @lang=$lang]" disable-output-escaping="yes"/>
          </b>
          &nbsp;
          <xsl:value-of select="COMPRADOR"/>
          ,&nbsp;
          <b>
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='MO-0109' and @lang=$lang]" disable-output-escaping="yes"/>
          </b>
          &nbsp;
          <xsl:value-of select="CLIENTE"/>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  
  <!--
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           template principal - -  template principal - -  template principal - -  template principal - -  template principal  
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
    template de la cabecera de la oferta
    info no editable
    dentro este se llaman a mas templates
    
        -tituloMultioferta
        -numOfertaPedido
        -datosUsuario
        -datosPedido
  -->
  
  <xsl:template name="cabeceraMultioferta">
    <xsl:param name="estado"/>
    <xsl:param name="tipo"/>
    
   <table class="muyoscuro" width="100%" border="0" align="center" cellspacing="1" cellpadding="1">
     <tr bgcolor="#A0D8D7">
       <td colspan="4">
         <!-- titutlo de la oferta -->
         <xsl:call-template name="tituloMultioferta"/>
       </td>
     </tr>
     
         <!-- numero oferta pedido -->
     <xsl:call-template name="numOfertaPedido">
       <xsl:with-param name="tipo" select="$tipo"/>
     </xsl:call-template>
     
        <!-- datos del usuario -->
     <xsl:call-template name="datosUsuario">
       <xsl:with-param name="rol"><xsl:value-of select="//ROL"/></xsl:with-param>
     </xsl:call-template>
     
     <tr bgcolor="#EEFFFF">
       <td colspan="4">
         mas cosas
       </td>
     </tr>
   </table> 
  </xsl:template>
  
</xsl:stylesheet>