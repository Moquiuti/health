<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0010' and @lang=$lang]" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
        <xsl:choose>
          <xsl:when test="ListaUsuarios/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>          
          </xsl:when>
        <xsl:when test="ListaUsuarios/ROWSET/ROW/Sorry">
	   <form method="post" name="Sorry">
             <xsl:apply-templates select="//Sorry"/>
             <br/><br/>
             <center><xsl:apply-templates select="//jumpTo"/></center></form>
        </xsl:when>
        <xsl:otherwise>
          <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" >
	    <!-- Formulario de datos -->
	    <tr align="center"> 
	      <td colspan="3" valign="top">  
	        <p class="tituloForm">          
	          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0010' and @lang=$lang]" disable-output-escaping="yes"/>
	        </p>	         
	      </td>
	    </tr>
	    <tr><td colspan="3">&nbsp;</td></tr>  	                     
            <tr bgcolor="#A0D8D7">
              <td width="33%"><p class="tituloCamp">
                <!-- Login -->
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0110' and @lang=$lang]" disable-output-escaping="yes"/>
                </p></td>
              <td width="34%"><p class="tituloCamp">
                <!-- Nombre Usuario -->
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0050' and @lang=$lang]" disable-output-escaping="yes"/>
                </p></td>
              <td width="33%"><p class="tituloCamp">
                <!-- Departamento -->
                <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0120' and @lang=$lang]" disable-output-escaping="yes"/>
                </p></td>
            </tr>
            <tr><td colspan="3">&nbsp;</td></tr>
            <xsl:for-each select="ListaUsuarios/ROWSET/ROW">
              <tr>
                <td width="15%"><xsl:apply-templates select="US_USUARIO"/></td>
                <td width="50%"><xsl:apply-templates select="NOMBRE"/></td>
                <td width="35%"><xsl:apply-templates select="DEPARTAMENTO"/></td>
              </tr>
            </xsl:for-each>
            <tr bgcolor="#EEFFFF"><td colspan="3">&nbsp;</td></tr>
            <tr bgcolor="#EEFFFF"><td colspan="3"><table width="100%"><tr align="center" valign="top">
              <td>
                <xsl:apply-templates select="ListaUsuarios/jumpTo"/>
              </td> 
              <td width="60%">&nbsp;</td>              
              <xsl:apply-templates select="ListaUsuarios/ExtraButtons"/>             
            </tr></table></td></tr>
          </table> 
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->
  
  <xsl:template match="US_USUARIO">
        <xsl:value-of select="."/> 
   </xsl:template> 
  
  <xsl:template match="DEPARTAMENTO">
        <xsl:value-of select="."/> 
   </xsl:template> 

  <xsl:template match="NOMBRE">
    <a>
     <xsl:attribute name="href">USManten.xsql?LANG=<xsl:value-of select="$lang"/>&amp;ID_USUARIO=<xsl:value-of select="../ID"/>&amp;EMP_ID=<xsl:value-of select="../EMP_ID"/>
     </xsl:attribute>
     <xsl:value-of select="."/>
    </a>
  </xsl:template>
   
  <xsl:template match="Sorry">
    <h1><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0320' and @lang=$lang]" disable-output-escaping="yes"/></h1>    
    <h2><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0330' and @lang=$lang]" disable-output-escaping="yes"/></h2>        
  </xsl:template>
  
  <!-- ** ** ** Empiezan las definiciones ** ** ** ** -->
<xsl:template match="ExtraButtons">
    <!-- Cada button corresponde a un form 
     |     con campos ocultos /field y un submit /button 
     +-->
    <xsl:for-each select="formu">
    <xsl:choose>
    <xsl:when test="@name='dummy'">
      <!-- Colocamos form chorra porque el javascript tiene problemas con el primer formulario 
           anidado -->
      <form method="post">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="action">
          <xsl:value-of select="@action"/>
        </xsl:attribute>    
      </form>
    </xsl:when>
    <xsl:otherwise>
    <td colspan="2">   
      <form method="post">    
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="action">
          <xsl:value-of select="@action"/>
        </xsl:attribute>
        
        <!-- Ponemos los campos input ocultos -->
        <xsl:for-each select="field">
           <input>
           <!-- Anyade las opciones comunes al campo input -->
                <xsl:attribute name="type">
                  <xsl:value-of select="@type"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                  <xsl:value-of select="@name"/>
                </xsl:attribute>
           <!-- Anyadimos los valores, que son diferentes para cada field -->
           <xsl:choose>
            <!-- Campo EMP_ID -->
             <xsl:when test="EMP_ID">
               <xsl:attribute name="value">
               <xsl:value-of select="EMP_ID"/>
               </xsl:attribute>             
             </xsl:when>
             <!-- Campo ID_USUARIO -->
             <xsl:when test="ID_USUARIO">
               <xsl:attribute name="value">
               <xsl:value-of select="ID_USUARIO"/>
               </xsl:attribute>             
             </xsl:when>           
           </xsl:choose>
           </input>
        </xsl:for-each>
        
        <!-- Anyadimos el boton de submit -->                
          <xsl:apply-templates select="button"/>     
      </form>
    </td>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>   
</xsl:template>

</xsl:stylesheet>