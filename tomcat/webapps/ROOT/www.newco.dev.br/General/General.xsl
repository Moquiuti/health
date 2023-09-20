<?xml version="1.0" encoding="iso-8859-1"?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
<!--
	|  Nombre: field/dropDownList
	|  Funcion: Dada una estructura tipo 'field/dropDownList' (ver ejemplo), genera una combo
	|           de nombre 'ID_combo'
	|  Parametros: Variable IDAct con el valor a mostrar por defecto en la combo
	|
	|	EJEMPLO:
	|
	|	- Codigo XSQL
	|	     <field name="ID_combo">
	|	      <xsql:query rowset-element="dropDownList" 
	|	                row-element="listElem">
	|	        <![CDATA[
	|	   	  select TE_ID AS "ID",
	|	               TE_DESCRIPCION AS "listItem"
	|	   	  from tiposempresas_vw
	|	   	  ORDER BY TE_DESCRIPCION
	|	        ]]>
	|
	|	       <xsql:no-rows-query>
	|	          Select 'No existen empresas' "Sorry" from dual
	|	       </xsql:no-rows-query>  
	|	      </xsql:query>
	|	     </field>
	|
	|       - Codigo XSL   
	|	       EJEMPLO DE UTILIZACION:
	|           1-En la cabecera del documento, despues del stylesheet poner:
	|             <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
	|           2-Donde se llamama a la dropDownList, poner:
	|              <xsl:variable name="IDAct" select="TE_ID"/>
	|	          <xsl:apply-templates select="../../field"/>
	|	          Nota: Se necesita poner el nombre de la variable ID_Actual, 
	|                    si no la queremos usar, simplemente le ponemos un valor
	|                    que no coincida con ningun identificador de la lista:
	|                    <xsl:variable name="IDAct" select="ninguno"/>
	|
	|	   	EL CODIGO QUE GENERA ES:
	|            <field name="ID_combo">
	|               <dropDownList>
	|                 <listElem num="1">
	|                   <ID>1</ID> 
	|                   <listItem>Valor del campo 1</listItem> 
	|                 </listElem>
	|                 <listElem num="2">
	|                   <ID>3</ID> 
	|                   <listItem>Valor del campo 3</listItem> 
	|                 </listElem>
	|	   	     ...
	|               </dropDownList>
	|             </field>
+-->


<xsl:template name="menuPublic">
    <xsl:param name="select" />
        
    <!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="/AreaPublica/LANG"><xsl:value-of select="/AreaPublica/LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>

	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->
        
        <div class="menuBox">
            <div class="menu">
            	<a href="http://www.newco.dev.br">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'inicio'">select</xsl:if>
                    </xsl:attribute>
                  <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/></xsl:attribute>
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>
                </a>
            	 <a href="http://www.newco.dev.br/QuienesSomos.xsql">
                     <xsl:attribute name="class">
                        <xsl:if test="$select = 'quienes_somos'">select</xsl:if>
                    </xsl:attribute>
                  <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='quienes_somos']/node()"/></xsl:attribute>
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='quienes_somos']/node()"/>
                </a>
		<a href="http://www.newco.dev.br/ClasificacionProveedores.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'proveedores'">select</xsl:if>
                    </xsl:attribute>
                <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/></xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/></a>
                <a href="http://www.newco.dev.br/MVMClientes.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'clientes'">select</xsl:if>
                    </xsl:attribute>
                <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='clientes']/node()"/></xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='clientes']/node()"/>
                 </a> 
                <a href="http://www.newco.dev.br/CatalogoPrivado.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'catalogo'">select</xsl:if>
                    </xsl:attribute>
                <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/></xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>
                </a> 	 	
                <!--<a href="http://www.newco.dev.br/Noticias.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'noticias'">select</xsl:if>
                    </xsl:attribute>
                	<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='noticias']/node()"/></xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='noticias']/node()"/>
                 </a> 	-->
                <a href="http://www.newco.dev.br/Gestion/Testimonios/Testimonios.xsql?PARAM=PARTEPUBLICA&amp;TIPO=5ALEATORIOS">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'testimonios'">select</xsl:if>
                    </xsl:attribute>
                	<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='testimonios']/node()"/></xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='testimonios']/node()"/>
                </a>
                <a href="http://www.newco.dev.br/Contacto.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'contacto'">select</xsl:if>
                    </xsl:attribute>
                	<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='contacto']/node()"/></xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='contacto']/node()"/>
                </a>
            </div><!--fin de menu-->
        </div><!--fin de menuBox-->
</xsl:template>

<xsl:template name="menuPublicBrasil">
	<xsl:param name="select" />

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="//LANG"><xsl:value-of select="//LANG"/></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<div class="menuBox">
		<div class="menu">
            	<a href="http://www.newco.dev.br.br">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'inicio'">select</xsl:if>
                    </xsl:attribute>
                  <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/> de MVM Brasil</xsl:attribute>
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='inicio']/node()"/>
                </a>
            	 <a href="http://www.newco.dev.br.br/QuienesSomos.xsql">
                     <xsl:attribute name="class">
                        <xsl:if test="$select = 'quienes_somos'">select</xsl:if>
                    </xsl:attribute>
                  <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='quienes_somos']/node()"/> de MVM Brasil</xsl:attribute>
                	 <xsl:value-of select="document($doc)/translation/texts/item[@name='quienes_somos']/node()"/>
                </a>
		<a href="http://www.newco.dev.br.br/ClasificacionProveedores.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'proveedores'">select</xsl:if>
                    </xsl:attribute>
                <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/> de MVM Brasil</xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='proveedores']/node()"/></a>
                 
                <a href="http://www.newco.dev.br.br/MVMClientes.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'clientes'">select</xsl:if>
                    </xsl:attribute>
                <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='clientes']/node()"/> de MVM Brasil</xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='clientes']/node()"/>
                 </a> 
                <a href="http://www.newco.dev.br.br/CatalogoPrivado.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'catalogo'">select</xsl:if>
                    </xsl:attribute>
                <xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/> de MVM Brasil</xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='catalogo']/node()"/>
                </a> 	 	
                <!--<a href="http://www.newco.dev.br.br/Noticias.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'noticias'">select</xsl:if>
                    </xsl:attribute>
                	<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='noticias']/node()"/> de MVM Brasil</xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='noticias']/node()"/>
                 </a> 	
                <a href="http://www.newco.dev.br.br/Testimonios.xsql">
                    <xsl:attribute name="class">
                        <xsl:if test="$select = 'testimonios'">select</xsl:if>
                    </xsl:attribute>
                	<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='testimonios']/node()"/> de MVM Brasil</xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='testimonios']/node()"/>
                </a>-->
                 <a href="http://www.newco.dev.br.br/Contacto.xsql">
                     <xsl:attribute name="class">
                        <xsl:if test="$select = 'contacto'">select</xsl:if>
                    </xsl:attribute>
                	<xsl:attribute name="title"><xsl:value-of select="document($doc)/translation/texts/item[@name='contacto']/node()"/> de MVM Brasil</xsl:attribute>
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='contacto']/node()"/>
                </a>
            </div><!--fin de menu-->
            </div><!--fin de menuBox-->
            
</xsl:template>


<xsl:variable name="default">
	<xsl:text>spanish</xsl:text>
</xsl:variable>

<xsl:template name="translate">
	<xsl:param name="text"/>
	<xsl:param name="lang"/>
	<xsl:choose>
		<xsl:when test="document('http://www.newco.dev.br/General/texts.xml')/translation/texts[lang('spanish')]/item[@name=$text]/node() != ''">
			<xsl:copy-of select="document('http://www.newco.dev.br/General/texts.xml')/translation/texts[lang('spanish')]/item[@name=$text]/node()"/>
		</xsl:when>
		<xsl:when test="document('http://www.newco.dev.br/General/texts.xml')/translation/texts[lang($default)]/item[@name=$text]/node() != ''">
			<xsl:copy-of select="document('http://www.newco.dev.br/General/texts.xml')/translation/texts[lang($default)]/item[@name=$text]/node()"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$text"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--estilo en todas las paginas-->
<xsl:template name="estiloIndip">
    <!--cogemos el estilo de database tabla  personalizacion_estilos -->
    <link rel="stylesheet" href="http://www.newco.dev.br/General/{//STYLE}" type="text/css"/>
</xsl:template>

<xsl:template match="field">
	<xsl:variable name="IDAct">$IDAct</xsl:variable>
	<xsl:apply-templates select="dropDownList"/>
</xsl:template>

<xsl:template match="dropDownList">
	<xsl:variable name="IDAct">$IDAct</xsl:variable>
	<select>
		<xsl:attribute name="name">
			<xsl:value-of select="../@name"/>
		</xsl:attribute>
		<xsl:attribute name="id">
			<xsl:value-of select="../@id"/>
		</xsl:attribute>

		<xsl:for-each select="listElem">
			<xsl:choose>
				<xsl:when test="$IDAct = ID">
					<option selected="selected">
						<xsl:attribute name="value">
							<xsl:value-of select="ID"/>
						</xsl:attribute>
						[<xsl:value-of select="listItem" disable-output-escaping="yes"/>]
					</option>
				</xsl:when>
				<xsl:otherwise>
					<option>
						<xsl:attribute name="value">
							<xsl:value-of select="ID"/>
						</xsl:attribute>
						<xsl:value-of select="listItem" disable-output-escaping="yes"/>
					</option>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</select>
</xsl:template>

<!--
	|	Formato más completo de lista desplegable.
	|	Autor: Ferran Foz.
	|
	|	<field_plus name="Chello" [current="1000"] class="classname">
	|		@current - El elemento seleccionado.
	|		@class   - el estilo 
	|	<event name="onChange" action="actualizar();"/>
	|		eventos que disparan funciones javascript.
	|		Eventos definidos:
	|			- onChange
	|	
	|	<listElem>
			<ID>1000</ID>
			<listItem>Elemento 1000</listItem>
	|	</listItem>
	|
	|	</field_plus>
+-->

<xsl:template match="field_plus">
	<xsl:element name="select">
		<xsl:if test="@name">
			<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="@id">
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="@class">
			<xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute>
		</xsl:if>

		<xsl:variable name="IDAct">
			<xsl:choose>
				<xsl:when test="@current">
					<xsl:value-of select="@current"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- Afegim els events. -->
		<xsl:for-each select="event">
			<!-- Es obligatorio posar el nom de l'atribut, per tant posem tots els noms dels events posibles -->
			<xsl:choose>
				<xsl:when test="@name[.='onChange']">
					<xsl:attribute name="onChange">
						<xsl:value-of select="@action"/>
					</xsl:attribute>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<!-- Fi. Afegim els events. -->

		<!-- Afegim els elements.
			|
			|   La opció seleccionada apareix seleccionada per defecte,
		+-->
		<xsl:for-each select="listElem">
			<xsl:choose>
				<xsl:when test="$IDAct = ID">
					<option selected="selected">
						<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
						[<xsl:value-of select="listItem"/>]
					</option>
				</xsl:when>
				<xsl:otherwise>
					<option>
						<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
						<xsl:value-of select="listItem"/>
					</option>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- Fi. Afegim els elements. -->
	</xsl:element>
</xsl:template>

<!--
	|  Listado de las divisas.
	|
	|  Parametros:
   |		  id_divisa_actual: Código de la divisa actual.
   |			Por defecto: 1 - Pesetas.
   |
   +-->  
   <!--
  <xsl:template match="lista_divisas">
    <xsl:param name="id_divisa_actual" select="1"/>
   
    <select name="Divisas" onChange="CambioDivisa(this);">
        <xsl:choose>
          <xsl:when test="$id_divisa_actual = 0">
            <option selected="selected" value="0">Euros</option>
    	    <option 			value="1">Pts</option>
          </xsl:when>
          <xsl:otherwise>
            <option  			value="0">Euros</option>
    	    <option selected="selected" value="1">Pts</option>
          </xsl:otherwise>
        </xsl:choose>
    </select>
      
  </xsl:template>
  -->
  
  <!-- 
   |    Construimos un botón con un grafico y un texto asociado. 
   |	Asociamos una URL a la acción de pulsar.
   |
   |   <jumpTo>
   |      <picture-off> : Identificador DB-xxx del grafico inicial (OnMouseOut) 
   |      <picture-on>  : Identificador DB-xxx del grafico activo (OnMouseOver)
   |      <page>        : Identificador del link destino en el <A HREF>
   |      <caption>     : Identificador del texto de mensaje a mostrar
   |	  <alt>	        : Identificador del texto alternativo. Si no existe en su lugar   
   |			  se muestra el caption.
   |      <status>      : Identificador del texto que queremos que aparezca en el statusbar.
   |			  Si no existe en su lugar se muestra el caption.   
   |   </jumpTo>
   |
   +-->
  <xsl:template match="jumpTo | JUMPTO_OK | JUMPTO_DATAERROR | JUMPTO_DBERROR | JUMPTO_XSQLERROR">
    <xsl:variable name="code-img-on">DB-<xsl:value-of select="picture-on"/></xsl:variable>
    <xsl:variable name="code-img-off">DB-<xsl:value-of select="picture-off"/></xsl:variable> 
    <xsl:variable name="code-link"><xsl:value-of select="page"/></xsl:variable>   
    <xsl:variable name="code-text"><xsl:value-of select="text"/></xsl:variable>  
    <xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
    <xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>    
    <xsl:variable name="link"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-link]" disable-output-escaping="yes"/></xsl:variable>    
    <xsl:variable name="texto"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-text]" disable-output-escaping="yes"/></xsl:variable>    
    <xsl:variable name="code-status"><xsl:value-of select="status"/></xsl:variable>
    <xsl:variable name="status">
      <xsl:choose>
        <xsl:when test="status">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="code-alt"><xsl:value-of select="alt"/></xsl:variable>
    <xsl:variable name="alt">
      <xsl:choose>
        <xsl:when test="alt">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="picture-off">  
	  <a>
	    <xsl:attribute name="href"><xsl:value-of select="$link"/></xsl:attribute>
         
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
      </a>        
      </xsl:when> 
      <!-- Link sin imagen -->
      <xsl:otherwise>
        <a class="btnDestacado">
          <xsl:attribute name="href"><xsl:value-of select="$link"/></xsl:attribute>   
          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>   
          <xsl:value-of select="name"/>
        </a>        
    </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 
   |   Construimos un botón con un grafico y un texto. La pulsación de este botón genera una
   |		llamada a una función Javascript con una llamada que se ha construido de forma 
   |		dinamica.
   |
   |   <button>
   |      @label         : Nombre del grafico. Identifica el grafico activo/inactivo. DB-xxx / DB-xxx_mov.
   |      @caption       : Codigo del texto a mostrar debajo del grafico.
   |      @alt           : Identificador del texto que queremos que aparezca en alt.
   |                        Si no se especifica se coge el caption.
   |      @status        : Identificador del texto que queremos que aparezca en el statusbar. 
   |                        Si no se especifica se coge el caption.

   |      <name_function> : Nombre de la funcion asociada.
   |      <param>*        : Diferentes parametros de la funcion asociada. Se copian literales al principio de la llamada.
   |      <param_msg>*    : Parametros de la función. Se buscan en el fichero de mensajes y se copian al final de la llamada.
   |   </button>
   |
   +-->
  <xsl:template match="button">
    
    <!-- Status Line -->
    <xsl:variable name="code-status"><xsl:value-of select="@status"/></xsl:variable>
    <xsl:variable name="status">
      <xsl:choose>
        <xsl:when test="@status">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <!-- Texto alternativo -->
    <xsl:variable name="code-alt"><xsl:value-of select="@alt"/></xsl:variable>
    <xsl:variable name="alt">
      <xsl:choose>
        <xsl:when test="@alt">
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
	  <a>
	      <!--
	       |   Construimos la llamada a la función por este orden:
	       |    1.- Copiamos los parametros <param>, de forma literal.
	       |    2.- Copiamos los parametros <param_msg>, previa consulta en el fichero de mensajes.
	       +-->
	       
	      <xsl:attribute name="href">javascript:<xsl:value-of select="name_function"/>(<xsl:for-each select="param">
	          <xsl:choose>
	            <xsl:when test="not(position()=last()) or ../param_msg"><xsl:value-of select="."/>,</xsl:when>
	            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
	          </xsl:choose>
	          </xsl:for-each>
	          <xsl:for-each select="param_msg">
	          <xsl:choose>
	            <xsl:when test="not(position()=last())">'<xsl:value-of select="."/>',</xsl:when>
	            <xsl:otherwise><xsl:variable name="msg"><xsl:value-of select="."/></xsl:variable>'<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$msg and @lang='spanish']" disable-output-escaping="yes"/>'</xsl:otherwise>
	          </xsl:choose>	          
	        </xsl:for-each>);</xsl:attribute>	  
          
          <!-- Texto debajo del boton -->
          <xsl:if test="@caption">
            <xsl:variable name="caption"><xsl:value-of select="@caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
          </xsl:if>
          </a>
  </xsl:template>

   <!-- 
   |  
   |   <ADELANTE PAG=""/>
   |   Para avanzar pagina dentro de un documento xsl
   |   Creamos el boton adelante asociado a la funcion Navega
   |   Suponemos que solamente hay un formulario en la pag, lo llamamos con forms[0]
   +-->  
  <xsl:template match="ADELANTE">
    <a>   
      <xsl:attribute name="href">javascript:Navega(document.forms[0],'<xsl:value-of select="@PAG"/>');</xsl:attribute>
      <xsl:attribute name="onMouseOver">cambiaImagen('Siguiente','http://www.newco.dev.br/images/Botones/Siguiente_mov.gif');window.status='Avanzar pagina';return true</xsl:attribute>
      <xsl:attribute name="onMouseOut">cambiaImagen('Siguiente','http://www.newco.dev.br/images/Botones/Siguiente.gif');window.status='';return true</xsl:attribute>
      <img name="Siguiente" alt="Siguiente pagina" border="0" src="http://www.newco.dev.br/images/Botones/Siguiente.gif"/>
    </a>
    <br/><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0040']" disable-output-escaping="yes"/>	  
  </xsl:template>
  
 <!-- 
   |  
   |   <ATRAS PAG=""/>
   |   Para retroceder pagina dentro de un documento xsl
   |   Creamos el boton retroceder asociado a la funcion Navega
   |   Suponemos que solamente hay un formulario en la pag, lo llamamos con forms[0]
   +-->  
  <xsl:template match="ATRAS">
    <a>
      <xsl:attribute name="href">javascript:Navega(document.forms[0],'<xsl:value-of select="@PAG"/>');</xsl:attribute>    
      <xsl:attribute name="onMouseOver">cambiaImagen('Anterior','http://www.newco.dev.br/images/Botones/Anterior_mov.gif');window.status='Retroceder pagina';return true</xsl:attribute>
      <xsl:attribute name="onMouseOut">cambiaImagen('Anterior','http://www.newco.dev.br/images/Botones/Anterior.gif');window.status='';return true</xsl:attribute>
      <img name="Anterior" alt="Pagina anterior" border="0" src="http://www.newco.dev.br/images/Botones/Anterior.gif"/>
    </a>
    <br/><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-0050']" disable-output-escaping="yes"/>    
  </xsl:template>  
    
<!--
 |	Una llamada a un procedimiento Oracle puede generar un error mediante la estructura 'Status'.
 |
 |	<Status>
 |		<OK MSGT="OK-0100" MSGB="OK-1000"/>	: All right!
 |		<DBERROR/>				: Error en la base de datos
 |		<DATAERROR FIELD='' MSG='G-0000'>	: Error en algun campo 
 |	</Status>
 |
 |	Ferran Foz - nextret.net - 10/1/2001
 |		Afegim 2 parametres per a personalitzar els missatges <OK>
 |		MSGT = 'OK-0100' - Missatge del TITOL
 |		MSGB = 'OK-1000' - Missatge del BODY
 |
 |	Montse Pans
 |		Se puede aplicar un jumpto especifico que este en un xsl llamandolo:
 |		<JUMPTO_DATAERROR>, <JUMPTO_OK>, <JUMPTO_DBERROR> SEGUN EL CASO JUMPTO
 |
+-->
<xsl:template match="Status">
	<xsl:param name="botonImprimir"/>

	<!--idioma-->
	<xsl:variable name="lang">
		<xsl:choose>
		<xsl:when test="//LANG != ''"><xsl:value-of select="//LANG"/></xsl:when>
		<xsl:otherwise>spanish</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
	<!--idioma fin-->

	<xsl:choose>
    
    <!--Error en el dato -->
	<xsl:when test="./DATAERROR">
		<div class="tituloCamp" style="height:100%;">
			<div class="tituloLeft">
			<xsl:choose>
			<xsl:when test="./DATAERROR/@MSG">
				
                <xsl:choose> 
                	<!--si viene de otro portal con frame enseño text portal mc 16-6-15-->
                	<xsl:when test="/Main/PORTAL != ''">
                    	<p><xsl:value-of select="document($doc)/translation/texts/item[@name='login_contrasena_no_correctos']/node()"/></p>

                    	<p><xsl:value-of select="document($doc)/translation/texts/item[@name='si_cree_que_error_sistema']/node()"/>&nbsp;<xsl:value-of select="/Main/PORTAL" /></p>

                    	<div class="boton">
                            <a href="javascript:parent.window.close();">
                                    <xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
                            </a>
                    	</div>
                	</xsl:when>

                	<xsl:otherwise><!--normal mvm y mvmbr-->

                    	<p><xsl:value-of select="document($doc)/translation/texts/item[@name='login_contrasena_no_correctos']/node()"/></p>
                    	<!--<p><xsl:value-of select="$doc"/></p>-->
                    	<p><xsl:copy-of select="document($doc)/translation/texts/item[@name='login_contrasena_no_correctos_2']/node()"/></p>

                    	<p><xsl:value-of select="document($doc)/translation/texts/item[@name='si_cree_que_error_sistema_mvm']/node()"/></p>

                	<!--para todos los portales meno proveedores.com permitimos recuperar la contraseña mc 16-6-15 <xsl:if test="/Main/PORTAL != 'Proveedores.com'">-->

                    	<p>&nbsp;</p>
                    	<p id="emailError" class="rojoScuro" style="display:none;"></p>
                    	<p>
                            	<label><xsl:value-of select="document($doc)/translation/texts/item[@name='email_usuario']/node()"/>:</label>
                            	&nbsp;<input type="text" name="email" id="email"/>
                    	</p>
                    	<div class="boton">
                            	<a href="javascript:CheckFormEmail();">
                                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='recuperar_pwd']/node()"/>
                            	</a>
                    	</div>

					</xsl:otherwise>
            	</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<p>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='login_contrasena_no_correctos']/node()"/>&nbsp;"
					<xsl:value-of select="@FIELD"/>"&nbsp;
					<xsl:value-of select="document($doc)/translation/texts/item[@name='login_contrasena_no_correctos_2']/node()"/>
				</p>
			</xsl:otherwise>
			</xsl:choose>
			</div><!--fin de tituloLeft-->
                        
            <xsl:if test="/Main/PORTAL = ''">
				<div class="tituloRight">
					<p>
						<a href="http://www.newco.dev.br/index.xsql">
							<!--<img src="http://www.newco.dev.br/images/logo-pagGr.gif"/>-->
							<img src="http://www.newco.dev.br/images/login2017/medical-vm-logo.png"/>
						</a>
					</p>
				</div>
            </xsl:if>
		</div><!--fin de tituloCamp-->

	</xsl:when>

	<!-- No hay error pedido ok --> 
	<xsl:when test="./OK">
		<form name="OK" method="POST">
			<!-- Buscamos los mensajes -->
			<xsl:variable name="vMSGT">
				<xsl:choose>
				<xsl:when test="./OK/@MSGT"><xsl:value-of select="./OK/@MSGT"/></xsl:when>
				<xsl:otherwise>OK-0100</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="vMSGB">
				<xsl:choose>
				<xsl:when test="./OK/@MSGB"><xsl:value-of select="./OK/@MSGB"/></xsl:when>
				<xsl:otherwise>OK-1000</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<div class="ZonaTituloPagina">
				<p class="TituloPagina">
        			<xsl:value-of select="document($doc)/translation/texts/item[@name=$vMSGT]/node()"/>
				</p>
    	   </div>
		   <br/>

			<!--<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name=$vMSGT]/node()"/></h1>-->
			<br /><br />
                        <xsl:choose>
                            <xsl:when test="$vMSGB = 'OK-1132'">
                                <div class="divLeft35">&nbsp;</div>
                                <p class="exito"><strong>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name=$vMSGB]/node()"/></strong></p>
                                
                            </xsl:when>
                            <xsl:otherwise>
                                <div class="divLeft35">&nbsp;</div>
                                <p style="font-size:14px;"><strong>&nbsp;&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name=$vMSGB]/node()"/></strong></p>
                            </xsl:otherwise>
                        </xsl:choose>
                        <br />
                        <br />
                    <p style="float:left;width:100%;text-align:center;margin:20px 0;">
			<xsl:choose>
			<xsl:when test="//JUMPTO_OK"><xsl:apply-templates select="//JUMPTO_OK"/></xsl:when>
			<xsl:when test="//boton[@label='Cerrar']">
				<img src="http://www.newco.dev.br/images/cerrar.gif" alt="cerrar"/>&nbsp;
				<a class="btnDestacado">
					<xsl:attribute name="href">
						<xsl:choose>
						<xsl:when test="//boton/name_location != ''"><xsl:value-of select="//boton/name_location"/></xsl:when>
						<xsl:otherwise>javascript:CerrarVentana();</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
				</a>
			</xsl:when>
			</xsl:choose>
				<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			<!--imprimir-->
			<xsl:if test="$botonImprimir='IMPRIMIR'">
				<img src="http://www.newco.dev.br/images/imprimir.gif" alt="imprimir"/>&nbsp;
				<a class="btnDestacado">
					<xsl:attribute name="href">javascript:MostrarPag('http://www.newco.dev.br/Compras/Multioferta/MultiofertaFrame.xsql?MO_ID=<xsl:value-of select="//MO_ID"/>','MultiofertaImprimir');</xsl:attribute>imprimir
				</a>
			</xsl:if>
				<xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			</p>
		</form>
	</xsl:when>
<!--
 |	Error de base de datos
 |
+-->
	<xsl:when test="./DBERROR">
		<form name="DBERROR" action="http://www.newco.dev.br/General/GError.xsql" method="POST">
			<div class="divLeft gris">
				<h1 class="titlePage"><xsl:value-of select="document($doc)/translation/texts/item[@name='mvm_actualizacion']/node()"/></h1>
				<br /><br />
				<p style="margin-left:70px;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='mvm_actualizacion_text']/node()"/></p>
				<br /><br />

				<input type="hidden" name="ERR_JUMPTO"><xsl:attribute name="value"><xsl:value-of select="../ERR_JUMPTO"/></xsl:attribute></input>
				<br/><br/><br/><br/>
				<table class="infoTable" border="0">
					<tr>
						<td colspan="3" align="center">
							<textarea name="ERR_DATO3" cols="50" rows="5">
								<xsl:value-of select="document($doc)/translation/texts/item[@name='introduzca_info_addicional']/node()"/>
							</textarea>
						</td>
					</tr>
					<tr>
						<td width="10%" align="center">
						<xsl:choose>
						<xsl:when test="//JUMPTO_DBERROR"><xsl:apply-templates select="//JUMPTO_DBERROR"/></xsl:when>
						<xsl:otherwise>
							<xsl:variable name="code-img-on">DB-Anterior_mov</xsl:variable>
							<xsl:variable name="code-img-off">DB-Anterior</xsl:variable> 
							<xsl:variable name="code-link">
								<xsl:choose>
								<xsl:when test="//JUMPTO_LINK"><xsl:value-of select="//JUMPTO_LINK"/></xsl:when>
								<xsl:otherwise>G-0010</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:variable name="draw-on"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-on]" disable-output-escaping="yes"/></xsl:variable>
							<xsl:variable name="draw-off"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-img-off]" disable-output-escaping="yes"/></xsl:variable>
							<xsl:variable name="link"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-link]" disable-output-escaping="yes"/></xsl:variable>
							<xsl:variable name="code-status"><xsl:value-of select="status"/></xsl:variable>
							<xsl:variable name="status">
								<xsl:choose>
								<xsl:when test="status">
									<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
								</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:variable name="code-alt"><xsl:value-of select="alt"/></xsl:variable>
							<xsl:variable name="alt">
								<xsl:choose>
								<xsl:when test="alt">
									<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-alt]" disable-output-escaping="yes"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
								</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<a>
								<xsl:attribute name="href"><xsl:value-of select="$link"/></xsl:attribute>
								<xsl:attribute name="onMouseOver">cambiaImagen('Anterior','<xsl:value-of select="$draw-on"/>');window.status='<xsl:value-of select="$status"/>';return true</xsl:attribute>
								<xsl:attribute name="onMouseOut">cambiaImagen('Anterior','<xsl:value-of select="$draw-off"/>');window.status='';return true</xsl:attribute>
								<img name="Anterior" alt="{$alt}" src="{$draw-off}" border="0"/>
							</a>
							<br/>
							<xsl:variable name="caption">G-0001</xsl:variable>
							<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
						</xsl:otherwise>
						</xsl:choose>
						</td>
						<td width="80%">&nbsp;</td>
						<td width="10%" align="right">
							<a>
								<xsl:attribute name="href">javascript:SubmitForm(document.forms['DBERROR']);</xsl:attribute>
								<xsl:attribute name="onMouseOver">cambiaImagen('Enviar','http://www.newco.dev.br/images/Botones/Enviar_mov.gif');window.status='Enviar';return true</xsl:attribute>
								<xsl:attribute name="onMouseOut">cambiaImagen('Enviar','http://www.newco.dev.br/images/Botones/Enviar.gif');window.status='';return true</xsl:attribute>
								<img name="Enviar" alt="Enviar" border="0" src="http://www.newco.dev.br/images/Botones/Enviar.gif"/>
							</a>
							<br/>
							<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='IMG-0100']" disable-output-escaping="yes"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</xsl:when>
	</xsl:choose>
</xsl:template>
    
  <!--
   |   En caso de xsql-error mostramos al usuario un formulario con los datos del error
   |    y permitimos introducir un comentario.
   |   Estos datos los procesa GError.xsql que los almacena en la base de datos.
   |
   |   Parametros:
   |       ../pagename : Contiene el nombre de la pagina que ha producido el error.
   |  
   |  Se puede aplicar un jumpto especifico que este en un xsl llamandolo:
   |    <JUMPTO_XSQLERROR>
   
   |  ???? JUMPTO-xsql_error, JUMPTO ????   
   +-->
  <xsl:template match="xsql-error">
    <!-- No lo podemos dentro del xsql-error porque pueden haber caracteres que nos
        impidan enviar el formulario: p.ej: '
      -->
    <xsl:comment>
      On action: <xsl:value-of select="@action"/>
      Message:<xsl:value-of select="./message"/>
      Statement:<xsl:value-of select="./statement"/>
    </xsl:comment>
    
     <!--idioma-->
         <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="//LANG"><xsl:value-of select="//LANG" /></xsl:when>
            <xsl:otherwise>spanish</xsl:otherwise>
            </xsl:choose>  
        </xsl:variable>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>       <!--idioma fin-->
		 <!--style--> 
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->

    <form name="xsql-error" action="http://www.newco.dev.br/General/GError.xsql" method="POST">    
    <div class="divLeft gris">
      <h1 class="titlePage">
      	<xsl:value-of select="document($doc)/translation/texts/item[@name='mvm_actualizacion']/node()"/>
      </h1>
     
      <br /><br />
      <p style="margin-left:70px;"><xsl:copy-of select="document($doc)/translation/texts/item[@name='mvm_actualizacion_text']/node()"/></p>
      <br /><br />
      
      <table class="infoTable" border="0">
        <!-- Preparamos los campos del formulario por si quiere enviar el error al servicio tecnico -->
       <!-- Comentarios -->
     	<tr><td colspan="5">
             <textarea name="ERR_DATO3" cols="70" rows="5"><xsl:value-of select="document($doc)/translation/texts/item[@name='introduzca_info_addicional']/node()"/></textarea></td>
	 	 </tr>
    	  <!--JumpTo-->
      	 <tr>
         	<td class="trenta">&nbsp;</td>
      	    <td class="veinte">
    	     <xsl:choose>
    	       <xsl:when test="//JUMPTO_XSQLERROR">
    	         <xsl:apply-templates select="//JUMPTO_XSQLERROR"/>
    	       </xsl:when>
    	       <xsl:otherwise>     	
                   <xsl:variable name="code-link">
                    <xsl:choose>
                     <xsl:when test="//JUMPTO_LINK"><xsl:value-of select="//JUMPTO_LINK"/></xsl:when>
                     <xsl:otherwise><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/></xsl:otherwise>
                    </xsl:choose>
                   </xsl:variable>
    	         <xsl:variable name="link"><xsl:value-of select="document($doc)/translation/texts/item[@name='continuar']/node()"/>
    	     	</xsl:variable>
             <br /><br />
            <div class="boton">
	            <a href="javascript:history.go(-1);">
                 <xsl:value-of select="document($doc)/translation/texts/item[@name='volver']/node()"/>
		    	</a>
            </div><!--fin de boton-->
                 <br/>
               </xsl:otherwise>
               </xsl:choose>
            </td>
            <td class="dies">&nbsp;</td>
			<!--boton enviar-->
			<td class="quince">
             <br /><br />
                <div class="boton">
	        	 <a>
                   <xsl:attribute name="href">javascript:SubmitForm(document.forms['xsql-error']);</xsl:attribute>	        
	           		<xsl:value-of select="document($doc)/translation/texts/item[@name='enviar']/node()"/>
	         	</a>
             </div><!--fin de boton-->
	            
	        </td>   
            <td>&nbsp;</td>              
         </tr>
       </table>
		 <br /><br />
         
       <p style="color:#EEFFFF">
       <input type="hidden" name="ERR_FICHERO"> 
        <xsl:attribute name="value"><xsl:value-of select="../pagename"/></xsl:attribute>    
       </input>
       <!--Salta a ERR_JUMPTO. -->
       <input type="hidden" name="ERR_JUMPTO"> 
        <xsl:attribute name="value"><xsl:value-of select="../ERR_JUMPTO"/></xsl:attribute>    
       </input>
        <!-- 
          <input type="hidden" name="ERR_TABLA">
            <xsl:attribute name="value">SUGERENCIAS</xsl:attribute>
          </input> 
        -->
       <!--
       <input type="hidden" name="ERR_DATO1">
        <xsl:attribute name="value"><xsl:value-of select="./statement"/></xsl:attribute>    
       </input>
       -->
       
       <input type="hidden" name="ERR_DATO2">
        <xsl:attribute name="value"><xsl:value-of select="./message"/></xsl:attribute>    
       </input>    </p>  
       </div><!--fin de divLeft-->         
               </form>
  </xsl:template>      
          

  <!--  NoDataFound - Mostramos un cuadro de texto que permite recoger comentarios cuando no se encuentra un elemento -->
  <xsl:template match="NoDataFound">
  <div class="divLeft">
  
    <div class="tituloPag">
     <div class="tituloLeft">
      <xsl:choose>
        <xsl:when test="MSG_TITOL">
          <xsl:variable name="MSG_TITOL"><xsl:value-of select="MSG_TITOL"/></xsl:variable>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$MSG_TITOL and @lang='spanish']" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1050' and @lang='spanish']" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
     </div>  
    </div>
    
    <div class="tituloForm">
    <br />
    <br />
    <p>
      <xsl:choose>
        <xsl:when test="MSG_BODY">
          <xsl:variable name="MSG_BODY"><xsl:value-of select="MSG_BODY"/></xsl:variable>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$MSG_BODY and @lang='spanish']" disable-output-escaping="yes"/>
        </xsl:when>
        <xsl:otherwise>
          
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1070' and @lang='spanish']" disable-output-escaping="yes"/>
          
        </xsl:otherwise>
      </xsl:choose>
      </p>
     
      
    <xsl:if test="MSG_EXTRA"><xsl:variable name="MSG_EXTRA">
      <xsl:value-of select="MSG_EXTRA"/></xsl:variable>
    <!-- tituloCamp por tituloForm-->
    
    <p>
    <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$MSG_EXTRA and @lang='spanish']" disable-output-escaping="yes"/></p></xsl:if>
 
    <form name="NoDataFound" action="http://www.newco.dev.br/General/GError.xsql" method="POST">    
            <!-- Copiamos los parametros de busqueda -->
            <textarea name="ERR_DATO3" cols="70" rows="8">Busqueda de productos.
<xsl:text></xsl:text>            
<xsl:if test="../../../LLP_NOMBRE">Nombre: <xsl:value-of select="../../../LLP_NOMBRE"/></xsl:if>
<xsl:text></xsl:text>    
<xsl:if test="../../../LLP_PROVEEDOR">Proveedor/Fabricante/Marca: <xsl:value-of select="../../../LLP_PROVEEDOR"/></xsl:if>
<xsl:text></xsl:text>    
Otros Productos:	
            </textarea>
            <script>document.forms['NoDataFound'].elements['ERR_DATO3'].focus();
            </script>
         
         <div class="divLeft gris">
    	  <!-- Copia de JumpTo-->
    	     <xsl:choose>
    	       <xsl:when test="//JUMPTO_NODATAFOUND">
    	           <xsl:apply-templates select="//JUMPTO_NODATAFOUND"/>
    	       </xsl:when>
               
    	       <xsl:otherwise>    	
                 <xsl:variable name="code-link">
                   <xsl:choose>
                     <xsl:when test="//JUMPTO_LINK"><xsl:value-of select="//JUMPTO_LINK"/>tttttt</xsl:when>
                     <xsl:otherwise>G-0010</xsl:otherwise>
                   </xsl:choose>
                 </xsl:variable>
    	         <xsl:variable name="link"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-link]" disable-output-escaping="yes"/></xsl:variable>    
                 
    	    <xsl:variable name="code-status"><xsl:value-of select="status"/></xsl:variable>
            
		    <xsl:variable name="status">
		      <xsl:choose>
		        <xsl:when test="status">
		          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$code-status]" disable-output-escaping="yes"/>
		        </xsl:when>
                
		        <xsl:otherwise>
		          <xsl:variable name="caption"><xsl:value-of select="caption"/></xsl:variable>
                  <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
		        </xsl:otherwise>
		      </xsl:choose>
		      </xsl:variable>
		   
             <!--enviar form-->
            	<div class="boton botonLeft">
	    		<a>
                <xsl:attribute name="href">javascript:SubmitForm(document.forms['NoDataFound']);</xsl:attribute>	        
	      		<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='IMG-0100']" disable-output-escaping="yes"/>
          		</a>
	 			</div><!--fin de boton-->
                
              <!--volver form-->
                <div class="boton botonRight">
	            <a>
	             <xsl:attribute name="href"><xsl:value-of select="$link"/></xsl:attribute>
                 <xsl:variable name="caption">G-0001</xsl:variable>
                 <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$caption]" disable-output-escaping="yes"/>
                </a>
                </div>
               </xsl:otherwise>
             </xsl:choose>
                <br />
                <br />
           </div><!--fin de divleft-->
       </form>
     </div><!--fin de tituloForm-->
   </div><!--fin de div divLeft70-->
  </xsl:template>
  

  <xsl:template match="Sorry">
    <p class="tituloPag">
      <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1050' and @lang='spanish']" disable-output-escaping="yes"/>
      <hr/></p>
    <p class="tituloForm">            
       <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='G-1070' and @lang='spanish']" disable-output-escaping="yes"/>
    </p>
             
  </xsl:template>  
  

<!--	template para desplegable, multiples parametros de ajuste: clase, onchange, 		-->  
<xsl:template name="desplegable">
	
    <xsl:param name="path"/>
    <xsl:param name="onChange"/>
    <xsl:param name="defecto"/>
    <xsl:param name="deshabilitado"/>
    <xsl:param name="nombre"/>
    <xsl:param name="id"/>
    <xsl:param name="sincontenido"/>
    <xsl:param name="claSel"/>
    <xsl:param name="style"/>
    <xsl:param name="required"/>
    
    
    
    <xsl:variable name="activa">
      <xsl:choose>
        <xsl:when test="$defecto!=''">
          <xsl:value-of select="$defecto"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$path/@current"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <select>
		<xsl:if test="$claSel != ''">
			<xsl:attribute name="class"><xsl:value-of select="$claSel" /></xsl:attribute>
		</xsl:if>
		<xsl:choose>
		<xsl:when test="$nombre!=''">
			<xsl:attribute name="name"><xsl:value-of select="$nombre"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="name"><xsl:value-of select="$path/@name"/></xsl:attribute>
		</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
		<xsl:when test="$id!=''">
			<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
		</xsl:when>
		<xsl:when test="$path/@id != ''">
			<xsl:attribute name="id"><xsl:value-of select="$path/@id"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="id"><xsl:value-of select="$path/@name"/></xsl:attribute>
		</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
		<xsl:when test="$onChange!=''">
			<xsl:attribute name="onChange"><xsl:value-of select="$onChange"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="onChange"><xsl:value-of select="$path/@onChange"/></xsl:attribute>
		</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="$deshabilitado!=''">
			<xsl:attribute name="disabled"><xsl:value-of select="$deshabilitado"/></xsl:attribute>
		</xsl:if>

		<xsl:if test="$style!=''">
			<xsl:attribute name="style"><xsl:value-of select="$style"/></xsl:attribute>
		</xsl:if>
		
		<xsl:if test="$required != ''">
			<xsl:attribute name="required"><xsl:value-of select="$required" /></xsl:attribute>
		</xsl:if>
     
    	<xsl:if test="$sincontenido!='SINCONTENIDO'">
			<xsl:for-each select="$path/dropDownList/listElem">
				<xsl:if test="listItem != ''">
				<xsl:choose>
				<xsl:when test="$activa=''">
					<xsl:choose>
    				 <!--  seleccionamos el primer elemento   -->
				  	<xsl:when test="position()=1">
    					<option>
            				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
            				<xsl:attribute name="selected">yes</xsl:attribute>
            				<xsl:value-of select="listItem"/>
    					</option>
				 	 </xsl:when>
				  	<xsl:otherwise>
    					<option>
            				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
            				<xsl:value-of select="listItem"/>
    					</option>
					</xsl:otherwise>
				</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
    				<!--  seleccionamos el que nos pasan por parametro-->
					<xsl:choose>
				  	<xsl:when test="$activa=ID">
    					<option>
            				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
            				<xsl:attribute name="selected">yes</xsl:attribute>
            				<xsl:value-of select="listItem"/>
    					</option>
					</xsl:when>
					<xsl:otherwise>
    					<option>
            				<xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
            				<xsl:value-of select="listItem"/>
    					</option>
					</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
				</xsl:if>
			</xsl:for-each>
    	</xsl:if>
	</select>

</xsl:template>

<xsl:template name="botonMenu">
 
  <xsl:param name="path"/>
  <xsl:param name="estilo"/>
  <xsl:param name="parametrosAdicionales"/>
  <xsl:param name="name_function_personalizada"/>
 
  <xsl:variable name="msgId" select="$path/name_function_msg"/> 
  
     
       <div class="botonMenu">
      <xsl:choose>
      <xsl:when test="$path/name_function">
     
   
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href">javascript:<xsl:value-of select="$path/name_function"/>(<xsl:if test="$path/param"><xsl:for-each select="$path/param"><xsl:choose><xsl:when test="position()=last()"><xsl:value-of select="."/></xsl:when><xsl:otherwise><xsl:value-of select="."/>,</xsl:otherwise></xsl:choose></xsl:for-each></xsl:if><xsl:if test="$parametrosAdicionales!=''">,<xsl:value-of select="$parametrosAdicionales"/></xsl:if>);</xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:when test="$path/name_function_msg">
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$msgId]" disable-output-escaping="yes"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:when test="$name_function_personalizada!=''">
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href">javascript:<xsl:value-of select="$name_function_personalizada"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href"><xsl:value-of select="$path/name_location"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''</xsl:attribute>
          <xsl:if test="$path/target">
            <xsl:attribute name="target"><xsl:value-of select="$path/target"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
   </div><!--fin de botonMenu-->
  
</xsl:template>

<xsl:template name="boton">
 
  <xsl:param name="path"/>
  <xsl:param name="estilo"/>
  <xsl:param name="parametrosAdicionales"/>
  <xsl:param name="name_function_personalizada"/>
 
  <xsl:variable name="msgId" select="$path/name_function_msg"/> 
  
      
       <div class="boton">
      
      <xsl:choose>
      <xsl:when test="$path/name_function">
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href">javascript:<xsl:value-of select="$path/name_function"/>(<xsl:if test="$path/param"><xsl:for-each select="$path/param"><xsl:choose><xsl:when test="position()=last()"><xsl:value-of select="."/></xsl:when><xsl:otherwise><xsl:value-of select="."/>,</xsl:otherwise></xsl:choose></xsl:for-each></xsl:if><xsl:if test="$parametrosAdicionales!=''">,<xsl:value-of select="$parametrosAdicionales"/></xsl:if>);</xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:when test="$path/name_function_msg">
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$msgId]" disable-output-escaping="yes"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:when test="$name_function_personalizada!=''">
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href">javascript:<xsl:value-of select="$name_function_personalizada"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href"><xsl:value-of select="$path/name_location"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''</xsl:attribute>
          <xsl:if test="$path/target">
            <xsl:attribute name="target"><xsl:value-of select="$path/target"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
   </div><!--fin de boton-->
  
</xsl:template>
  
  
  <xsl:template name="botonNostyle">
 
  <xsl:param name="path"/>
  <xsl:param name="estilo"/>
  <xsl:param name="parametrosAdicionales"/>
  <xsl:param name="name_function_personalizada"/>
 
  <xsl:variable name="msgId" select="$path/name_function_msg"/> 
  
      <xsl:choose>
      <xsl:when test="$path/name_function">
     
   
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href">javascript:<xsl:value-of select="$path/name_function"/>(<xsl:if test="$path/param"><xsl:for-each select="$path/param"><xsl:choose><xsl:when test="position()=last()"><xsl:value-of select="."/></xsl:when><xsl:otherwise><xsl:value-of select="."/>,</xsl:otherwise></xsl:choose></xsl:for-each></xsl:if><xsl:if test="$parametrosAdicionales!=''">,<xsl:value-of select="$parametrosAdicionales"/></xsl:if>);</xsl:attribute>

          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>

          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:when test="$path/name_function_msg">
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$msgId]" disable-output-escaping="yes"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:when test="$name_function_personalizada!=''">
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href">javascript:<xsl:value-of select="$name_function_personalizada"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <a id="BTN_ID_{$path/@caption}" name="BTN_NM_{$path/@caption}">
          <xsl:attribute name="href"><xsl:value-of select="$path/name_location"/></xsl:attribute>
          <xsl:attribute name="onMouseOver"><xsl:choose><xsl:when test="$path/@status">window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@status]" disable-output-escaping="yes"/>';</xsl:when><xsl:otherwise>window.status='<xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>';</xsl:otherwise></xsl:choose> return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''</xsl:attribute>
          <xsl:if test="$path/target">
            <xsl:attribute name="target"><xsl:value-of select="$path/target"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="$estilo!=''">
            <xsl:attribute name="style"><xsl:value-of select="$estilo"/></xsl:attribute>
          </xsl:if>
          <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$path/@caption]" disable-output-escaping="yes"/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
</xsl:template>
  
  <!--
        template para el botones personalizados permite personalizar la funtion
  -->
  
  
  <xsl:template name="botonPersonalizado">
  
    <xsl:param name="backgroundBoton"/>
    <xsl:param name="foregroundBoton"/>
    <xsl:param name="fontColor"/>
    <xsl:param name="label"/>
    <xsl:param name="labelCopy"/>
    <xsl:param name="status"/>
    <xsl:param name="funcion"/>
    <xsl:param name="location"/>
    <xsl:param name="destino"/>
    <xsl:param name="ancho"/>
    <xsl:param name="onclick"/>
    <xsl:param name="estiloEnlace"/>
    <xsl:param name="identificador"/>
    <xsl:param name="alineacion"/>
    
 
        <a>
          <xsl:if test="$identificador!=''"><xsl:attribute name="id">BTN_ID_<xsl:value-of select="$identificador"/></xsl:attribute></xsl:if>
          <xsl:if test="$identificador!=''"><xsl:attribute name="name">BTN_NM_<xsl:value-of select="$identificador"/></xsl:attribute></xsl:if>
          <xsl:choose><xsl:when test="$funcion!=''"><xsl:attribute name="href">javascript:<xsl:value-of select="$funcion"/></xsl:attribute></xsl:when><xsl:when test="$location!=''"><xsl:attribute name="href"><xsl:value-of select="$location"/></xsl:attribute></xsl:when></xsl:choose>
          <xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="$status"/>';return true;</xsl:attribute>
          <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
          <xsl:if test="$onclick!=''"><xsl:attribute name="onClick"><xsl:value-of select="$onclick"/></xsl:attribute></xsl:if>
          <xsl:if test="$estiloEnlace!=''"><xsl:attribute name="style"><xsl:value-of select="$estiloEnlace"/></xsl:attribute></xsl:if>
          <xsl:if test="$destino!=''"><xsl:attribute name="target"><xsl:value-of select="$destino"/></xsl:attribute></xsl:if>
          <xsl:choose>
            <xsl:when test="$fontColor=''">
              <xsl:choose>
                <xsl:when test="$label=''">
                  <xsl:copy-of select="$labelCopy"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$label"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <font>
                <xsl:attribute name="color"><xsl:value-of select="$fontColor"/></xsl:attribute>
                  <xsl:choose>
                    <xsl:when test="$label=''">
                      <xsl:copy-of select="$labelCopy"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$label"/>
                    </xsl:otherwise>
                  </xsl:choose>
              </font>
            </xsl:otherwise>
          </xsl:choose>
        </a>
	
  </xsl:template>
  
  
  <!--
   |	Formato más completo de lista desplegable.
   |	Autor: Ferran Foz.
   |
   |	<field_plus name="Chello" [current="1000"] class="classname">
   |		@current - El elemento seleccionado.
   |		@class   - el estilo 
   |	<event name="onChange" action="actualizar();"/>
   |		eventos que disparan funciones javascript.
   |		Eventos definidos:
   |			- onChange
   |	
	   |	<listElem>
			<ID>1000</ID>
			<listItem>Elemento 1000</listItem>
	   |	</listItem>
   |	
   |	</field_plus>
   +-->



<xsl:template name="field_funcion">
    <xsl:param name="path"/>
    <xsl:param name="IDAct"/>
    <xsl:param name="cambio"/>
    <xsl:param name="deshabilitado"/>
    <xsl:param name="perderFoco"/>
	<xsl:param name="claSel"/><!--	21dic16	-->
    <xsl:param name="valorMinimo"/>
    
     
    <xsl:call-template name="dropDownList_funcion">
      <xsl:with-param name="path" select="$path"/>
      <xsl:with-param name="IDAct" select="$IDAct"/>
      <xsl:with-param name="cambio" select="$cambio"/>
      <xsl:with-param name="deshabilitado" select="$deshabilitado"/>
      <xsl:with-param name="perderFoco" select="$perderFoco"/>
      <xsl:with-param name="valorMinimo" select="$valorMinimo"/>
      <xsl:with-param name="claSel" select="$claSel"/>
    </xsl:call-template>
</xsl:template>
  
<xsl:template name="dropDownList_funcion">
    <xsl:param name="path"/>
    <xsl:param name="IDAct"/>
    <xsl:param name="cambio"/>
    <xsl:param name="deshabilitado"/>
    <xsl:param name="perderFoco"/> 
    <xsl:param name="valorMinimo"/>
	<xsl:param name="claSel"/><!--	21dic16	-->

    <select>
      <xsl:attribute name="name">
        <xsl:value-of select="$path/@name"/>
      </xsl:attribute>
      
      <xsl:if test="$cambio!=''">
        <xsl:attribute name="onChange">
          <xsl:value-of select="$cambio"/>
        </xsl:attribute>
      </xsl:if>
      
      <xsl:if test="$deshabilitado!=''">
        <xsl:attribute name="disabled">
          <xsl:value-of select="$deshabilitado"/>
        </xsl:attribute>
      </xsl:if>
      
      <xsl:if test="$perderFoco!=''">
        <xsl:attribute name="onBlur">
          <xsl:value-of select="$perderFoco"/>
        </xsl:attribute>
      </xsl:if>     
	   
	<xsl:if test="$claSel != ''"><!--	21dic16		-->
		<xsl:attribute name="class"><xsl:value-of select="$claSel"/></xsl:attribute>
	</xsl:if>

      <xsl:for-each select="$path/dropDownList/listElem">
        <xsl:choose>
          <xsl:when test="$valorMinimo!=''">
          
            <xsl:if test="number(ID)>=number($valorMinimo)">
              <xsl:choose>
                <xsl:when test="$IDAct = ID">
                  <option selected="selected">
    	            <xsl:attribute name="value">
     	              <xsl:value-of select="ID"/>
  	            </xsl:attribute>                       
   	            <xsl:value-of select="listItem" disable-output-escaping="yes"/>
                  </option>
                </xsl:when>
                <xsl:otherwise>
                  <option>
    	            <xsl:attribute name="value">
     	              <xsl:value-of select="ID"/>
  	            </xsl:attribute>
                    <xsl:value-of select="listItem" disable-output-escaping="yes"/>
                  </option> 
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          
          </xsl:when>
          <xsl:otherwise>   
          
            <xsl:choose>
              <xsl:when test="$IDAct = ID">
                <option selected="selected">
    	          <xsl:attribute name="value">
     	            <xsl:value-of select="ID"/>
  	          </xsl:attribute>                       
   	          <xsl:value-of select="listItem" disable-output-escaping="yes"/>
                </option>
              </xsl:when>
              <xsl:otherwise>
                <option>
    	          <xsl:attribute name="value">
     	            <xsl:value-of select="ID"/>
  	          </xsl:attribute>
                  <xsl:value-of select="listItem" disable-output-escaping="yes"/>
                </option> 
              </xsl:otherwise>
            </xsl:choose>
            
          </xsl:otherwise>
        </xsl:choose> 
      </xsl:for-each>
    </select>
  </xsl:template>



  <xsl:template name="field_plus_funcion">
    <xsl:param name="path"/>
    <xsl:param name="IDAct"/>
  
    <xsl:element name="select">
    <!--
     modifcado por nacho 2/11/2001
    hago una comprobacion de los atributos @name @class @current antes de la asignacion
    -->
      <xsl:if test="$path/@name">
        <xsl:attribute name="name"><xsl:value-of select="$path/@name"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="$path/@class">
        <xsl:attribute name="class"><xsl:value-of select="$path/@class"/></xsl:attribute>
      </xsl:if>

      <!-- Afegim els events. -->
      <xsl:for-each select="$path/event">
       <!-- Es obligatorio posar el nom de l'atribut, per tant posem tots els noms dels events posibles -->
       <xsl:choose>
        <xsl:when test="@name[.='onChange']">
      	 <xsl:attribute name="onChange">
      	   <xsl:value-of select="@action"/>
      	 </xsl:attribute>
      	</xsl:when>
       </xsl:choose>
      </xsl:for-each>
      <!-- Fi. Afegim els events. -->
      
      <!-- Afegim els elements. 
       |   
       |   La opció seleccionada apareix seleccionada per defecte, 
       +-->     
       
       <xsl:variable name="defecto">
         <xsl:choose>
           <xsl:when test="$path/@current"> 	     
      	     <xsl:value-of select="$path/@current"/>
      	  </xsl:when>
      	  <xsl:otherwise> 	     
      	     <xsl:value-of select="$IDAct"/>
      	  </xsl:otherwise>
         </xsl:choose>
       </xsl:variable>
        
       <xsl:for-each select="$path/listElem">
        <xsl:choose>
          <xsl:when test="$defecto = ID">
            <option selected="selected">
    	      <xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>[<xsl:value-of select="listItem"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute><xsl:value-of select="listItem"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
          
      </xsl:for-each>
      <!-- Fi. Afegim els elements. -->            
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="SESION_CADUCADA">
    <xsl:variable name="vMSGT"><xsl:value-of select="MSGT"/></xsl:variable>
    <xsl:variable name="vMSGB"><xsl:value-of select="MSGB"/></xsl:variable>
  
  <div class="divLeft">
          <h1 class="titlePage">
            <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$vMSGT and @lang='spanish']" disable-output-escaping="yes"/>
    		
          </h1><!--fin de tituloPag-->
          <xsl:if test="MSGT">
            <p class="center">
              <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id=$vMSGB and @lang='spanish']" disable-output-escaping="yes"/>
            </p>
          </xsl:if>
	</div><!--fin de divLeft-->    
</xsl:template>
  
  
  
  
  <xsl:template name="pestanya">
  
    <xsl:param name="posicion"/>
    <xsl:param name="posicionSeleccionada"/>
    <xsl:param name="ultimaPestanya"/>
    <xsl:param name="label"/>
    <xsl:param name="location"/>
    
    
    <xsl:variable name="vSeleccionada">
      <xsl:choose>
        <xsl:when test="$posicionSeleccionada!=''">
          <xsl:value-of select="$posicionSeleccionada"/>
        </xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

        <xsl:choose>
        
               <!-- pestanya seleccionada  -->
          <xsl:when test="$posicion=$vSeleccionada"> 
            <xsl:choose>
                  <!-- primera pestanya -->
              <xsl:when test="$posicion=1">
                <td>
                  <img src="http://www.newco.dev.br/images/pestanyas/primeroOblicuoSeleccionado.gif"/><br/>
                </td>
              </xsl:when>
                <!--  restantes pestanyas -->
              <xsl:otherwise>
                <td>
                  <img src="http://www.newco.dev.br/images/pestanyas/oblicuoSeleccionado.gif"/><br/>
                </td>
              </xsl:otherwise>
            </xsl:choose>
            <!-- cuerpo de la pestanya seleccionada -->
            <td background="http://www.newco.dev.br/images/pestanyas/fondoSeleccionado.gif" class="medio">
              <a>
                <xsl:attribute name="href">
                  <xsl:choose>
                    <xsl:when test="contains($location,'?')">
                      <xsl:value-of select="$location"/>&amp;PESTANYASELECCIONADA=<xsl:value-of select="$posicion"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$location"/>?PESTANYASELECCIONADA=<xsl:value-of select="$posicion"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="$label"/>'; return true;</xsl:attribute>
                <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
                <xsl:value-of select="$label"/>
              </a>
            </td>
            <xsl:choose>
                <!-- es la ultima pestanya -->
              <xsl:when test="$posicion=$ultimaPestanya">
                <td>
                  <img src="http://www.newco.dev.br/images/pestanyas/ultimoRectoSeleccionado.gif"/><br/>
                </td>
              </xsl:when>
              <xsl:otherwise>
                <td>
                  <img src="http://www.newco.dev.br/images/pestanyas/rectoSeleccionado.gif"/><br/>
                </td>
              </xsl:otherwise>
            </xsl:choose> 
          
          </xsl:when>
            <!-- pestanyas no seleccionadas -->
          <xsl:otherwise>
            <xsl:choose>
                 <!-- primera no seleccionada -->
              <xsl:when test="$posicion=1">
                <td>
                  <img src="http://www.newco.dev.br/images/pestanyas/primeroOblicuoNoSeleccionado.gif"/><br/>
                </td>  
              </xsl:when>
              <xsl:otherwise>
                <td>
                  <img src="http://www.newco.dev.br/images/pestanyas/oblicuoNoSeleccionado.gif"/><br/>
                </td>
              </xsl:otherwise>
            </xsl:choose>
               <!-- cuerpo de la pestanya no seleccionada -->
            <td background="http://www.newco.dev.br/images/pestanyas/fondoNoSeleccionado.gif"  class="oscuro">
              <a>
                <xsl:attribute name="href">
                  <xsl:choose>
                    <xsl:when test="contains($location,'?')">
                      <xsl:value-of select="$location"/>&amp;PESTANYASELECCIONADA=<xsl:value-of select="$posicion"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$location"/>?PESTANYASELECCIONADA=<xsl:value-of select="$posicion"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="onMouseOver">window.status='<xsl:value-of select="$label"/>'; return true;</xsl:attribute>
                <xsl:attribute name="onMouseOut">window.status=''; return true;</xsl:attribute>
                <xsl:value-of select="$label"/>
              </a>
            </td>
            <xsl:choose>
                   <!-- la siguiente pestanya esta selecciona -->
              <xsl:when test="($posicion+1)=$vSeleccionada">
                <td>
                  <img src="http://www.newco.dev.br/images/pestanyas/rectoSiguienteSeleccionado.gif"/><br/>
                </td> 
              </xsl:when>
              <xsl:otherwise>
                  <!--  la siguiente no esta seleccionada-->
                <xsl:choose>
                    <!-- es la ultima pestanya -->
                  <xsl:when test="$posicion=$ultimaPestanya">
                    <td>
                      <img src="http://www.newco.dev.br/images/pestanyas/ultimoRectoNoSeleccionado.gif"/><br/>
                    </td>
                  </xsl:when>
                      <!-- no es la ultima -->
                  <xsl:otherwise>
                    <td>
                      <img src="http://www.newco.dev.br/images/pestanyas/rectoNoSeleccionado.gif"/><br/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        

  </xsl:template>
  
  
  <xsl:template name="ArrayPestanyas">
  
    <xsl:param name="path"/>
	  <xsl:param name="seleccionada"/>
	  
	  <table cellpadding="0" cellspacing="0" border="0">
		  <tr>   
	      <xsl:for-each select="$path/PESTANYA">
	  
	        <xsl:call-template name="pestanya">
            <xsl:with-param name="posicion" select="position()"/>
            <xsl:with-param name="posicionSeleccionada" select="$seleccionada"/>
            <xsl:with-param name="ultimaPestanya" select="count($path/*)"/>
            <xsl:with-param name="label" select="TEXTO"/>
            <xsl:with-param name="location" select="LOCATION"/>
          </xsl:call-template>
      
	      </xsl:for-each>
	    </tr>
	    <tr>
	      <td colspan="{count($path/*)*3}" background="http://www.newco.dev.br/images/pestanyas/soporte.gif" class="medio">
	        <img src="http://www.newco.dev.br/images/pestanyas/soporte.gif"/><br/>
	      </td>
	    </tr>
	  </table>
	  
  </xsl:template>

<xsl:template name="desplegable_disabled">

    <xsl:param name="path"/>
    <xsl:param name="onChange"/>
    <xsl:param name="defecto"/>
    <xsl:param name="deshabilitado"/>
    <xsl:param name="nombre"/>
    <xsl:param name="id"/>
    <xsl:param name="sincontenido"/>
    <xsl:param name="claSel"/>
    
    
    
    <xsl:variable name="activa">
      <xsl:choose>
        <xsl:when test="$defecto!=''">
          <xsl:value-of select="$defecto"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$path/@current"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="$path/dropDownList/listElem[ID = ../../@current]/listItem" /> 
    <input type="hidden">
    	<xsl:if test="$claSel != ''">
        	<xsl:attribute name="class"><xsl:value-of select="$claSel" /></xsl:attribute>
        </xsl:if>
      <xsl:choose>
        <xsl:when test="$nombre!=''">
          <xsl:attribute name="name"><xsl:value-of select="$nombre"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="name"><xsl:value-of select="$path/@name"/></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      
      <xsl:choose>
        <xsl:when test="$id!=''">
          <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
        </xsl:when>
        <xsl:when test="$path/@id != ''">
        	<xsl:attribute name="id"><xsl:value-of select="$path/@id"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="id"><xsl:value-of select="$path/@name"/></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:attribute name="value"><xsl:value-of select="$activa"/></xsl:attribute>

    </input>


</xsl:template>


<!-- 
	Formulario para valoración de proveedores, para incluir en las páginas donde se pueda valorar proveedores	
	Ultima revision: ET 6set17 11:13
	
	Funcionalidad JS asociada: 
		Administracion/Mantenimiento/Empresas/EMPValoracionProv.js
		General/starrating.js
		General/Tabla-popup.150715.js
-->
<xsl:template name="nuevavaloracion">
    <xsl:param name="doc" />
    <xsl:param name="idproveedor" />
    <xsl:param name="proveedor" />
    <xsl:param name="fecha" />
	<div class="overlay-container" id="NuevaValoracionWrap">
		<div class="window-container zoomout">
			<p style="text-align:right;">
			  <a href="javascript:showTabla(false);" style="text-decoration:none;">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='cerrar']/node()"/>
			  </a>&nbsp;
			  <a href="javascript:showTabla(false);" style="text-decoration:none;">
				<img src="http://www.newco.dev.br/images/cerrar.gif" alt="Cerrar"/>
			  </a>
			</p>

			<p id="tableTitle">
				<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva_valoracion']/node()"/>&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='para']/node()"/>&nbsp;
				<xsl:value-of select="$proveedor"/>,&nbsp;
				<xsl:value-of select="document($doc)/translation/texts/item[@name='dia']/node()"/>&nbsp;
				<xsl:value-of select="$fecha"/>
			</p>

			<div id="mensError" class="divLeft" style="display:none;">
				<p><label><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derechos']/node()"/>&nbsp;</label></p>
			</div>

			<form name="NuevaValoracionForm" method="post" id="NuevaValoracionForm">
				<input type="hidden" name="NV_IDEmpresa" id="NV_IDEmpresa" value="{$idproveedor}"/>
				<input type="hidden" name="notaCalidadObli" id="notaCalidadObli" value="{document($doc)/translation/texts/item[@name='nota_calidad_obli']/node()}"/>
				<input type="hidden" name="notaServicioObli" id="notaServicioObli" value="{document($doc)/translation/texts/item[@name='nota_servicio_obli']/node()}"/>
				<input type="hidden" name="notaPrecioObli" id="notaPrecioObli" value="{document($doc)/translation/texts/item[@name='nota_precio_obli']/node()}"/>
				<table id="NuevaValoracion" class="tableCenter w1200px" cellspacing="6px" cellpadding="6px">
				<thead>
					<th colspan="4">&nbsp;</th>
				</thead>
				<tbody>
					<tr>
						<td><label><xsl:value-of select="document($doc)/translation/texts/item[@name='nota_calidad']/node()"/>:&nbsp;</label></td>
						<td colspan="3" class="rating-holder" style="text-align:left; padding-left:3px;">
							<input type="hidden" name="NV_NOTACALIDAD" id="NV_NOTACALIDAD"/>
							<ul class="list-unstyled">
								<li class="">
									<a href="#">1</a>
								</li>
								<li class="">
									<a href="#">2</a>
								</li>
								<li class="">
									<a href="#">3</a>
								</li>
								<li class="">
									<a href="#">4</a>
								</li>
								<li class="">
									<a href="#">5</a>
								</li>
							</ul>
							<span class="rating"><span>0</span>/5</span>
						</td>
					</tr>
					<tr>
						<td><label><xsl:value-of select="document($doc)/translation/texts/item[@name='nota_servicio']/node()"/>:&nbsp;</label></td>
						<td colspan="3" class="rating-holder" style="text-align:left; padding-left:3px;">
							<input type="hidden" name="NV_NOTASERVICIO" id="NV_NOTASERVICIO"/>
							<ul class="list-unstyled">
								<li class="">
									<a href="#">1</a>
								</li>
								<li class="">
									<a href="#">2</a>
								</li>
								<li class="">
									<a href="#">3</a>
								</li>
								<li class="">
									<a href="#">4</a>
								</li>
								<li class="">
									<a href="#">5</a>
								</li>
							</ul>
							<span class="rating"><span>0</span>/5</span>
						</td>
					</tr>
					<tr>
						<td><label><xsl:value-of select="document($doc)/translation/texts/item[@name='nota_precio']/node()"/>:&nbsp;</label></td>
						<td colspan="3" class="rating-holder" style="text-align:left; padding-left:3px;">
							<input type="hidden" name="NV_NOTAPRECIO" id="NV_NOTAPRECIO"/>
							<ul class="list-unstyled">
								<li class="">
									<a href="#">1</a>
								</li>
								<li class="">
									<a href="#">2</a>
								</li>
								<li class="">
									<a href="#">3</a>
								</li>
								<li class="">
									<a href="#">4</a>
								</li>
								<li class="">
									<a href="#">5</a>
								</li>
							</ul>
							<span class="rating"><span>0</span>/5</span>
						</td>
					</tr>
					<tr class="sinLinea">
						<td><label><xsl:value-of select="document($doc)/translation/texts/item[@name='comentario']/node()"/>:&nbsp;</label></td>
						<td colspan="3" style="text-align:left; padding-left:3px;">
							<textarea name="NV_COMENTARIO" id="NV_COMENTARIO" cols="60" rows="5" style="float:left;margin-right:10px;"/><br/>&nbsp;
						<label><xsl:value-of select="document($doc)/translation/texts/item[@name='visibilidad']/node()"/>:&nbsp;</label>
						  <input type="radio" class="muypeq" name="NV_IDVISIBILIDAD" id="NV_VIS_PRIVADA" value="P"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='priv']/node()"/>&nbsp;&nbsp;
						  <input type="radio" class="muypeq" name="NV_IDVISIBILIDAD" id="NV_VIS_PUBLICO" value="Z" checked="checked"></input>&nbsp;<xsl:value-of select="document($doc)/translation/texts/item[@name='pub']/node()"/>&nbsp;&nbsp;
						</td>
					</tr>
				</tbody>
				<tfoot>
				<tr class="sinLinea">
					<td>&nbsp;</td>
					<td style="text-align:left;">
						<a class="btnDestacado" id="botonNuevaValoracion" href="javascript:nuevaValoracion();">
							<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
						</a>
					</td>
					<td id="Respuesta" colspan="2" style="text-align:left;"></td>
				</tr>
				</tfoot>
				</table>
			</form>
		</div>
	</div>
</xsl:template>


</xsl:stylesheet>
