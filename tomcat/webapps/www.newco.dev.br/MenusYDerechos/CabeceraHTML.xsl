<?xml version="1.0" encoding="iso-8859-1"?>
<!--
	Cabecera: Logo, texto, opciones y menú
	Ultima revisión: ET 27may22 12:00 Cabecera_091221.js
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:import href="http://www.newco.dev.br/General/General.xsl"/>
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<xsl:template match="/">




<html>
<head>
	<!--<xsl:call-template name="estiloIndip"/>-->
	<link rel="stylesheet" href="http://www.newco.dev.br/General/{/Cabecera/STYLE}" type="text/css"/>
	<!--fin de style-->
    <script type="text/javascript" src="http://www.newco.dev.br/MenusYDerechos/Cabecera_091221.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
	<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script><!--	Piece	-->
	<script type="text/javascript">
		var Accion='<xsl:value-of select="/Cabecera/ACCION"/>';
	</script>
</head>

<body onload="globalEvents();">
<!--idioma-->
<xsl:variable name="lang">
	<xsl:choose>
		<xsl:when test="/Cabecera/LANG"><xsl:value-of select="/Cabecera/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
<!--idioma fin-->


<xsl:choose>
    <xsl:when test="Cabecera/USUARIO/PORTAL/PMVM_ID='ClLi'">
        <div class="cabeceraBox">
		<div class="cabeceraCenter">
		<div class="cabeceraText">
		<p class="usuario">
			<span class="nombreCentro"><xsl:value-of select="substring(Cabecera/USUARIO/NOMBRECENTRO,35)"/></span>
			&nbsp;&nbsp;
    		<span class="nombreUsuario"><xsl:value-of select="Cabecera/USUARIO/NOMBREUSUARIO"/></span>
    		<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
        	<xsl:copy-of select="document($doc)/translation/texts/item[@name='gestion_pedidos']/node()"/>&nbsp;
        	<a style="text-decoration:none;">
            	<xsl:attribute name="href">mailto:<xsl:value-of select="/Cabecera/USUARIO/PORTAL/PMVM_MAIL_PEDIDOS"/></xsl:attribute>
            	<img src="http://www.newco.dev.br/images/mail.gif"/>
        	</a>
        	<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
        	<xsl:copy-of select="document($doc)/translation/texts/item[@name='nuevos_productos']/node()"/>&nbsp;
        	<a style="text-decoration:none;">
                <xsl:attribute name="href">mailto:<xsl:value-of select="/Cabecera/USUARIO/PORTAL/PMVM_MAIL_COMERCIAL"/></xsl:attribute>
                <img src="http://www.newco.dev.br/images/mail.gif"/>
        	</a>
        	<a href="javascript:CerrarSesion();" title="Cerrar sesión" style="text-decoration:none;margin-left:20%;font-weight:bold;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cerrar_sesion']/node()"/>Cerrar sesión</a>&nbsp;
        	<a href="javascript:CerrarSesion();" title="Cerrar sesión" style="text-decoration:none;"><img src="http://www.newco.dev.br/images/logout.gif"/></a>
    	</p>        
		</div><!--fin de cabeceraImage-->
    	</div><!--fin de cabeceraCenter-->

    	<div class="logoDosPage" id="logoDosPage">
    	   <div class="logout">
				<a href="javascript:CerrarSesion();" title="Cerrar sesión"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cerrar_sesion']/node()"/></a>&nbsp;
            	<a href="javascript:CerrarSesion();" title="Cerrar sesión"><img src="http://www.newco.dev.br/images/logout.gif"/></a>
        	</div>
        	<xsl:if test="/Cabecera/USUARIO/LOGOMVMENCABECERA">
            	<div class="logoDosPageInside">
                    	<img src="http://www.newco.dev.br/images/logoMVMpeq.jpg"/>
            	</div><!--fin de logo-->
        	</xsl:if>
    	</div><!--fin de logoPage-->
    	</div><!--fin de cabeceraBox-->

        <!-- NOFRAME -->
 		<div>
        <nav>
            <ul>
    		<xsl:for-each select="//MENU_DE_USUARIO/button">
            <li>
            	<a>
                	<xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="name_location"/></xsl:attribute>
                	<xsl:attribute name="target"><xsl:value-of select="target"/></xsl:attribute>
                	<xsl:value-of select="@caption"/>
            	</a>
				<xsl:if test="MENUS_HIJO">
					<ul>
    				<xsl:for-each select="MENUS_HIJO/button">
           				<li>
            			<a>
                			<xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="name_location"/></xsl:attribute>
                			<xsl:attribute name="target"><xsl:value-of select="target"/></xsl:attribute>
                			<xsl:value-of select="@caption"/>
            			</a>
            			</li>
					</xsl:for-each>
					</ul>
				</xsl:if>
            </li>
    		</xsl:for-each>
			</ul>
        </nav>
		</div>

    </xsl:when>
    <!--club vip tiendas-->
    <xsl:when test="Cabecera/USUARIO/PORTAL/PMVM_ID='CVTIENDAS'">
        <div class="cabeceraBox"> 
        <div class="logoPage" id="logoPage">
            <div class="logoPageInside">
                <a href="http://www.newco.dev.br/Gestion/Comercial/InicioStocks.xsql" target="mainFrame" title="Inicio">
                    <img>
                    	<!--<xsl:attribute name="src">http://www.newco.dev.br/Documentos/<xsl:value-of select="Cabecera/USUARIO/IDPAIS"/>/LOGO/<xsl:value-of select="Cabecera/USUARIO/LOGOTIPO"/></xsl:attribute>-->
                    	<xsl:attribute name="src"><xsl:value-of select="Cabecera/USUARIO/URLLOGOTIPO"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="Cabecera/USUARIO/NOMBRECENTRO"/></xsl:attribute>
                        <xsl:attribute name="alt">Logo de <xsl:value-of select="Cabecera/USUARIO/NOMBRECENTRO"/> en MedicalVM</xsl:attribute>
                    </img>
                </a>
            </div>
        </div>
		<div class="cabeceraCenter">
			<div class="cabeceraText">
				<p class="usuario">
					<span class="nombreCentro" style="color:#fff;"><xsl:value-of select="Cabecera/USUARIO/NOMBRECENTRO"/></span>
					&nbsp;&nbsp;
                    <span class="nombreUsuario" style="color:#fff;"><xsl:value-of select="Cabecera/USUARIO/NOMBREUSUARIO"/></span>
                    <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
                	<a href="javascript:EliminaCookies();" title="Cerrar sesión" style="text-decoration:none;margin-left:20%;font-weight:bold;color:#fff;"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cerrar_sesion']/node()"/>Cerrar sesión</a>&nbsp;
                </p>        
			</div>
            <div class="nav" style="padding-left:10%;">
                <xsl:for-each select="//MENU_DE_USUARIO/button">
                    <a>
                        <xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="name_location"/></xsl:attribute>
                        <xsl:attribute name="target"><xsl:value-of select="target"/></xsl:attribute>
                        <xsl:value-of select="@caption"/>
                    </a>
                </xsl:for-each>
                <a href="http://www.newco.dev.br/Gestion/GestionFrameset.html" target="mainFrame">
                    <xsl:value-of select="document($doc)/translation/texts/item[@name='gestion']/node()"/>
                </a>
            </div>
            </div><!--fin de cabeceraCenter-->
		</div><!--fin de cabeceraBox-->
                
	</xsl:when>
    <!-- para todos los demás	MVM, MVMB, PVM, etc-->
    <xsl:otherwise>
    <div class="cabeceraBox">
        <div class="logoPage" id="logoPage">
        	<div class="logoPageInside" align="center">
				<!--<a>-->
            	<xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="/Cabecera/button[@label='Inicio']/name_location"/></xsl:attribute>
            	<xsl:attribute name="target"><xsl:value-of select="/Cabecera/button[@label='Inicio']/target"/></xsl:attribute>
                	<img style="max-width: 287px; max-height: 50px;">
                    	<!--<xsl:attribute name="src">http://www.newco.dev.br/Documentos/<xsl:value-of select="Cabecera/USUARIO/IDPAIS"/>/LOGO/<xsl:value-of select="Cabecera/USUARIO/LOGOTIPO"/></xsl:attribute>-->
                    	<xsl:attribute name="src"><xsl:value-of select="Cabecera/USUARIO/URLLOGOTIPO"/></xsl:attribute>
                    	<xsl:attribute name="title"><xsl:value-of select="Cabecera/USUARIO/NOMBRECENTRO"/></xsl:attribute>
                    	<xsl:attribute name="alt">Logo de <xsl:value-of select="Cabecera/USUARIO/NOMBRECENTRO"/> en MedicalVM</xsl:attribute>
                	</img>
            	<!--</a>-->
        	</div><!--fin de logo-->
        </div><!--fin de logoPage-->
        
		<div class="cabeceraCenter">
                    
			<div class="cabeceraText">

                <p class="usuario">
                    <span class="nombreCentro">
			<xsl:if test="Cabecera/USUARIO/ESTRELLAS">
				<!--<img src="http://www.newco.dev.br/images/boton{Cabecera/USUARIO/ESTRELLAS}star.gif"/>&nbsp;&nbsp;-->
				<img src="http://www.newco.dev.br/images/star{Cabecera/USUARIO/ESTRELLAS}.gif"/>&nbsp;&nbsp;
				<!--<img src="http://www.newco.dev.br/images/StarSmall{Cabecera/USUARIO/ESTRELLAS}.png"/>&nbsp;&nbsp;-->
			</xsl:if>
			<strong><xsl:value-of select="substring(Cabecera/USUARIO/NOMBRECENTRO,0,35)"/></strong>:&nbsp;
			<xsl:value-of select="substring(Cabecera/USUARIO/NOMBREUSUARIO,0,25)"/>
			<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<xsl:value-of select="Cabecera/USUARIO/FECHA"/>-->
			</span>
                    <!--<span class="fecha"><xsl:value-of select="Cabecera/USUARIO/FECHA"/></span>-->
                </p>
		</div><!--fin de cabeceraImage-->                    <!--tel fax-->
    </div><!--fin de cabeceraCenter-->
   <div class="ClaveYLogout">
        <!-- PS 5jul17 -->
		<strong><xsl:value-of select="Cabecera/USUARIO/FECHA"/></strong>
		&nbsp;|&nbsp;
		<a href="http://www.newco.dev.br/Personal/CambioClave/CambioClave.xsql" target="mainFrame">
        <xsl:copy-of select="document($doc)/translation/texts/item[@name='cambio_de_clave']/node()"/></a>
		&nbsp;|&nbsp;
		<!--27may22<input type="hidden" id="URLSALIDA" value="{Cabecera/USUARIO/PORTAL/PMVM_URLSALIDA}"/>-->
		<input type="hidden" id="URLSALIDA" value="{Cabecera/USUARIO/URLSALIDA}"/>
        <a href="javascript:CerrarSesion();" title="Cerrar sesión"><xsl:value-of select="document($doc)/translation/texts/item[@name='Cerrar_sesion']/node()"/></a>&nbsp;
        </div>
        <nav>
            <ul id="MENU_INICIAL">
            <xsl:for-each select="//MENU_DE_USUARIO/button">
       		<li class="MenuInicial" id="MENU_{ID}">
			<xsl:choose>
                <xsl:when test="name_location!=''">
            		<a class="MenuInactivo">
               			<xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="name_location"/></xsl:attribute>
                		<xsl:attribute name="target"><xsl:value-of select="target"/></xsl:attribute>
						<xsl:choose>
						<xsl:when test="MARCA_VERDE">
							<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
						</xsl:when>
						<xsl:when test="MARCA_AMBAR">
							<img src="http://www.newco.dev.br/images/comeMatrizAMARILLO.gif"/>
						</xsl:when>
						<xsl:when test="MARCA_ROJA">
							<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
						</xsl:when>
						</xsl:choose>
						<xsl:value-of select="@caption"/>
           			</a>
                </xsl:when>
                <xsl:otherwise>
            		<a class="MenuInactivo">
                		<xsl:attribute name="href">javascript:SubMenu("<xsl:value-of select="ID"/>");</xsl:attribute>
						<xsl:value-of select="@caption"/>
           			</a>
                </xsl:otherwise>
			</xsl:choose>
       		</li>
			</xsl:for-each>
        	</ul>
	            <xsl:for-each select="//MENU_DE_USUARIO/button">
				<xsl:if test="MENUS_HIJO/button/ID">
            		<ul id="SUBMENU_{ID}" style="display:none">
						<li class="MenuInicial" id="SALIR_SUBMENU">
							<a href="javascript:SalirSubmenu();">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</li>
				<xsl:for-each select="MENUS_HIJO/button">
				<li class="MenuInicial" id="SUBMENU_{ID}">
            		<a class="MenuInactivo">
               			<xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="name_location"/></xsl:attribute>
                		<xsl:attribute name="target"><xsl:value-of select="target"/></xsl:attribute>
						<xsl:choose>
						<xsl:when test="MARCA_VERDE">
							<img src="http://www.newco.dev.br/images/comeMatrizVERDE.gif"/>
						</xsl:when>
						<xsl:when test="MARCA_AMBAR">
							<img src="http://www.newco.dev.br/images/comeMatrizAMARILLO.gif"/>
						</xsl:when>
						<xsl:when test="MARCA_ROJA">
							<img src="http://www.newco.dev.br/images/comeMatrizROJO.gif"/>
						</xsl:when>
						</xsl:choose>
						<xsl:value-of select="@caption"/>
           			</a>
				</li>
				</xsl:for-each>
				</ul>
			</xsl:if>
		</xsl:for-each>
        </nav>
    </div><!--fin de cabeceraBox-->
	</xsl:otherwise>
</xsl:choose>

</body>
</html>
</xsl:template>

<xsl:template name="botonDinamico">
	<xsl:param name="estilo"/>
    <xsl:param name="clase"/>
	<xsl:param name="path"/>
	<xsl:param name="parametrosAdicionales"/>
	<xsl:param name="name_function_personalizada"/>

	<xsl:variable name="msgId" select="$path/name_function_msg"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="/Cabecera/LANG"><xsl:value-of select="/Cabecera/LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

		<xsl:choose>
			<xsl:when test="$path/name_function">
				<a>
					<xsl:attribute name="href">javascript:<xsl:value-of select="$path/name_function"/>(<xsl:if test="$path/param"><xsl:for-each select="$path/param"><xsl:choose><xsl:when test="position()=last()"><xsl:value-of select="."/></xsl:when><xsl:otherwise><xsl:value-of select="."/>,</xsl:otherwise></xsl:choose></xsl:for-each></xsl:if><xsl:if test="$parametrosAdicionales!=''">,<xsl:value-of select="$parametrosAdicionales"/></xsl:if>);</xsl:attribute>
                    
					<xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="$path/@status"/>';return true;</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="$path/@caption"/>'; return true;</xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>

					<xsl:if test="$estilo!=''">
						<xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
					</xsl:if>
                    <xsl:if test="$clase!=''">
						<xsl:attribute name="class"><xsl:value-of select="$clase"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$path/@caption"/>1
				</a>
			</xsl:when>
			<xsl:when test="$path/name_function_msg">
				<a>
					<xsl:attribute name="href"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$msgId]" disable-output-escaping="yes"/></xsl:attribute>
					<xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="$path/@status"/>';return true;</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="$path/@caption"/>'; return true;</xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>

					<xsl:if test="$estilo!=''">
						<xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
					</xsl:if>
                    <xsl:if test="$clase!=''">
						<xsl:attribute name="class"><xsl:value-of select="$clase"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$path/@caption"/>2
				</a>
			</xsl:when>
			<xsl:when test="$name_function_personalizada!=''">
				<a>
					<xsl:attribute name="href">javascript:<xsl:value-of select="$name_function_personalizada"/></xsl:attribute>
					<xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="$path/@status"/>';return true;</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="$path/@caption"/>'; return true;</xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>

					<xsl:if test="$estilo!=''">
						<xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
					</xsl:if>
                    <xsl:if test="$clase!=''">
						<xsl:attribute name="class"><xsl:value-of select="$clase"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$path/@caption"/>3
				</a>
			</xsl:when>
			<xsl:when test="$path/@caption = 'IMG-1070'"> <!-- Pestaña de Inicio -->
				<a>
					<xsl:attribute name="href">http://www.newco.dev.br/<xsl:value-of select="$path/name_location"/></xsl:attribute>
					<xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="$path/@status"/>';return true;</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="$path/@caption"/>'; return true;</xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="onMouseOut">window.status=''</xsl:attribute>

					<xsl:if test="$path/target">
						<xsl:attribute name="target"><xsl:value-of select="$path/target"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="$estilo!=''">
						<xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
					</xsl:if>
                    <xsl:if test="$clase!=''">
						<xsl:attribute name="class"><xsl:value-of select="$clase"/></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<a>
					<xsl:attribute name="href">
                        <xsl:choose>
                            <xsl:when test="$path/@caption = 'Catalogos Clientes'">http://www.newco.dev.br/<xsl:value-of select="$path/name_location"/>?TYPE=MVM</xsl:when>
                            <xsl:otherwise>http://www.newco.dev.br/<xsl:value-of select="$path/name_location"/></xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>

					<xsl:if test="$path/target">
						<xsl:attribute name="target"><xsl:value-of select="$path/target"/></xsl:attribute>
					</xsl:if>
					<xsl:if test="$estilo!=''">
						<xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
					</xsl:if>
                    <xsl:if test="$clase!=''">
						<xsl:attribute name="class"><xsl:value-of select="$clase"/></xsl:attribute>
					</xsl:if>
					<!--si es catalogo privado ponemos new-->
					<!-- <xsl:choose>
						<xsl:when test="contains($path/@caption,'Privado') or contains($path/@caption,'E.I.S.')">
							<xsl:value-of select="$path/@caption"/>&nbsp;<img src="http://www.newco.dev.br/images/new.gif" alt="nuevo" valign="middle"/>
						</xsl:when>
						<xsl:otherwise>-->
                                        <xsl:value-of select="$path/@caption"/>5
						<!--  </xsl:otherwise>
					</xsl:choose>-->
				</a>
			</xsl:otherwise>
		</xsl:choose>

</xsl:template>
</xsl:stylesheet>
