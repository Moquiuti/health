<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="Nomenclator">

  <html>
    <head>
      <title>Nomenclator</title>
        <xsl:text disable-output-escaping="yes"><![CDATA[
        	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        	</script>
          <script type="text/javascript">
            <!--
            
            
            function inicializaArray(array){

                

            	if(esIExplorer()){ 
								if(!isObject(parent.frameListas.form1.LISTA1) || !isObject(parent.frameListas.form1.LISTA2)){
            			return;
            		}
              }
              else{
              	if(!isObject(parent.frameListas.document.form1.LISTA1) || !isObject(parent.frameListas.document.form1.LISTA2)){
            			return;
            		}
             	} 
            
            
              array.length=0;
              
              ]]></xsl:text>
              <xsl:for-each select="/Nomenclator/PADRE/NODO">
                    array[<xsl:value-of select="(position()-1)*3"/>]='<xsl:value-of select="ID"/>';
                    if('<xsl:value-of select="HIJOS"/>'!='0')
                      //array[<xsl:value-of select="((position()-1)*3)+1"/>]='<xsl:value-of select="NOMBRE"/> '+' (<xsl:value-of select="ID"/>) '+'[<xsl:value-of select="HIJOS"/> subfamilias]';
                      array[<xsl:value-of select="((position()-1)*3)+1"/>]='<xsl:value-of select="NOMBRE"/> '+' (<xsl:value-of select="ID"/>)';
                    else
                      array[<xsl:value-of select="((position()-1)*3)+1"/>]='<xsl:value-of select="NOMBRE"/> '+' (<xsl:value-of select="ID"/>)';
                    array[<xsl:value-of select="((position()-1)*3)+2"/>]='<xsl:value-of select="HIJOS"/>';
              </xsl:for-each>
              
              
              
              <xsl:choose>
              
                <xsl:when test="//IDHijo!=''">
                  if(esIExplorer()){ 
                    parent.frameListas.montarListaConSeleccion(array, parent.frameListas.form1.LISTA2,'<xsl:value-of select="//IDHijo"/>');
                    //if(parent.frameListas.pila.length==0)
                      //parent.frameListas.form1.BOTON.disabled=true;  
                  }
                  else{
                    parent.frameListas.montarListaConSeleccion(array, parent.frameListas.document.form1.LISTA2,'<xsl:value-of select="//IDHijo"/>');
                    //if(parent.frameListas.pila.length==0)
                    //parent.frameListas.document.form1.BOTON.disabled=true;  
                  } 
                </xsl:when>
                
               
                
                <xsl:otherwise>
                  if(esIExplorer()){ 
                    parent.frameListas.montarLista(array, parent.frameListas.form1.LISTA2);
                    //if(parent.frameListas.pila.length==0)
                      //parent.frameListas.form1.BOTON.disabled=true;  
                  }
                  else{
                    parent.frameListas.montarLista(array, parent.frameListas.document.form1.LISTA2);
                    //if(parent.frameListas.pila.length==0)
                      //parent.frameListas.document.form1.BOTON.disabled=true;  
                  } 
                </xsl:otherwise>
              </xsl:choose>
            <xsl:text disable-output-escaping="yes"><![CDATA[       
            
            } 
            
            function esIExplorer(){
             if(navigator.appName.match('Microsoft'))
               return true;
             else
               return false;
           }
           
           function incrementarHistoria(){
             parent.frameListas.historico();
           }
            
      //-->
          </script>
        ]]></xsl:text>
      
    </head>
    <body bgcolor="#FFFFFF" onLoad="inicializaArray(parent.frameListas.arraySubfamilias);incrementarHistoria();"> 
    </body>
  </html>
</xsl:template>

<!--        //////////////////////////////        TEMPLATES       \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\        -->  

</xsl:stylesheet>
