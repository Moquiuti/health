<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/> 
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='EMP-0150' and @lang=$lang]"/></title>
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  

     <script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	 <script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	
        <script type="text/javascript">
          <!--
          
            function ejecutarFuncionDelFrame(elFrame,parametro){
              //elFrame.CambioEmpresaActual(parametro);
              elFrame.RecargarEmpresaActual(parametro);
            }
            
            function RecargarFrames(emp_id){
              //top.mainFrame.Trabajo.zonaEmpresa.CambioEmpresaActual(emp_id);
              ejecutarFuncionDelFrame(obtenerFrame(top,'zonaEmpresa'),emp_id);
              document.location='about:blank';
            }
               function ActualizarNuevaEmpresa(emp_id){
          parent.areaTrabajo.location='about:blank';
          CambioEmpresaActual(emp_id);
        }
          //-->
        </script>
        ]]></xsl:text>	
      </head>
      <body class="gris">
      <xsl:variable name="desde_donde">
        <xsl:value-of select="MantenimientoEmpresas/DESDE"/>
      </xsl:variable>
      
      <xsl:choose>
        <xsl:when test="//SESION_CADUCADA">
          <xsl:apply-templates select="//SESION_CADUCADA"/>
        </xsl:when>
        <xsl:when test="MantenimientoEmpresas/xsql-error">
          <xsl:apply-templates select="MantenimientoEmpresas/xsql-error"/>
        </xsl:when>
        <xsl:when test="MantenimientoEmpresas/Status">
          <!--
            si el estado no es correcto aplicamos el status si no
            no lo hacemos ya que queremos redireccionar la pagina y se produce un parpadeo en la pagina
            ya que muestra el mensaje de que todo ha ido bien (texto antiguo)
          
          
          -->
          
          <xsl:if test="not(MantenimientoEmpresas/Status/OK)">
            <xsl:apply-templates select="MantenimientoEmpresas/Status"/>
          </xsl:if>
             <xsl:choose>
             <!--
                si es alta mostramos nombre empresa, login y passwd y boton aceptar
                si es actualizacion saltamos directamente a actualizar los frames 
                zonaEmpresa y este que se recarga a vacio          
             -->
             
             <xsl:when test="MantenimientoEmpresas/Status/OK">
               <xsl:choose>
                 <xsl:when test="MantenimientoEmpresas/DESDE='Manten'">
                   <meta http-equiv="Refresh">
                     <xsl:attribute name="content">0; URL=javascript:RecargarFrames(<xsl:value-of select="MantenimientoEmpresas/EMP_ID"/>);</xsl:attribute>
                   </meta>
                 </xsl:when>
                 <xsl:otherwise>
                  
                  <!--idioma-->
                    <xsl:variable name="lang">
                        <xsl:value-of select="/MantenimientoEmpresas/LANG" />
                    </xsl:variable>
                    <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
                  <!--idioma fin-->
               
                  <xsl:if test="MantenimientoEmpresas/DESDE='Alta'">
                   <h1 class="titlePage">
                   
 						<xsl:value-of select="document($doc)/translation/texts/item[@name='se_ha_realizado_correctamente_alta_empresa']/node()"/>&nbsp;
                     <xsl:value-of select="MantenimientoEmpresas/Status/EMPRESA"/></h1>
                    <div class="divLeft">
                    <p>&nbsp;</p>
                    <p style="text-align:center;"><xsl:value-of select="document($doc)/translation/texts/item[@name='se_ha_creado_el_usuario']/node()"/><strong>&nbsp;<xsl:value-of select="MantenimientoEmpresas/Status/USUARIO"/></strong>
					<!--,&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='con_la_clave']/node()"/>&nbsp;
             	    <strong><xsl:value-of select="MantenimientoEmpresas/Status/CLAVE"/></strong>.-->
                    </p> 
                    <p>&nbsp;</p>
                    <p align="center">
                        <div class="botonCenter">
                           <!-- <a href="javascript:ActualizarNuevaEmpresa('{MantenimientoEmpresas/Status/ID}');">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/>
                            </a>-->
                            
                        <xsl:call-template name="botonPersonalizado">
                         <xsl:with-param name="path" select="MantenimientoEmpresas/botonPersonalizado"/>
                         <xsl:with-param name="funcion">ActualizarNuevaEmpresa(<xsl:value-of select="MantenimientoEmpresas/Status/ID"/>)</xsl:with-param>
                         <xsl:with-param name="destino">zonaEmpresa</xsl:with-param>
                         <xsl:with-param name="label"><xsl:value-of select="document($doc)/translation/texts/item[@name='aceptar_minu']/node()"/></xsl:with-param>
                         <xsl:with-param name="Status">Aceptar</xsl:with-param>
                       </xsl:call-template>
                       </div>
                    </p>
                    </div>
                   </xsl:if>
                 </xsl:otherwise>
               </xsl:choose>
             </xsl:when>            
	     </xsl:choose>            
           </xsl:when>                     
          </xsl:choose>
           
          <!-- Para saber si hemos accedido a traves de un alta
           |     o de un mantenimiento; usamos una variable extra: DESDE.
           |    De esta forma podemos seleccionar el jumpTo adequado.
           |
           |   No tenemos en cuenta si hay error o no.
           |      "Siempre que haya un error Status volver a la pagina anterior".
           |
           +-->

      </body>
    </html>
  </xsl:template>

 
</xsl:stylesheet>
