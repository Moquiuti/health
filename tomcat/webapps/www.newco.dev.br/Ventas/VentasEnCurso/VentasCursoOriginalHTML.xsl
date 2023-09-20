<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0110' and @lang=$lang]" disable-output-escaping="yes"/></title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<SCRIPT type="text/javascript">
	<!--			 	
	function mostrar(sel,num){
		var capa=sel.selField.selectedIndex;		          		
		if (navigator.appName=="Netscape") {
			//Netscape
			for(i=0; i<num; i++){
			  valopt = sel.selField.options[i].value;
			  if(i==capa){
			    document.layers['l'+valopt].visibility='show';			
			    }else{
			    document.layers['l'+valopt].visibility='hide';
			  }
			}
			return true;
		}
		else	{
			for(i=0; i<num; i++){
		          valopt = sel.selField.options[i].value;
			  if(i==capa){
			    document.all['l'+valopt].style.visibility='visible';			
			    }else{
			    document.all['l'+valopt].style.visibility='hidden';
			  }
			}
			return true;
		}
	}
	function Habilita(){
		if (navigator.appName=="Microsoft Internet Explorer")	{
			document.forms['form1'].selField.disabled=false;
			return true;
		}	
	}	
	//-->   	
	</SCRIPT>        
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF" onLoad="Habilita()">      
        <xsl:choose>
          <xsl:when test="Generar/xsql-error"> 
          <p class="tituloForm">     
            <xsl:apply-templates select="Generar/xsql-error"/>
          </p>
          </xsl:when>
          <xsl:otherwise>                    
	    <p id="titulo" class="tituloPag" style="position:absolute;top:0px;left:300px">
	      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CVA-0100' and @lang=$lang]" disable-output-escaping="yes"/>
	    </p>  	    	    
	   <!--<p id="buttons" style="position:absolute;visibility:visible;top:0px;left:320px">
	      <table width="100%" border="0">	    
	        <tr>
		  <xsl:for-each select="Generar/button">
		    <td align="center">		  		  
		      <xsl:apply-templates select="."/>
                    </td>
                  </xsl:for-each>                    
                </tr>  	  
              </table>
            </p>-->	    
	    <xsl:variable name="num_plantillas"><xsl:value-of select = "count(//MULTIOFERTAS)" /></xsl:variable>                	    
	    <xsl:apply-templates select="Generar/LISTAPROCESOS"/>                    
            <xsl:apply-templates select="Generar/LISTAPROCESOS/MULTIOFERTAS"/>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="LISTAPROCESOS">
  <p id="principal" style="z-index:1;position:absolute;overflow:auto;visibility:visible;width:280px;height:440px;left:0px;top:0px">
    <form name="form1" method="post">    
    <select name="selField" size="25" disabled="disabled">
      <xsl:attribute name="onChange">mostrar(this.form,<xsl:value-of select = "$num_plantillas"/>);</xsl:attribute>
      <xsl:for-each select="MULTIOFERTAS">               
        <option>
          <xsl:attribute name="value"><xsl:value-of select="MO_ID"/></xsl:attribute>
          <xsl:value-of select="LP_FECHAEMISION"/>:<xsl:value-of select="LP_NOMBRE"/>
        </option> 
      </xsl:for-each>            
    </select>     
    </form>
  </p>    
</xsl:template>


<xsl:template match="MULTIOFERTAS">                   
  <div>
    <xsl:attribute name="id">l<xsl:value-of select="MO_ID"/></xsl:attribute>
    <xsl:attribute name="style">
      z-index:<xsl:value-of select="MO_ID+2"/>;overflow:auto;position:absolute;left:300px;top:25px;height:380px;
      <xsl:choose>
      <xsl:when test="position()=1">visibility:visible;</xsl:when>
      <xsl:otherwise>visibility:hidden;</xsl:otherwise>
      </xsl:choose>      
    </xsl:attribute>       
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td colspan="5"><table width="100%" border="1" bordercolor="#A0D8D7" cellpadding="0" cellspacing="0"><tr><td><table width="100%" cellpadding="0" cellspacing="0" border="0"><tr valign="top">
        <td><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0010' and @lang=$lang]"/>
          </p></td>
        <td>
          <xsl:value-of select="EMP_NOMBRE"/>
          </td>
        <td><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0020' and @lang=$lang]"/>
          </p></td>
        <td>
          <xsl:value-of select="US_NOMBRE"/>
          </td>
       </tr>
       <tr colspan="5"><td>&nbsp;</td></tr>       
        <tr valign="top">
        <td><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0030' and @lang=$lang]"/>
          </p></td>
        <td>
                  <xsl:choose>
                  <xsl:when test="STATUS_COLOR[.='OPONENT_SIDE']">
                          <xsl:attribute name="class">color:gray</xsl:attribute>
                          <xsl:value-of select="STATUS_DESC"/>  
                  </xsl:when>
                  <xsl:when test="STATUS_COLOR[.='DEAD_PROCESS']">
                          <xsl:attribute name="class">color:black</xsl:attribute>
                           <xsl:value-of select="STATUS_DESC"/>  
                  </xsl:when>          
                  <xsl:when test="STATUS_COLOR[.='ACTION_REQUIRED']">
                          <a>
                          <xsl:attribute name="href">http://www.newco.dev.br/Compras/Multioferta/Multioferta.xsql?MO_ID=<xsl:value-of select="MO_ID"/></xsl:attribute>
                          <xsl:attribute name="onMouseOver">window.status='Abrir multioferta.';return true;</xsl:attribute>
        	          <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
                          <xsl:attribute name="class">color:blue</xsl:attribute>
                          <xsl:value-of select="STATUS_DESC"/>
                          </a>
                  </xsl:when>
                </xsl:choose>
          </td>         
        <td><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0040' and @lang=$lang]"/>
          </p></td>
        <td>
          <xsl:value-of select="PED_IMPORTE_TOTAL"/>
          </td>         
       </tr>             
     <tr valign="top">
        <td><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0050' and @lang=$lang]"/>
          </p></td>
        <td>
          <xsl:value-of select="LP_FECHADECISION"/>
          </td>        
        <td><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0060' and @lang=$lang]"/>
          </p></td>
        <td>
          <xsl:value-of select="LP_FECHAENTREGA"/>
          </td>
       </tr>
       <!--
       |
       |        Incluimos todas las lineas de la multioferta
       |
       +-->
       </table></td></tr></table></td></tr>
       <tr colspan="5"><td>&nbsp;</td></tr>
       <tr>
         <td colspan="5"><p class="tituloForm"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0070' and @lang=$lang]"/>                
         </p></td>
       </tr>
       <tr colspan="5"><td>&nbsp;</td></tr>
       <tr valign="top" bgcolor="#A0D8D7">
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0300' and @lang=$lang]"/>                
         </p></td>
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0310' and @lang=$lang]"/>                
         </p></td>
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0320' and @lang=$lang]"/>                
         </p></td>
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0330' and @lang=$lang]"/>                
         </p></td>
         <td><p class="tituloCamp"> 
                <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='VC-0340' and @lang=$lang]"/>                
         </p></td>
       </tr>
       <tr colspan="5"><td>&nbsp;</td></tr>
       <xsl:for-each select="LINEAS_MULTIOFERTA/LINEAS_MULTIOFERTA_ROW">
        <tr valign="top">       
          <td>
            <xsl:value-of select="LMO_IDPRODUCTO"/>
          </td>
          <td>
            <xsl:value-of select="PRO_NOMBRE"/>
          </td>
          <td>
            <xsl:value-of select="LMO_CANTIDAD"/>
          </td>
          <td>
            <xsl:value-of select="LMO_PRECIO"/>
          </td>
          <td>
            <xsl:value-of select="LMO_TOTAL"/>
          </td>
       </tr>
           
       </xsl:for-each>
       

    </table> 
  </div>    	     
</xsl:template> 

</xsl:stylesheet>
