<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">
 
    <html> 
      <head> 
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">	
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        <script type="text/javascript">
        <!--
          function Actua(formu){
            //if (test(formu))
              SubmitForm(formu);
          }
        //-->
        </script>                
        ]]></xsl:text>
      </head>
	
      <body bgcolor="#EEFFFF">
        <!-- Variable ESTADOG valor='1' en historico y en estado '5'. Valor='2' en otros.-->
        <!-- SU_SUBCODIGO[.>0] para los ciclos mayores de uno --> 
      	  <xsl:variable name="EstadoG" select="1"/>  
          <xsl:apply-templates select="DOCUMENTOWORKFLOW/SUGERENCIA/SUGERENCIAPASO">
            <xsl:with-param name="EstadoG" select="$EstadoG"/>
          </xsl:apply-templates>  
	  <xsl:choose>
            <xsl:when test="DOCUMENTOWORKFLOW/SUGERENCIAPASO/ESTADO[.!=5]">
              <xsl:variable name="EstadoG" select="2"/>               
              <xsl:apply-templates select="DOCUMENTOWORKFLOW/SUGERENCIAPASO">
                <xsl:with-param name="EstadoG" select="$EstadoG"/>
              </xsl:apply-templates>                      
            </xsl:when>  
            <xsl:when test="DOCUMENTOWORKFLOW/SUGERENCIAPASO/ESTADO[.=5]">
              <p class="tituloForm">
              <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0303' and @lang=$lang]"/>
              </p>
            </xsl:when>
          </xsl:choose>   
	  <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0">
	    <tr valign="top" bgcolor="#EEFFFF"> 
	      <td align="center">  
	        <xsl:apply-templates select="DOCUMENTOWORKFLOW/SUGERENCIAPASO/jumpTo"/>
	      </td> 
	      <td width="80%">&nbsp;</td>     
	      <td align="center">  
	        <xsl:apply-templates select="DOCUMENTOWORKFLOW/SUGERENCIAPASO/button"/>
	      </td> 
	    </tr>	    	    
          </table>	 
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="Sorry">
  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="SUGERENCIA">

  <xsl:for-each select="SUGERENCIAPASO">
    <xsl:apply-templates select="ESTADO"/>
  </xsl:for-each>
</xsl:template>

<xsl:template match="SUGERENCIAPASO">
  
  <xsl:param name="EstadoG"/>
  
  <xsl:choose>        
    <xsl:when test="$EstadoG='2'">  
      <form name="SUGERENCIAPASO" method="post"> 
	<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>             
	<xsl:apply-templates select="ESTADO"/>
      </form>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="ESTADO"/>    
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="ESTADO[.='1']">

<xsl:param name="EstadoG"/>

<input type="hidden" name="ESTADO" value="{.}"/>
<input type="hidden" name="SU_IDEMPRESA" value="{../ EMP_ID}"/>
<input type="hidden" name="SU_IDAUTOR" value="{../ US_ID}"/>

  <table width="100%" border="0" cellspacing="0" cellpadding="0" >	
   <xsl:choose>        
     <xsl:when test="$EstadoG='2'">
       <tr bgcolor="#A0D8D7">
         <td colspan="3"><p class="tituloForm"> 
           <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0310' and @lang=$lang]"/></p></td>
         <td align="right"><p class="tituloForm"> 
           <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0302' and @lang=$lang]"/>&nbsp;</p></td></tr>              
     </xsl:when>
     <xsl:when test="$EstadoG!='2'">
       <tr bgcolor="#A0D8D7">
         <td colspan="3"><p class="tituloForm"> 
           <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0310' and @lang=$lang]"/></p></td>
         <td align="right"><p class="tituloForm"> 
           <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0301' and @lang=$lang]"/>&nbsp;</p></td></tr>       
     </xsl:when>
   </xsl:choose>
          
    <tr><td colspan="4">&nbsp;</td></tr>    	
    <tr> 
      <td width="20%"><p class="tituloCamp">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0320' and @lang=$lang]"/>:
        </p></td>
      <td width="30%">  
        <xsl:apply-templates select="../FECHA"/>
        </td>
      <td width="15%"><p class="tituloCamp">  
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0340' and @lang=$lang]"/>:
        </p></td>
      <td width="35%">   
        <xsl:apply-templates select="../EMP_NOMBRE"/>
        </td>        
    </tr>		    		          	          	    
    <tr> 
      <td width="20%"><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0330' and @lang=$lang]"/>:
        </p></td>
      <td width="30%">  
        <xsl:apply-templates select="../NOMBRE"/>
        </td>
      <td width="20%"><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0331' and @lang=$lang]"/>:
        </p></td>
      <td width="30%">  
        <xsl:apply-templates select="../CARGO"/>
      </td>
    </tr>
 
    <xsl:choose>
    <xsl:when test="$EstadoG='2'">
    <tr>
          <td><p class="tituloCamp"> 
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0350' and @lang=$lang]"/>:
            </p></td>
          <td colspan="3">   	
            <xsl:apply-templates select="../DEPARTAMENTOS"/>
          </td>
    </tr>
      </xsl:when> 
    </xsl:choose>                         
	
    <tr valign="top"> 
      <td><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0360' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">           
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
	    <xsl:apply-templates select="../SU_RESUMEN"/>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
	    <input type="text" size="52" name="SU_RESUMEN">
	      <xsl:attribute name="value"></xsl:attribute>      
	    </input> 
	  </xsl:when>  
	</xsl:choose>     
      </td>
    </tr>
    <tr valign="top"> 
      <td><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping = "yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0370' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">           
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
	    <xsl:apply-templates select="../SU_DETALLE"/>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
	    <textarea name="SU_DETALLE" cols="51" rows="5">       
	    </textarea> 
	  </xsl:when>  
	</xsl:choose>     
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>	            	
  </table>		      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>

<xsl:template match="ESTADO[.='2']">

<xsl:param name="EstadoG"/>

<input type="hidden" name="ESTADO">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>      
</input>
<input type="hidden" name="SU_IDEMPRESA">
    <xsl:attribute name="value">
      <xsl:value-of select="../ EMP_ID"/>
    </xsl:attribute>     
</input>
<input type="hidden" name="SU_IDAUTOR">
    <xsl:attribute name="value">
      <xsl:value-of select="../US_ID"/>
    </xsl:attribute>     
</input>
<input type="hidden" name="CODIGO">
    <xsl:attribute name="value">
      <xsl:value-of select="/DOCUMENTOWORKFLOW/SUGERENCIA/SUGERENCIAPASO/SU_CODIGO"/>
    </xsl:attribute>     
</input>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >	
    <tr bgcolor="#A0D8D7"> 
    <xsl:choose>
      <xsl:when test="../SU_SUBCODIGO[.=0]">
      <td colspan="3"><p class="tituloForm"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0380' and @lang=$lang]"/>
        </p></td>
      <xsl:choose>        
      <xsl:when test="$EstadoG='2'">
      <td align="right"><p class="tituloForm">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0302' and @lang=$lang]"/>&nbsp;
        </p></td>               
      </xsl:when>
      <xsl:when test="$EstadoG!='2'">
      <td align="right"><p class="tituloForm">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0301' and @lang=$lang]"/>&nbsp;
        </p></td>        
      </xsl:when>
      </xsl:choose>               
      </xsl:when>           
      <xsl:when test="../SU_SUBCODIGO[.>0]">
      <td colspan="3"><p class="tituloForm">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0380' and @lang=$lang]"/>
        </p></td>
      <td width="20%" align="right"><p class="tituloForm">
        <xsl:choose>        
          <xsl:when test="$EstadoG='2'">             
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0302' and @lang=$lang]"/>&nbsp;
          </xsl:when>
          <xsl:when test="$EstadoG!='2'">
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0301' and @lang=$lang]"/>&nbsp;
          </xsl:when>
        </xsl:choose>
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0304' and @lang=$lang]"/>&nbsp;        
        <xsl:value-of select="../SU_SUBCODIGO/.+1"/>&nbsp;
        </p></td>
      </xsl:when>     
    </xsl:choose>      
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>    	
    <tr> 
      <td width="10%"><p class="tituloCamp">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0320' and @lang=$lang]"/>:
        </p></td>
      <td width="40%">  
        <xsl:apply-templates select="../FECHA"/>
        </td>
      <td width="10%"><p class="tituloCamp">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0330' and @lang=$lang]"/>:
        </p></td>
      <td width="40%">
        <xsl:apply-templates select="../NOMBRE"/>
      </td>      
    </tr>		    		          	          	    
    <tr> 
      <td width="10%"><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0390' and @lang=$lang]"/>:
        </p></td>
      <td width="40%">  
        <xsl:choose>
	  <xsl:when test="$EstadoG='1'">
            <xsl:variable name="IDAct" select="OPCIONVARIABLE"/>
	    <xsl:apply-templates select="../OPCIONVARIABLE">
	      <xsl:with-param name="EstadoG" select="$EstadoG"/>
      </xsl:apply-templates>  
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'">  
            <xsl:apply-templates select="../PRIORIDAD/RESTOPRIORIDADES"/>   
	  </xsl:when>  
        </xsl:choose>               
      </td>
      <xsl:choose>
	<xsl:when test="$EstadoG='1'"><td colspan="2">&nbsp;</td>
	  </xsl:when>
	<xsl:when test="$EstadoG='2'"> 
          <td width="10%"><p class="tituloCamp"> 
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0400' and @lang=$lang]"/>:
            </p></td>
          <td width="40%">   
            <xsl:apply-templates select="../PRIORIDAD/DESCARTADO"/>
            </td>   
	</xsl:when>  
      </xsl:choose>     
    </tr>	
    <tr valign="top"> 
      <td><p class="tituloCamp">  
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0410' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">           
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
	    <xsl:apply-templates select="../SU_RESUMEN"/>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
	    <input type="text" size="52" name="SU_RESUMEN">
	      <xsl:attribute name="value"></xsl:attribute>      
	    </input> 
	  </xsl:when>  
	</xsl:choose>     
      </td>
    </tr>
    <tr valign="top"> 
      <td><p class="tituloCamp">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0420' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">           
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
	    <xsl:apply-templates select="../SU_DETALLE"/>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
	    <textarea name="SU_DETALLE" cols="51" rows="5">       
	    </textarea> 
	  </xsl:when>  
	</xsl:choose>     
      </td>
    </tr>
    <tr> 
      <td width="10%"><p class="tituloCamp">       
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0350' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">         
        <xsl:variable name="IDAct" select="RESPONSABLE"/>
        <xsl:apply-templates select="../RESPONSABLE"/>                
      </td>
      </tr>
      <tr>
      <td width="10%"><p class="tituloCamp">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0430' and @lang=$lang]"/>:
        </p></td>       
      <td colspan="3">          
	 <xsl:choose>
	    <xsl:when test="$EstadoG='1'">     
              <xsl:apply-templates select="../SU_FECHAPREVISTA"/>
	    </xsl:when>
	    <xsl:when test="$EstadoG='2'"> 
	      <input type="text" name="FECHANO_PREVISTA" size="10" maxlength="10">
		<xsl:attribute name="value">
		</xsl:attribute>      
	      </input>
	      <text>dd/mm/aaaa</text>
	    </xsl:when>  
	  </xsl:choose>         
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>	            	
  </table>
		      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>
 
<xsl:template match="ESTADO[.='3']">

<xsl:param name="EstadoG"/>

<input type="hidden" name="ESTADO">
    <xsl:attribute name="value">
      <xsl:value-of select="."/>
    </xsl:attribute>      
</input>
<input type="hidden" name="SU_IDEMPRESA">
    <xsl:attribute name="value">
      <xsl:value-of select="../ EMP_ID"/>
    </xsl:attribute>     
</input>
<input type="hidden" name="SU_IDAUTOR">
    <xsl:attribute name="value">
      <xsl:value-of select="../ US_ID"/>
    </xsl:attribute>     
</input>
<input type="hidden" name="CODIGO">
    <xsl:attribute name="value">
      <xsl:value-of select="/DOCUMENTOWORKFLOW/SUGERENCIA/SUGERENCIAPASO/SU_CODIGO"/>
    </xsl:attribute>     
</input>

  <table width="100%" border="0" cellspacing="0" cellpadding="0" >	
    <tr bgcolor="#A0D8D7"> 
    <xsl:choose>
      <xsl:when test="../SU_SUBCODIGO[.=0]">
      <td colspan="3"><p class="tituloForm"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0440' and @lang=$lang]"/>
        </p></td>
      <xsl:choose>        
      <xsl:when test="$EstadoG='2'">
      <td align="right"><p class="tituloForm">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0302' and @lang=$lang]"/>&nbsp;
        </p></td>               
      </xsl:when>
      <xsl:when test="$EstadoG!='2'">
      <td align="right"><p class="tituloForm">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0301' and @lang=$lang]"/>&nbsp;
        </p></td>        
      </xsl:when>
      </xsl:choose>               
      </xsl:when>
     
      <xsl:when test="../SU_SUBCODIGO[.>0]">
      <td colspan="3"><p class="tituloForm"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0440' and @lang=$lang]"/>
        </p></td>
      <td width="20%" align="right"><p class="tituloForm">
        <xsl:choose>        
          <xsl:when test="$EstadoG='2'">             
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0302' and @lang=$lang]"/>&nbsp;
          </xsl:when>
          <xsl:when test="$EstadoG!='2'">
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0301' and @lang=$lang]"/>&nbsp;
          </xsl:when>
        </xsl:choose>
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0304' and @lang=$lang]"/>&nbsp;
        <xsl:value-of select="../SU_SUBCODIGO/.+1"/>&nbsp;
        </p></td>
      </xsl:when>     
    </xsl:choose>      
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr> 	
    <tr> 
      <td width="10%"><p class="tituloCamp">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0320' and @lang=$lang]"/>:
        </p></td>
      <td width="40%">  
        <xsl:apply-templates select="../FECHA"/>
        </td>
      <td width="10%"><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0330' and @lang=$lang]"/>:
        </p></td>
      <td width="40%">  
        <xsl:apply-templates select="../NOMBRE"/>
        </td>      
    </tr>	    		          	          	    
    <tr> 
      <td width="20%"><p class="tituloCamp"> 
      <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0450' and @lang=$lang]"/>:
      </p></td>
      <td colspan="3"> 
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
            <xsl:variable name="IDAct" select="OPCIONVARIABLE"/>
            <xsl:apply-templates select="../OPCIONVARIABLE">
              <xsl:with-param name="EstadoG" select="$EstadoG"/>
            </xsl:apply-templates>
            
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'">
	    <xsl:variable name="IDAct" select="OPCIONVARIABLE"/>
	    
            <xsl:apply-templates select="../OBJETIVO"/> 
 	  </xsl:when>  
	</xsl:choose> 
      </td>
    </tr>
    <tr valign="top"> 
      <td><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0410' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">           
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
	    <xsl:apply-templates select="../SU_RESUMEN"/>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
	    <input type="text" size="50" name="SU_RESUMEN">
	      <xsl:attribute name="value"></xsl:attribute>      
	    </input> 
	  </xsl:when>  
	</xsl:choose>     
      </td>
    </tr>
    <tr valign="top"> 
      <td><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0460' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">           
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
	    <xsl:apply-templates select="../SU_DETALLE"/>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
	    <textarea name="SU_DETALLE" cols="49" rows="5">       
	    </textarea> 
	  </xsl:when>  
	</xsl:choose>     
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>	            	
  </table>		      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>

<xsl:template match="ESTADO[.='4']">

<xsl:param name="EstadoG"/>

<input type="hidden" name="ESTADO">
    <xsl:attribute name="value">
      <xsl:value-of select="."/> 
    </xsl:attribute>      
</input>
<input type="hidden" name="SU_IDEMPRESA">
    <xsl:attribute name="value">
      <xsl:value-of select="../ EMP_ID"/>
    </xsl:attribute>     
</input>
<input type="hidden" name="SU_IDAUTOR">
    <xsl:attribute name="value">
      <xsl:value-of select="../ US_ID"/>
    </xsl:attribute>     
</input>
<input type="hidden" name="CODIGO">
    <xsl:attribute name="value">
      <xsl:value-of select="/DOCUMENTOWORKFLOW/SUGERENCIA/SUGERENCIAPASO/SU_CODIGO"/>
    </xsl:attribute>     
</input>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >	
    <tr bgcolor="#A0D8D7"> 
    <xsl:choose>
      <xsl:when test="../SU_SUBCODIGO[.=0]">
      <td colspan="3"><p class="tituloForm"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0470' and @lang=$lang]"/>
        </p></td>
      <xsl:choose>        
        <xsl:when test="$EstadoG='2'">
        <td align="right"><p class="tituloForm">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0302' and @lang=$lang]"/>&nbsp;
          </p></td>               
        </xsl:when>
        <xsl:when test="$EstadoG!='2'">
        <td align="right"><p class="tituloForm">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0301' and @lang=$lang]"/>&nbsp;
          </p></td>        
        </xsl:when>
      </xsl:choose>
      </xsl:when>
      
      <xsl:when test="../SU_SUBCODIGO[.>0]">
      <td colspan="3">
        <p class="tituloForm"><xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0470' and @lang=$lang]"/></p></td>
      <td width="20%" align="right"><p class="tituloForm">
        <xsl:choose>        
          <xsl:when test="$EstadoG='2'">             
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0302' and @lang=$lang]"/>&nbsp;
          </xsl:when>
          <xsl:when test="$EstadoG!='2'">
            <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0301' and @lang=$lang]"/>&nbsp;
          </xsl:when>
        </xsl:choose>
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0304' and @lang=$lang]"/>&nbsp;
        <xsl:value-of select="../SU_SUBCODIGO/.+1"/>&nbsp;
        </p></td>
      </xsl:when>     
    </xsl:choose>      
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr> 
    <tr>
      <td width="10%"><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0320' and @lang=$lang]"/>:
        </p></td>
      <td width="40%">  
        <xsl:apply-templates select="../FECHA"/>
        </td>
      <td width="10%"><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0330' and @lang=$lang]"/>:
        </p></td>
      <td width="40%">  
        <xsl:apply-templates select="../NOMBRE"/>
        </td>      
    </tr>		    		          	          	    
    <tr> 
      <td width="20%"><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0480' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3"> 
 	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
            <xsl:variable name="IDAct" select="OPCIONVARIABLE"/><!--valoracion del resultado-->
            <xsl:apply-templates select="../OPCIONVARIABLE">
              <xsl:with-param name="EstadoG" select="$EstadoG"/>
            </xsl:apply-templates>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
            <xsl:variable name="IDAct" select="OPCIONVARIABLE"/>
            <xsl:apply-templates select="../CONFORMIDAD"/>
	  </xsl:when>  
	</xsl:choose>              
      </td>
    </tr>
    <tr valign="top"> 
      <td><p class="tituloCamp"> 
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0410' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">           
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
	    <xsl:apply-templates select="../SU_RESUMEN"/>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
	    <input type="text" size="52" name="SU_RESUMEN">
	      <xsl:attribute name="value"></xsl:attribute>      
	    </input> 
	  </xsl:when>  
	</xsl:choose>     
      </td>
    </tr>
    <tr valign="top"> 
      <td><p class="tituloCamp">
        <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='SU-0490' and @lang=$lang]"/>:
        </p></td>
      <td colspan="3">           
	<xsl:choose>
	  <xsl:when test="$EstadoG='1'">
	    <xsl:apply-templates select="../SU_DETALLE"/>
	  </xsl:when>
	  <xsl:when test="$EstadoG='2'"> 
	    <textarea name="SU_DETALLE" cols="50" rows="5">       
	    </textarea> 
	  </xsl:when>  
	</xsl:choose>     
      </td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>	            	
  </table>		      	          	          	          	          	          	          	          	        	      	          	          
</xsl:template>

<xsl:template match="FECHA">
  <xsl:value-of select="."/>&nbsp; 
</xsl:template>

<xsl:template match="NOMBRE">
  <xsl:value-of select="."/>&nbsp;       
</xsl:template>

<xsl:template match="CARGO">
  <xsl:value-of select="."/>&nbsp;       
</xsl:template>

<xsl:template match="EMP_NOMBRE">
  <xsl:value-of select="."/>&nbsp;         
</xsl:template>

<xsl:template match="DEPARTAMENTOS"> 
  <xsl:variable name="IDAct" select="0"/>
  <xsl:apply-templates selected="field"/>  
</xsl:template>

<xsl:template match="SU_RESUMEN">
  <xsl:value-of select="."/>&nbsp;   
</xsl:template>

<xsl:template match="SU_DETALLE"> 
  <xsl:value-of select="."/>&nbsp;   
</xsl:template>

<xsl:template match="DESCARTADO">
  <input type="checkbox" name="DESCARTADO">
    <xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>      
  </input>  
</xsl:template>

<xsl:template match="RESTOPRIORIDADES"> 
  <xsl:variable name="IDAct" select="0"/>
  <xsl:apply-templates selected="field"/>  
</xsl:template>


<xsl:template match="OPCIONVARIABLE">

<xsl:param name="EstadoG"/>

  <xsl:choose>
    <xsl:when test="$EstadoG='1'">
      <xsl:value-of select="."/>&nbsp;
    </xsl:when>
    <xsl:when test="$EstadoG='2'"> 
      <xsl:variable name="IDAct" select="0"/>
      <xsl:apply-templates selected="field"/>
    </xsl:when>  
  </xsl:choose>  
</xsl:template>

<xsl:template match="RESPONSABLE">

<xsl:param name="EstadoG"/>

  <xsl:choose>
    <xsl:when test="$EstadoG='1'">
      <xsl:value-of select="."/>&nbsp;
    </xsl:when>
    <xsl:when test="$EstadoG='2'"> 
      <xsl:variable name="IDAct" select="0"/>
      <xsl:apply-templates selected="field"/>
    </xsl:when>  
  </xsl:choose>  
</xsl:template>

<xsl:template match="SU_FECHAPREVISTA">
  <xsl:value-of select="."/>&nbsp;  
</xsl:template>

<xsl:template match="OBJETIVO">
  <xsl:variable name="IDAct" select="0"/> 
  <xsl:apply-templates selected="field"/>  
</xsl:template>

<xsl:template match="CONFORMIDAD">
  <xsl:variable name="IDAct" select="0"/>
  <xsl:apply-templates selected="field"/> 
</xsl:template>

<xsl:template match="returnHome">
  <a>
    <xsl:attribute name="href">
    <xsl:value-of select="."/>?lang=<xsl:value-of select="$lang"/></xsl:attribute>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=10 and @lang=$lang]"/>
  </a>
</xsl:template>

</xsl:stylesheet>