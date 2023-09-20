<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  
  <xsl:template match="Botonera">
    <html>
      <head>
      	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css"/>      
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--
	
	function fica_accio(link,param2) 
	{
	 var lp_id = ]]></xsl:text><xsl:value-of select="LP_ID"/><xsl:text disable-output-escaping="yes"><![CDATA[;
	 var pl_id = ]]></xsl:text><xsl:value-of select="Botonera/PL_ID"/><xsl:text disable-output-escaping="yes"><![CDATA[;
	 //alert (param2);
	 //alert('LP:'+lp_id+'PL:'+pl_id);
	 //
	 if (param2=='Editar' || 
	     param2=='Eliminar' || 
	     param2=='Copiar') {
	 	parent.frames['zonaTrabajo'].document.location.href=link+'?PL_ID='+pl_id;
	 }
	 if (param2=='Nueva') {
	        parent.frames['zonaTrabajo'].location.href=link+"?BOTON="+param2;	 
	 }
	 if (param2=='ContenidoPlantilla') {
	       parent.frames['zonaTrabajo'].location.href=link+'?LP_ID='+lp_id+'&amp;PL_ID='+pl_id;
	 }
	 if (param2=='Cabecera') {
	       parent.frames['zonaTrabajo'].location.href=link+'?LP_ID='+lp_id+'&amp;BOTON=CABECERA';
	 }
        }
        DetectaResolucion();
        
	
	//-->
	</SCRIPT>
	]]></xsl:text>
      </head>
      <body bgcolor="#EEFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
  
       <form name="botonera">
          <input type="hidden" name="NombrePlantilla" value="{Botonera/nombrePlantilla}"/>
          <input type="hidden" name="LP_ID" value="{LP_ID}"/>
          <input type="hidden" name="PL_ID" value="{Botonera/PL_ID}"/>
       </form>      
        <table align="center" border="0" height="100%" width="100%" cellpadding="0" cellspacing="0">
       
         
       <!--<tr bgcolor="#A0D8D7"><td height="10" align="left" colspan="6"><p class="textoBuscador">NAVEGACIÓN</p></td></tr>-->
       <!-- Banners 
       <tr><td align="center" colspan="6"><img src="http://www.newco.dev.br/files/Empresas/MedicalVM/BannerMedical.gif"/></td></tr>
        -->
        <tr align="center" valign="center">
              <!--<td>
                <xsl:apply-templates select="button[@label='ListaPlantillas']"/>
                <xsl:call-template name="boton">
            <xsl:with-param name="path" select="button[@label='ListaPlantillas']"/>
          </xsl:call-template>
          &nbsp;
              </td>-->
              <td colspan="2" align="center" class="textoBuscador" valign="middle">
                <span class="textoBuscador"><xsl:value-of select="Botonera/nombrePlantilla"/></span>
              </td>
             <!-- <td>
               <xsl:call-template name="boton">
            <xsl:with-param name="path" select="button[@label='ContenidoPlantilla']"/>
          </xsl:call-template>
          &nbsp;
              </td>-->
              </tr>
              <tr>
              <td  align="center" valign="top">
                <!--<xsl:apply-templates select="button[@label='ListaPlantillas']"/>-->
                <xsl:call-template name="boton">
            <xsl:with-param name="path" select="button[@label='ListaPlantillas']"/>
          </xsl:call-template>
              </td>
             <!-- <td  align="center" class="tituloPag">
                <span class="tituloPag"><xsl:value-of select="Botonera/nombrePlantilla"/></span>
                &nbsp;
              </td>-->
              <td align="center" valign="top">
               <!-- <xsl:apply-templates select="button[@label='ContenidoPlantilla']"/>-->
                <xsl:call-template name="boton">
            <xsl:with-param name="path" select="button[@label='ContenidoPlantilla']"/>
          </xsl:call-template>
              </td>
        </tr>
      </table>
    </body>      
  </html>
 </xsl:template>
  
</xsl:stylesheet>
