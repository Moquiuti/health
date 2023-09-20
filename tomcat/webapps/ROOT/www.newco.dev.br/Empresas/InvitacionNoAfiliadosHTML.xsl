<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">

    <html>
      <head>
        <title>
          <xsl:choose>
            <xsl:when test="//OPCION[.='P']">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRV-0010' and @lang=$lang]" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="//OPCION[.='C']">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CLI-0010' and @lang=$lang]" disable-output-escaping="yes"/>
            </xsl:when>
          </xsl:choose>
        </title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	 <!--
	  function rellenarCeldas(registros, columnas){
	    
	    document.write('<td>&nbsp;</td>');   
	    registros++
	    if(registros % columnas)
	      rellenarCeldas(registros, columnas);                
	  }
	  
	//	La siguiente funcion construye el contenido del campo oculto en base a los
	//	checkboxes seleccionados por el usuario
	function AsignaValor()
	{
		var Sel=0;
		var Txt='';
    	for (j=0;j<document.forms['form1'].elements.length;j++)
		{
			if (document.forms['form1'].elements[j].checked)
			{
				if (Sel==1) Txt+='|';else Txt+='';
				Txt+=document.forms['form1'].elements[j].name; 
				Sel=1;
			}
		}
		document.forms['form2'].elements['LISTAEMPRESAS'].value=Txt;
	}
	 -->
	</script>       
        ]]></xsl:text>
      </head>
      <body bgcolor="#FFFFFF">      
        <xsl:choose>
          <xsl:when test="Generar/xsql-error">
             <xsl:apply-templates select="//xsql-error"/>          
          </xsl:when>
          <xsl:otherwise> 
	<!--	Tipo de todas las seleccionadas: 1: Proveedor, 2: Centro Sanitario, 3: Inversor	-->
	<xsl:variable name="Tipo"><xsl:value-of select="/NoAfiliados/EMPRESA/TIPO"/></xsl:variable>
  	<p class="tituloPag" align="center"><br/>
	<xsl:choose>
		<xsl:when test="$Tipo=1">
			Invitación a proveedores no afiliados
	    </xsl:when> 
		<xsl:otherwise>
			Invitación a centros sanitarios no afiliados
	    </xsl:otherwise> 
	</xsl:choose>     
	</p><br/>

      <table border="0" width="100%" cellpadding="0" cellspacing="0">
	  <!--	No presentamos ningún botón en la parte superior de la pagina
        <tr>
          <td>
            <xsl:apply-templates select="//jumpTo"/>
          </td>
        </tr>  
		-->
        <tr>
          <td>                  
	    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="muyoscuro">   
	      <tr bgColor="#a0d8d7">
	        <td colspan="3" align="center" class="tituloPag">
	          <xsl:choose>
                    <xsl:when test="//OPCION[.='P']">
                      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='PRV-0010' and @lang=$lang]" disable-output-escaping="yes"/>
                    </xsl:when>
                    <xsl:when test="//OPCION[.='C']">
                      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='CLI-0010' and @lang=$lang]" disable-output-escaping="yes"/>
                    </xsl:when>
                  </xsl:choose>
	        </td>
	      </tr>
	      <xsl:variable name="numRegistros"><xsl:value-of select="count(/NoAfiliados/EMPRESA)"/></xsl:variable>
	      <xsl:variable name="columnas">3</xsl:variable>
	      <form name="form1">
	      <tr class="claro">
	        <xsl:for-each select="/NoAfiliados/EMPRESA">  
	          <xsl:choose>
		    <xsl:when test="position() mod 2=0">        
		      <td width="33%"><!--d0f8f7-->
		        <input type="checkbox">
			  <xsl:attribute name="name"><xsl:value-of select="NIF"/></xsl:attribute>
			</input>
			<xsl:value-of select="NOMBRE"/>
	              </td>
	              <xsl:if test="position() mod $columnas=0">
	                <script>
	                  javascript:document.write('<xsl:text disable-outputescaping="yes"><![CDATA[</tr><tr class="claro">]]></xsl:text>');
	                </script>
	              </xsl:if> 
	            </xsl:when>
	            <xsl:otherwise>        
		      <td width="33%" class="claro"><!--d0f8f7-->
		        <input type="checkbox">
			  <xsl:attribute name="name"><xsl:value-of select="NIF"/></xsl:attribute>
			</input>
			<xsl:value-of select="NOMBRE"/>
	              </td>
	              <xsl:if test="position() mod $columnas=0">
	                <script>
	                  javascript:document.write('<xsl:text disable-outputescaping="yes"><![CDATA[</tr><tr class="claro">]]></xsl:text>');
	                </script>
	              </xsl:if> 
	            </xsl:otherwise>
	          </xsl:choose>
                </xsl:for-each>
                <xsl:if test="$numRegistros mod $columnas">
                  <script>
                    rellenarCeldas(<xsl:value-of select="$numRegistros"/>,<xsl:value-of select="$columnas"/>);         
                  </script>
                </xsl:if> 
              </tr>
	      </form>         	  
            </table>
          </td>
        </tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td align ="center">Mensaje a enviar a las empresas seleccionadas
		</td></tr>
		<form action="InvitacionNoAfiliadosSave.xsql" method="POST" name="form2">
		<tr><td align ="center">
			<TEXTAREA name="MENSAJE" cols="60" rows="10">
	<xsl:choose>
		<xsl:when test="$Tipo=1">
Estimado proveedor, 

nos complace comunicarle desde nuestro centro que sería un
placer poder consultar sus productos a través de MedicalVM
en http://www.newco.dev.br.

Le saluda atentamente,
	    </xsl:when> 
		<xsl:otherwise>
Muy señor mío, 

nos complace invitarle desde nuestro centro a afiliarse a la
plataforma de compras sanitarias MedicalVM en http://www.newco.dev.br.

Le saluda atentamente,
	    </xsl:otherwise> 
	</xsl:choose>&nbsp;     
			<xsl:value-of select="/NoAfiliados/USUARIO/NOMBRE"/>&nbsp;
			<xsl:value-of select="/NoAfiliados/USUARIO/NOMBREEMPRESA"/>
			</TEXTAREA>
		</td></tr>
		<tr><td>
        	<input  type="hidden" name="LISTAEMPRESAS"/>
		</td></tr>
        <tr>
          <td align="center">
            <!--<xsl:apply-templates select="//jumpTo"/>-->
        	<input  type="button" name="SUBMIT" value="Enviar" 
			onClick="javascript:AsignaValor(); SubmitForm(document.forms['form2']);" />
          </td>
        </tr> 
		</form> 
      </table>
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>  
 
</xsl:stylesheet>
