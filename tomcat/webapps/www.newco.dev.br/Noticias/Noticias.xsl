<?xml version="1.0" encoding="iso-8859-1" ?>
<!-- 
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  
  <!-- 
  template de noticias
  
  -->
  
  <xsl:template match="TIPO">
    <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">  
                
      <tr bgcolor="#A0D8D7" align="center">
      <xsl:choose>
       <xsl:when test="../PUBLICA[.!='S']">
        <xsl:choose>
          <xsl:when test="//NOTICIA/TIPO[.='Z']">
            <td colspan="3" class="tituloCampBlanco">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=Z','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0300' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
              </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=N','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0290' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=C','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0310' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=P','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0320' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerTodasNoticias.xsql','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0325' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
          </xsl:when>
          <xsl:when test="//NOTICIA/TIPO[.='N']">
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=Z','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0300' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3" class="tituloCampBlanco">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=N','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0290' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
              </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=C','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0310' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=P','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0320' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerTodasNoticias.xsql','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0325' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
          </xsl:when>
          <xsl:when test="//TIPO[.='C']">
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=Z','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0300' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=N','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0290' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3" class="tituloCampBlanco">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=C','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0310' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=P','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0320' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerTodasNoticias.xsql','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0325' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
          </xsl:when>
          <xsl:when test="//TIPO[.='P']">
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=Z','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0300' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=N','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0290' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=C','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0310' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3" class="tituloCampBlanco">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql?TIPO=P','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0320' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerTodasNoticias.xsql','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0325' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
          </xsl:when>
          <xsl:otherwise>
            <td colspan="3">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0300' and @lang=$lang]" disable-output-escaping="yes"/>
            </td>
            <td colspan="3">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0290' and @lang=$lang]" disable-output-escaping="yes"/>
            </td>
            <td colspan="3">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0310' and @lang=$lang]" disable-output-escaping="yes"/>
            </td>
            <td colspan="3">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0320' and @lang=$lang]" disable-output-escaping="yes"/>
            </td>
            <td colspan="3">
              <xsl:element name="a">
                <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerTodasNoticias.xsql','Noticias')</xsl:attribute>
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0325' and @lang=$lang]" disable-output-escaping="yes"/>
              </xsl:element>
            </td>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <td class="tituloCamp">
          <xsl:element name="a">
            <xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerTodasNoticiasPublicas.xsql','Noticias')</xsl:attribute>
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0335' and @lang=$lang]" disable-output-escaping="yes"/>
          </xsl:element>
        </td>
      </xsl:otherwise>
    </xsl:choose>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template match="NOTICIA">   
    <table width="100%" border="0" cellpadding="0" cellspacing="2">
      <tr align="center" height="35px">
        <td width="100px"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='WF-0330' and @lang=$lang]" disable-output-escaping="yes"/><br/><xsl:value-of select="FECHA"/></td>
        <td width="*" class="tituloCamp">
          <!--<xsl:element name="a">-->
            <!--<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticia.xsql?ID=<xsl:value-of select='ID'/>')</xsl:attribute>-->
            <!--<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Noticias/VerNoticias.xsql','Noticias')</xsl:attribute>-->
            <xsl:value-of select="TITULO"/>
          <!--</xsl:element>-->
        </td>
      </tr>
      <tr>
        <td colspan="2" align="center"><hr/></td>
      </tr>
      <tr align="center">
        <td width="100px" valign="top">
          <xsl:choose>
            <xsl:when test="TIPO[.='Z']">
              <img src="http://www.newco.dev.br/images/nota.gif"/>
            </xsl:when>
            <xsl:when test="TIPO[.='N']">
              <img src="http://www.newco.dev.br/images/periodico.gif"/>
            </xsl:when>
            <xsl:when test="TIPO[.='C']">
              <img src="http://www.newco.dev.br/images/tips.gif"/>
            </xsl:when>
            <xsl:when test="TIPO[.='P']">
              <img src="http://www.newco.dev.br/images/faq.gif"/>
            </xsl:when>
          </xsl:choose>
        </td>
        <td width="*">
        	<xsl:copy-of select="TEXTO"/>
        </td>
      </tr>
    </table>
  </xsl:template>
   
</xsl:stylesheet>
