<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
	<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
	<xsl:param name="lang" select="@lang"/>  
	
	<xsl:template match="/">
		<html>
			<head>
				<title>Catálogo privado - Negociación</title>
				<xsl:text disable-output-escaping="yes"><![CDATA[
				<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
				<script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>
				<style type="text/css">
	  			textarea{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 10px; 
            margin: 2px;
            line-height: 14px;
            padding-left: 1px;
            color: #000000;
          }
    		</style>
        <style type="text/css" media="print">
	  			textarea{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 8px; 
            margin: 2px;
            line-height: 14px;
            padding-left: 1px;
            color: #000000;
          }
          
          select{ 
            font-family: verdana, arial, "ms sans serif", sans-serif; 
            font-size: 8px; 
            margin: 1px;
            line-height: 10px;
            padding-left: 1px;
          }
		 
         input{ 
           font-family: verdana, arial, "ms sans serif", sans-serif; 
           font-size: 8px; 
           margin: 1px;
           line-height: 10px;
           padding-left: 1px;
           color: #000000;
         }
        </style>
				<script type="text/javascript">
					<!--
					
          	function CerrarVentana(){ 
            	if(window.parent.opener && !window.parent.opener.closed){
              	var objFrameTop=new Object();          
              	objFrameTop=window.parent.opener.top;   
              	var FrameOpenerName=window.parent.opener.name;
              	var objFrame=new Object();
              	objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
              	if(objFrame!=null && objFrame.recargarPagina){
                	objFrame.recargarPagina('PROPAGAR');
              	}
              	else{
                	Refresh(objFrame.document);
              	}  	
            	}
            	else{
            		document.location.href='about:blank';
            	}
            	window.parent.close();
          	}
						
						function Imprimir(){
							]]></xsl:text>
							var idInforme='<xsl:value-of select="Negociacion/OK/IDINFORME"/>';
							<xsl:text disable-output-escaping="yes"><![CDATA[
							document.location.href='http://www.newco.dev.br/ProcesosCdC/Negociaciones/NegociacionCdC.xsql?IDINFORME='+idInforme+'&READ_ONLY=S'
						
						}

					//-->
				</script>
				]]></xsl:text>
			</head>
			<body class="blanco" text="#000000" link="#333366" vlink="#333366" alink="#3399ff">      
				<xsl:choose>
  				<xsl:when test="//SESION_CADUCADA">
    				<xsl:apply-templates select="//SESION_CADUCADA"/> 
  				</xsl:when>
  				<xsl:when test="//Sorry">
    				<xsl:apply-templates select="//Sorry"/> 
  				</xsl:when>
  				<xsl:otherwise>
        
        		<p class="tituloPag">
          		Oferta de Negociación
        		</p>
        		<hr/>
          	Los datos han sido guardados
        		<br/> 
        		<br/> 
						<table cellpadding="0" cellspacing="0" align="left">
							<tr>
								<td>
									<xsl:call-template name="boton">
										<xsl:with-param name="path" select="/Negociacion/botones/button[@label='Aceptar']"/>
									</xsl:call-template>
								</td>
								<td>
									&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
								<td>
									<xsl:call-template name="boton">
										<xsl:with-param name="path" select="/Negociacion/botones/button[@label='Imprimir']"/>
									</xsl:call-template>
								</td>
							</tr>
						</table>
  				</xsl:otherwise>
				</xsl:choose>
  		</body>
		</html>
	</xsl:template>  

</xsl:stylesheet>
