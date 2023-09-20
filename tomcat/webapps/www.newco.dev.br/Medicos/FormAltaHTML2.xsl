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
      <body>
        <xsl:apply-templates select="Especialidades/field/dropDownList">
          <xsl:with-param name="nombre">laLista</xsl:with-param>
        </xsl:apply-templates>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="dropDownList">
    <select>
      <xsl:attribute name="name"><xsl:value-of select="../@name"/></xsl:attribute>
      <!-- <xsl:copy> -->
      
      <xsl:for-each select="listElem">
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem" disable-output-escaping="yes"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem" disable-output-escaping="yes"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  <xsl:template match="dropDownList">
  <xsl:param name="nombre"/>
    <select>
      <xsl:attribute name="name"><xsl:value-of select="$nombre"/></xsl:attribute>
      <!-- <xsl:copy> -->
      
      <xsl:for-each select="listElem">
        <xsl:choose>
          <xsl:when test="ID = ninguno">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem" disable-output-escaping="yes"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem" disable-output-escaping="yes"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  </xsl:stylesheet>