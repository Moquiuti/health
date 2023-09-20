<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: EMPBuscaHTML.xsl	
 | Autor.........: Olivier JEAN
 | Fecha.........: 8/8/01
 | Descripcion...: 
 | Funcionamiento: 
 |
 |Modificaciones:
 |   Fecha       Autor          Modificacion
 |
 |
 |
 | Situacion: __Normal__

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
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">	
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        <script type="text/javascript">
        <!--
        
        function Envia(formu,accion){
	  if (comprobarFormulario(formu)==0)
	    {
	    AsignarAccion(formu,accion);
	    SubmitForm(formu);
	    }
	}
	
	
        function comprobarFormulario(formu)
        {
        var obligatorios=['EMP_NOMBRE','EMP_NIF','EMP_DIRECCION','EMP_CPOSTAL','EMP_POBLACION','EMP_CPOSTAL','DEP_NOMBRE','US_NOMBRE','US_APELLIDO_1','US_EMAIL','US_TF_FIJO'];
        var numericos=['EMP_CPOSTAL','EMP_CPOSTAL','US_TF_FIJO'];
        var messError='';
        var Error = 0;
        
        for (i=0;i<formu.length;i++)
           {
           // Campos obligatorios
           if ( (obligatorios.toString()).indexOf(formu.elements[i].name) != -1 )
              {
              if (formu.elements[i].value=='') {Error = 1;
              					messError += "Por favor, rogamos rellene los campos que están marcados como obligatorios";
              					formu.elements[i].focus();
              					break;
              				       }
              }
           
           // Campos numericos
           if ( (numericos.toString()).indexOf(formu.elements[i].name) != -1 )
              {
              if (!checkNumber(formu.elements[i].value,formu.elements[i])) {Error = 1;}
              }
           }
        if (messError != '') alert(messError);
        return Error;
        
        }
        
        
        
        //-->
        </script>
        ]]></xsl:text>        
      </head>

      <body bgcolor="#EEFFFF">
        <p align="center" class="tituloPag">     
	  <br/> 	        	           
	  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0200' and @lang=$lang]" disable-output-escaping="yes"/>	        
	  <br/>
	</p>	                     
        <xsl:apply-templates select="BusquedaEmpresas/BuscForm"/> 	 
      </body>
    </html>
  </xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="BuscForm">
  <form>
    <xsl:attribute name="name">
      <xsl:value-of select="@name"/>
    </xsl:attribute>

    <xsl:attribute name="method">
      <xsl:value-of select="@method"/>
    </xsl:attribute>

  <table width="100%" border="0" cellspacing="0" cellpadding="0" >	
    
    <!-- DATOS DE EMPRESA -->
    <tr bgcolor="#A0D8D7"> 
      <td colspan="4"><p class="tituloForm">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0210' and @lang=$lang]" disable-output-escaping="yes"/>
        </p></td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>	
    <tr> 
      <td width="15%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0240' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td width="45%">  
	<input type="text" size="50" name="EMP_NOMBRE"/>
      </td>
      <td width="15%"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0230' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td width="25%">  
	<input type="text" size="9" name="EMP_NIF"/>
      </td>
      
    </tr>		    		          	          	    
   
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0220' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td colspan="3">  
	<input type="text" size="50" name="EMP_DIRECCION"/>               
      </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0260' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td> 
	<input type="text" size="5" maxlength="5" name="EMP_CPOSTAL"/>
        </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0270' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td> 
      <td>
	<input type="text" size="26" name="EMP_POBLACION"/> 	     
        </td>
    </tr>	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0250' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td>
        <!--<xsl:apply-templates select="field[@name='EMP_PROVINCIA']"/>-->
	<xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="field[@name='EMP_PROVINCIA']"/>
    	  <xsl:with-param name="IDAct"/>
    	</xsl:call-template>
      </td>
      <td>&nbsp;
      </td> 
      <td>&nbsp;
      </td>
    </tr>
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0290' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td>  
	<input type="text" size="9" name="EMP_TELEFONO"/> 	     
        </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0300' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td>  
	<input type="text" size="9" name="EMP_FAX"/>
        </td>
    </tr>
    
     <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0280' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td width="35%"><p class="tituloCamp"> 
          <!-- Indico el valor del identificador de la empresa actual -->
          <!--<xsl:variable name="IDAct"><xsl:value-of select="TE_ID"/></xsl:variable>
          <xsl:apply-templates select="field[@name='EMP_IDTIPO']"/>-->
          <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="field[@name='EMP_IDTIPO']"/>
    	  <xsl:with-param name="IDAct" select="TE_ID"/>
    	</xsl:call-template>
    	</p>
      </td>
      <td colspan="2">&nbsp;</td>
      </tr>
      
      <tr>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0285' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
   	 <!--<xsl:variable name="IDAct"/>
         <xsl:apply-templates select="field[@name='EMP_ESPECIALIDAD']"/>-->
         <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="field[@name='EMP_ESPECIALIDAD']"/>
    	  <xsl:with-param name="IDAct"/>
    	</xsl:call-template>
      </td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0295' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>  
	<input type="text" size="20" name="EMP_ZONACOMERCIAL" value="España"/>
      </td>
    </tr>
    
    <tr><td colspan="4">&nbsp;</td></tr>
    
    <tr valign="top"> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0310' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td colspan="3"> 
	<textarea name="EMP_REFERENCIAS" cols="60" rows="5"/>               
        </td>
    </tr>
  </table>
  
  <br/>
  
  <!--
  <table width="100%" border="0" cellspacing="0" cellpadding="0">

    <tr bgcolor="#A0D8D7"> 
      <td colspan="8"><p class="tituloForm">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0350' and @lang=$lang]" disable-output-escaping="yes"/>
        </p></td>
    </tr>
    <tr><td colspan="3">&nbsp;</td></tr>
    <tr bgcolor="#CCCCCC"> 
      <td align="center" width="10%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0355' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="center" width="20%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0240' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="center" width="20%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0220' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="center" width="10%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0270' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="center" width="10%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0250' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="center" width="10%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0260' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="center" width="10%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0290' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
      <td align="center" width="10%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0300' and @lang=$lang]" disable-output-escaping="yes"/></p></td>
    </tr>
    <tr><td colspan="8">&nbsp;</td></tr>
    <tr>
      <td align="center">Centro No1:</td> 
      <td align="center"><input type="text" size="20" name="CEN_NOMBRE_1"/></td>
      <td align="center"><input type="text" size="20" name="CEN_DIRRECCION_1"/></td>
      <td align="center"><input type="text" size="10" name="CEN_POBLACION_1"/></td>
      <td align="center"><input type="text" size="10" name="CEN_PROVINCIA_1"/></td>
      <td align="center"><input type="text" size="5" name="CEN_CODIGOPOSTAL_1"/></td>
      <td align="center"><input type="text" size="10" name="CEN_TELEFONO_1"/></td>
      <td align="center"><input type="text" size="10" name="CEN_FAX_1"/></td>
    </tr>
  </table>
  
  <br/>
  -->
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <!-- DEPARTAMENTOS -->
    <tr bgcolor="#A0D8D7"> 
      <td colspan="4"><p class="tituloForm">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0370' and @lang=$lang]" disable-output-escaping="yes"/>
        </p></td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>
    <tr>
      <!--<td align="center" width="15%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0375' and @lang=$lang]" disable-output-escaping="yes"/></p></td>-->
      <td width="20%"><p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0380' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span></p></td>
      <td><input type="text" size="35" name="DEP_NOMBRE"/></td>
      <td colspan="2">&nbsp;</td>
    </tr>
    
  </table>
  
  <br/>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <!-- USUARIOS -->
    <tr bgcolor="#A0D8D7"> 
      <td colspan="4"><p class="tituloForm">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0400' and @lang=$lang]" disable-output-escaping="yes"/>
        </p></td>
    </tr>
    <tr><td colspan="4">&nbsp;</td></tr>
    
    <tr>
      <td>
       <p class="tituloCamp"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0460' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span></p>
      </td>
      <td>
       <select name="US_TITULO">
                <option value="" selected="true">[elija una opcion]</option>
                <option value="DR|H">Dr.</option>
                <option value="DRA|M">Dra.</option>
                <option value="SR|H">Sr.</option>
                <option value="SRA|M">Sra.</option>
       </select>
     </td>
     <td width="20%"><p class="tituloCamp">
        <!--<span style="font-size:14pt">* </span>--><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0440' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td> 
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_NOMBRE</xsl:with-param>
        </xsl:call-template>
        </td>
    </tr>    
    	
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0230' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
      </p></td>
      <td>
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_APELLIDO_1</xsl:with-param>
        </xsl:call-template>
      </td>
      <td><p class="tituloCamp">
         <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0240' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_APELLIDO_2</xsl:with-param>
        </xsl:call-template>
      </td>
    </tr>		    		          	          	    
    
    <tr>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0290' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td>
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_EMAIL</xsl:with-param>
        </xsl:call-template>
        </td>
      <td><p class="tituloCamp">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0510' and @lang=$lang]" disable-output-escaping="yes"/>: <span class="camposObligatorios">* </span>
        </p></td>
      <td>
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_TF_FIJO</xsl:with-param>
        </xsl:call-template>
        </td>        
    </tr>
    <tr>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0520' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>
        <xsl:call-template name="GENERAL_TEXTBOX">
          <xsl:with-param name="nom">US_TF_MOVIL</xsl:with-param>
        </xsl:call-template>
        </td>     
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0530' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>
        <select name="US_OPERADOR">
                     <option value="-1">[Sel. Operador]</option>
                     <option value="1">Movistar</option>
                     <option value="2">Airtel</option>
                     <option value="3">Amena</option>
                     <option value="4">Otro</option>
         </select>
      </td>       
    </tr>

    <tr><td colspan="4">&nbsp;</td></tr>
    			
    <tr> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0260' and @lang=$lang]" disable-output-escaping="yes"/>:
        </p></td>
      <td>
        <!--<xsl:variable name="IDAct" select="US_IDTIPO"/>
        <xsl:apply-templates select="//field[@name='US_IDTIPO']"/>-->
        <xsl:call-template name="field_funcion">
    	  <xsl:with-param name="path" select="//field[@name='US_IDTIPO']"/>
    	  <xsl:with-param name="IDAct" select="US_IDTIPO"/>
    	</xsl:call-template>
      </td>
      <td><p class="tituloCamp">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0360' and @lang=$lang]" disable-output-escaping="yes"/>:</p>
      </td>
      <td>
        <input type="checkbox" checked="checked" name="US_USUARIOGERENTE"/>
      </td>
    </tr>
    
    <tr><td colspan="4">&nbsp;</td></tr>
    <tr> 
      <td><p class="tituloCamp">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0330' and @lang=$lang]" disable-output-escaping="yes"/>:
      </p></td>
      <td>
        <xsl:call-template name="GENERAL_TEXTBOX_COMPRAS">
          <xsl:with-param name="nom">US_PEDIDO_MAXIMO</xsl:with-param>
        </xsl:call-template>
        </td>
      <td><p class="tituloCamp">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0340' and @lang=$lang]" disable-output-escaping="yes"/>:
      </p></td>
      <td>
       <xsl:call-template name="GENERAL_TEXTBOX_COMPRAS">
          <xsl:with-param name="nom">US_COMPRAMENSUALMAXIMA</xsl:with-param>
        </xsl:call-template>
        </td>
    </tr>    
   <tr> 
      <td><p class="tituloCamp">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='US-0345' and @lang=$lang]" disable-output-escaping="yes"/>:
      </p></td>
      <td colspan="3">
        <xsl:call-template name="GENERAL_TEXTBOX_COMPRAS">
          <xsl:with-param name="nom">US_COMPRAANUALMAXIMA</xsl:with-param>
        </xsl:call-template>
        </td>
    </tr>    
   
  </table>
  
  <br/>
  <p><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0440' and @lang=$lang]" disable-output-escaping="yes"/>(<span class="camposObligatorios"> * </span>) 
     <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRO-0450' and @lang=$lang]" disable-output-escaping="yes"/></p>
  <br/><br/>
  
  <table border="0" width="100%" cellpadding="0" cellspacing="0">
    <tr align="center">
      <td align="center" width="50%"><xsl:apply-templates select="jumpTo"/></td>
      <td align="center" width="50%"><xsl:apply-templates select="button"/></td>      
    </tr>
  </table>   	  

  </form>
</xsl:template>

<!--+
    |
    | 	    TEMPLATES
    |
    +   -->


<xsl:template name="GENERAL_TEXTBOX">
  <xsl:param name="nom"/>
  <xsl:param name="size">25</xsl:param>
  <input type="text" name="{$nom}" size="{$size}"/>     
</xsl:template>


<xsl:template name="GENERAL_TEXTBOX_COMPRAS">
  <xsl:param name="nom"/>
  <xsl:param name="size">9</xsl:param>
  <input type="text" name="{$nom}" size="{$size}" maxlength="{$size}" onChange="this.value=toInteger(this.value)">     
  </input>
</xsl:template>

</xsl:stylesheet>