<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |  This stylesheet implements multi-language at the UI level
 |  It is based on the parameter 'lang' that is 'english' by default.
 |  It can be also 'french' or 'spanish' or 'german'.
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html"/> <!-- encoding="iso-8859-1"/>-->
  <xsl:param name="lang" select="@lang"/>  

  <xsl:template match="/">
    <html>
      <head>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
	<SCRIPT type="text/javascript">
	<!--
        Actualitza_Cookie('PLLista','Iniciar');	
	function SituaDivs(){
	  if (is_nav){
	    if (is_nav5up){
	      document.getElementById('titulo').style.left=window.screen.availWidth*43/100;
	      document.getElementById('titulo').style.width=window.screen.availWidth*20/100;
	      document.getElementById('titulo').style.visibility='visible';
	      document.getElementById('buttons').style.left=window.screen.availWidth*25/100;
	      document.getElementById('buttons').style.width=window.screen.availWidth*52/100;
	      document.getElementById('buttons').style.visibility='visible';
	      document.getElementById('principal').style.width=window.screen.availWidth*25/100;
	      document.getElementById('principal').style.height=window.screen.availHeight*75/100;	      	      
	      document.getElementById('principal').style.visibility='visible';
	    }else{
	      document.layers['titulo'].left=window.outerWidth*40/100;
	      //document.layers['titulo'].width=window.outerWidth*20/100;
	      document.layers['titulo'].visibility='show';
	      document.layers['buttons'].left=window.outerWidth*20/100;	      		    
	      //document.layers['buttons'].width=window.outerWidth*50/100;
	      document.layers['buttons'].visibility='show';
	      //document.layers['principal'].width=window.outerWidth*20/100;	      		    
	      //document.layers['principal'].height=window.outerHeigth*50/100;
	      document.layers['principal'].visibility='show';     	      	      
	    }
	  }else{
	      document.getElementById('titulo').style.left=window.screen.availWidth*43/100;
	      document.getElementById('titulo').style.width=window.screen.availWidth*30/100;
	      document.getElementById('titulo').style.visibility='visible';
	      document.getElementById('buttons').style.left=window.screen.availWidth*25/100;
	      document.getElementById('buttons').style.width=window.screen.availWidth*52/100;	  
	      document.getElementById('buttons').style.visibility='visible';	  
	      document.getElementById('principal').style.width=window.screen.availWidth*25/100;
	      document.getElementById('principal').style.height=window.screen.availHeight*75/100;	      	      
	      document.getElementById('principal').style.visibility='visible';
	  }
	  mostrarPrimera();	
	}
	function mostrarPrimera(){
	  if (is_nav){
	    if (is_nav5up==false){  
	      num=document.layers['principal'].document.forms['plantillas'].elements['selField'].length;
	    }
	    else{
	      num=document.forms['plantillas'].elements['selField'].length;
	    }
	  }else{
	    num=document.forms['plantillas'].elements['selField'].length;
	  }
	  if (num>0){	  
	    if (is_nav){
	      if (is_nav5up){
	        valopt = document.forms['plantillas'].selField.options[0].value; 
	        document.getElementById('l'+valopt).style.left=window.screen.availWidth*25/100;
	        document.getElementById('l'+valopt).style.width=window.screen.availWidth*52/100;
	        document.getElementById('l'+valopt).style.height=window.screen.availHeight*46/100;	
	        document.getElementById('l'+valopt).style.visibility='visible';	      
	      }else{
	        valopt = document.layers['principal'].document.forms['plantillas'].selField.options[0].value; 
                document.layers['l'+valopt].left=window.screen.availWidth*20/100;
                document.layers['l'+valopt].clip.width=window.screen.availWidth*60/100;
                //document.layers['l'+valopt].clip.height=window.screen.availHeight*42/100;
	        document.layers['l'+valopt].visibility='show';              
	      }
	    }else{
	        valopt = document.forms['plantillas'].selField.options[0].value; 
	        document.getElementById('l'+valopt).style.left=window.screen.availWidth*25/100;
	        document.getElementById('l'+valopt).style.width=window.screen.availWidth*52/100;
	        document.getElementById('l'+valopt).style.height=window.screen.availHeight*46/100;	
	        document.getElementById('l'+valopt).style.visibility='visible';	      
	    }
	  }
	}
	function NumeroPlantillas(){
	  //alert(document.forms['plantillas'].elements['selField'].length);
	  //num=document.forms['plantillas'].elements['selField'].name;
	  //alert(num);
	}
	function mostrar(sel,num){
		var capa=sel.selField.selectedIndex;
	          if (is_nav){
	            if (is_nav5up){     
			for(i=0; i<num; i++){
			  valopt = sel.selField.options[i].value;
			  if(i==capa){
			    document.getElementById('l'+valopt).style.visibility='visible';
			    document.getElementById('l'+valopt).style.left=window.screen.availWidth*25/100;
			    document.getElementById('l'+valopt).style.width=window.screen.availWidth*52/100;
			    document.getElementById('l'+valopt).style.height=window.screen.availHeight*46/100;
			    }else{
			    document.getElementById('l'+valopt).style.visibility='hidden';			    			    
			  }
			}
			return true;          
	            }
	            else{
			for(i=0; i<num; i++){
			  valopt = sel.selField.options[i].value;
			  if(i==capa){
			    document.layers['l'+valopt].left=window.screen.availWidth*20/100;
	    	            document.layers['l'+valopt].clip.width=window.screen.availWidth*60/100;	
	    	            //document.layers['l'+valopt].clip.height=window.screen.availHeight*42/100;			    			
			    document.layers['l'+valopt].visibility='show';
			    }else{
			    document.layers['l'+valopt].visibility='hide';
			  }
			}
			return true;
	             }
		  }
		  else	{
			for(i=0; i<num; i++){
		          valopt = sel.selField.options[i].value;
			  if(i==capa){
			    document.getElementById('l'+valopt).style.visibility='visible';			
			    document.getElementById('l'+valopt).style.left=window.screen.availWidth*25/100;			    
                            document.getElementById('l'+valopt).style.height=window.screen.availHeight*46/100;
                            document.getElementById('l'+valopt).style.width=window.screen.availWidth*52/100;
			    }else{
			    document.getElementById('l'+valopt).style.visibility='hidden';
			  }
			}
			return true;
		}
	}

	function seleccionaPrimero() {
	  formu = document.forms['plantillas'];
	    if (is_nav && (!is_nav5up)){
	      formu=document.layers['principal'].document.forms['plantillas'];	      
	    }
	    if (formu.elements['selField'].length>1){
		formu.selField.selectedIndex=0;
	    }
	}	
	
	//  formu: Objeto formulario
	//  link: Link al Ejecutable
	//  param1: Parametro PL_ID
	//  param2: Parametro BOTON
	
		
	function fica_accio(formu,link,param2) {
	  var contestacion;
	    if (is_nav){
	      if (is_nav5up){ 
	        var indx = formu.selField.selectedIndex;
	      }else{
	        var indx = document.layers['principal'].document.forms['plantillas'].selField.selectedIndex;
	        formu=document.layers['principal'].document.forms['plantillas'];	      
	      }
	    }else{
	      var indx = formu.selField.selectedIndex;
	    }
	  if (indx==-1 && param2!='Nueva'){
	    if (formu.elements['selField'].length<1){]]></xsl:text>alert('<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0145' and @lang=$lang]" disable-output-escaping="yes"/>');<xsl:text disable-output-escaping="yes"><![CDATA[}
	    else{]]></xsl:text>alert('<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0140' and @lang=$lang]" disable-output-escaping="yes"/>');<xsl:text disable-output-escaping="yes"><![CDATA[}
	  }else {
	    if ((param2!='Nueva')) {
	       var param1 = formu.selField.options[indx].value;	       
	       if (param2=='') {
		formu.action=link+"?PL_ID="+param1;
	       } 
	       else {
	         if (param2=='Eliminar'){
	           contestacion = confirm("]]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0150' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[");
	           if (!contestacion) {
	             return;
	           }
	         }         
		formu.action=link+"?PL_ID="+param1+"&BOTON="+param2;	       
	       }
	    }else {
	       // Cuando es NUEVO no validamos el indice
	       formu.action=link+"?BOTON="+param2;	       			    
	    }
	    if (param2=='Analizar' || param2=='Directo'){
	      if(MirarSiVacias(formu,param1)) SubmitForm(formu);
	    }else{	    
	    SubmitForm(formu);
	    }
	  }
	}
	
          //Mira si tenemos linias de productos en las plantillas.
          //Si las tenemos hacemos submit
          //Si no las tenemos mostramos mensaje alerta
          function MirarSiVacias(formu,plantilla){
            var ok=false;
	    ]]><![CDATA[
	    for(i=0; i<formu.elements.length; i++){
              if(formu.elements[i].name=='plantilla'+plantilla && formu.elements[i].value!=""){
                ok=true;
                break;
              }
            }
            if (ok==true){
              return true;
            }else{
              alert(']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0405' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[');
              return false;
            }
          }       	            			
	//-->
	</SCRIPT>   
        ]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF" onLoad="Actualitza_Cookie('PLLista','Terminar');SituaDivs();NumeroPlantillas();seleccionaPrimero();">      
        <xsl:choose>
          <xsl:when test="Plantillas/xsql-error">
              <xsl:apply-templates select="Plantillas/xsql-error"/>
          </xsl:when>
          <xsl:otherwise>
	    <div id="titulo" style="z-index:3;position:absolute;top:100px;left:300;visibility:hidden">
	      <p class="tituloPag"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0100' and @lang=$lang]" disable-output-escaping="yes"/></p>
	    </div>
	    <div id="buttons" style="z-index:2;position:absolute;visibility:visible;top:0;visibility:hidden;left:200">
	      <form name="botons">
	      <table border="0" width="100%" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="14%" align="center" valign="top">
                    <xsl:apply-templates select="Plantillas/ExtraButtons/button[1]"/>
                  </td>
                  <td width="14%" align="center" valign="top">
                    <xsl:apply-templates select="Plantillas/ExtraButtons/button[2]"/>
                  </td>
                  <td width="14%" align="center" valign="top">
                    <xsl:apply-templates select="Plantillas/ExtraButtons/button[4]"/>
                  </td>
                  
                  <td width="4%" align="center" valign="top">
		    &nbsp;
                  </td>
		  
		  <td width="4%" align="center" valign="top">
		    &nbsp;
                  </td>
                  
                  <td width="14%" align="center" valign="top">
                    <xsl:apply-templates select="Plantillas/ExtraButtons/button[3]"/>
                  </td>
                  
                  <td width="4%" align="center" valign="top">
		    &nbsp;
                  </td>
		  
		  <td width="4%" align="center" valign="top">
		    &nbsp;
                  </td>
		  
                  <td width="14%" align="center" valign="top">
                    <xsl:apply-templates select="Plantillas/ExtraButtons/button[5]"/>
                  </td>
                  <td width="13%" align="center" valign="top">
                    <xsl:apply-templates select="Plantillas/ExtraButtons/button[6]"/>
                  </td>                                                                                                                                              
                </tr>  
              </table>
              </form>
            </div>            	    
	    <xsl:variable name="num_plantillas"><xsl:value-of select = "count(//ROW)" /></xsl:variable>                
	    <xsl:apply-templates select="Plantillas/ROWSET"/>
          <xsl:apply-templates select="Plantillas/ROWSET/ROW"/>          
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  


<!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES --> <!-- TEMPLATES -->      

<xsl:template match="ROWSET">
    <div id="principal" style="z-index:1;position:absolute;overflow:auto;visibility:hidden;left:0;top:0">
    <form name="plantillas" method="post">
    <select name="selField" size="25">
      <xsl:attribute name="onDblClick">fica_accio(document.forms['plantillas'],'PLManten.xsql','Editar');</xsl:attribute>
      <xsl:attribute name="onChange">mostrar(this.form,<xsl:value-of select = "$num_plantillas"/>);</xsl:attribute>
      <xsl:for-each select="ROW">               
        <option>
          <xsl:attribute name="value"><xsl:value-of select="PL_ID"/></xsl:attribute>
          <xsl:value-of select="PL_NOMBRE"/>
        </option> 
      </xsl:for-each>            
    </select>        
    <xsl:for-each select="ROW">               
      <xsl:if test="LINEA/LINEA_ROW">
        <input type="hidden">
          <xsl:attribute name="name">plantilla<xsl:value-of select="PL_ID"/></xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="PL_ID"/></xsl:attribute>
        </input>  
      </xsl:if>
    </xsl:for-each>
    </form>
    </div>         
</xsl:template>

<xsl:template match="ROW">  
  <div>      
    <xsl:attribute name="id">l<xsl:value-of select="PL_ID"/></xsl:attribute>
    <xsl:attribute name="style">z-index:<xsl:value-of select="PL_NUMERO+2"/>;overflow:auto;position:absolute;top:140;left:200;visibility:hidden;    
    </xsl:attribute>
    <table width="100%" border="1" cellspacing="0" cellpadding="0">
      <tr bgcolor="#CCCCCC" align="center">
        <td width="35%"><p class="tituloCamp">
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0110' and @lang=$lang]"/>
          </p></td>
        <td width="10%"><p class="tituloCamp"> 
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0120' and @lang=$lang]"/>
          </p></td>
        <td width="20%"><p class="tituloCamp"> 
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0130' and @lang=$lang]"/>
          </p></td>
        <td width="10%"><p class="tituloCamp"> 
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0335' and @lang=$lang]"/>
          </p></td>
        <td width="25%"><p class="tituloCamp"> 
          <xsl:value-of disable-output-escaping="yes" select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PL-0136' and @lang=$lang]"/>
          </p></td>                               
      </tr>
      <tr><td colspan="5">&nbsp;</td></tr>
      <xsl:for-each select="LINEA/LINEA_ROW">
      <tr valign="top">
        <td>
          <xsl:value-of select="LIP_NOMBRE"/>&nbsp; 
          </td>
        <td align="right">
          <xsl:value-of select="LIP_CANTIDAD"/>&nbsp;
          </td>
        <td align="right"> 
          <xsl:value-of select="LIP_PRECIO"/>&nbsp;
          </td>
        <td align="right">
          <xsl:value-of select="NUMERO_PROVEEDORES"/>&nbsp;
          </td>
        <td align="right">
          <xsl:value-of select="PROVEEDOR_DETERMINADO"/>&nbsp;
          </td>                            
      </tr>
      </xsl:for-each>      
    </table> 
  </div>    	     
</xsl:template> 

</xsl:stylesheet>
