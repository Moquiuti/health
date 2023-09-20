<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>
          Datos de Contacto de los Responsables de las Comisiones
        </title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
         <script type="text/javascript" src="http://www.newco.dev.br/General/general.js"></script>	
        <script type="text/javascript">
        <!--
		
	//-->        
        </script>
        ]]></xsl:text> 
        
        
      </head>
      <body bgcolor="#FFFFFF" topmargin="15px" leftmargin="15px">
        <xsl:choose>
          <!-- Error en alguna sentencia del XSQL -->
          <xsl:when test="//xsql-error">
            <xsl:apply-templates select="//xsql-error"/>        
          </xsl:when>
          <xsl:when test="//SESION_CADUCADA">
            <xsl:for-each select="//SESION_CADUCADA">
              <xsl:if test="position()=last()">
                <xsl:apply-templates select="."/>
              </xsl:if>
            </xsl:for-each>        
          </xsl:when>
          <xsl:when test="//Status">
            <xsl:apply-templates select="//Status"/> 
          </xsl:when>
          <xsl:otherwise>  
            <p class="TituloPag" align="center">Datos de Contacto de los Responsables de las Comisiones</p>
            <br/>
            <br/>

        <table width="100%" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td>
            
            <!--      CATALOGO      -->
            
            
              <table width="95%" cellpadding="3" cellspacing="1" align="center" class="muyoscuro">
                <tr class="oscuro">
                  <td colspan="2">
                    <b>Comisión de Catálogo</b>
                  </td>
                </tr>
                <xsl:choose>
                  <xsl:when test="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO">
                  
                    <!-- usuario -->
                    
                    <!-- nombre responsable -->
                    <tr class="claro">
                      <td class="medio" width="25%">
                        Responsable:
                      </td>
                      <td>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_NOMBRE"/>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_APELLIDO1"/>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_APELLIDO2"/>
                      </td>
                    </tr>
                    <!-- telf movil usuario -->
                    <xsl:if test="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_TF_MOVIL!=''">
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Teléfono Móvil:
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_TF_MOVIL"/>
                        </td>
                      </tr>
                    </xsl:if>
                    <!-- telf usuario -->
                    <xsl:choose>
                      <xsl:when test="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_TF_FIJO!=''">
                        <tr class="claro">
                          <td class="medio" width="25%">
                            Teléfono:
                          </td>
                          <td>
                            &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_TF_FIJO"/>
                          </td>
                        </tr>
                      </xsl:when>
                      <xsl:otherwise>
                         <!-- telf centro -->
                        <xsl:choose>
                          <xsl:when test="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_TELEFONO!=''">
                            <tr class="claro">
                              <td class="medio" width="25%">
                                Teléfono:
                              </td>
                              <td>
                                &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_TELEFONO"/>
                              </td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            <!-- telf empresa -->
                            <xsl:choose>
                              <xsl:when test="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/EMP_TELEFONO!=''">
                                <tr class="claro">
                                  <td class="medio" width="25%">
                                    Teléfono:
                                  </td>
                                  <td>
                                    &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/EMP_TELEFONO"/>
                                  </td>
                                </tr>
                              </xsl:when>
                              <xsl:otherwise>
                                &nbsp;---
                              </xsl:otherwise>
                            </xsl:choose>
                            
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                    <!-- fax centro -->
                    <xsl:choose>
                      <xsl:when test="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_FAX!=''">
                        <tr class="claro">
                          <td class="medio" width="25%">
                            Fax:
                          </td>
                          <td>
                            &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_FAX"/>
                          </td>
                        </tr>
                      </xsl:when>
                      <xsl:otherwise>
                         <!-- fax empresa -->
                        <xsl:choose>
                          <xsl:when test="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/EMP_FAX!=''">
                            <tr class="claro">
                              <td class="medio" width="25%">
                                Fax:
                              </td>
                              <td>
                                &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/EMP_FAX"/>
                              </td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            &nbsp;--- 
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                     <!-- email responsable  -->
                    <tr class="claro">
                      <td class="medio" width="25%">
                        e-mail:
                      </td>
                      <td>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_EMAIL"/>
                      </td>
                    </tr>
                    <!-- email 2 responsable -->
                    <xsl:if test="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_EMAIL2!=''">
                      <tr class="claro">
                        <td class="medio" width="25%">
                          e-mail(2):
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/US_EMAIL2"/>
                        </td>
                      </tr>
                    </xsl:if>
                    
                    <tr class="blanco">
                      <td colspan="2">
                        &nbsp;
                      </td>
                    </tr>
                    
                    <!-- centro -->
                    
                    <!-- nombre centro -->
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Centro
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_NOMBRE"/>
                        </td>
                      </tr>
                      <!-- direccion centro -->
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Dirección
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_DIRECCION"/>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_CPOSTAL"/>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_POBLACION"/>
                          &nbsp;(<xsl:value-of select="Contactos/LISTACONTACTOS/CATALOGACION/CONTACTO/CEN_PROVINCIA"/>)
                        </td>
                      </tr>
                  </xsl:when>
                  <xsl:otherwise>
                    <tr class="claro">
                      <td align="center" colspan="2">
                        <b>Usuario no Asignado</b>
                      </td>
                    </tr>
                  </xsl:otherwise>
                </xsl:choose>
              </table>
              
            </td>
            <td>
            
              
              <!--     EVALUACION      -->
              
              <table width="95%" cellpadding="3" cellspacing="1" align="center" class="muyoscuro">
                <tr class="oscuro">
                  <td colspan="2">
                    <b>Comisión de Evaluación</b>
                  </td>
                </tr>
                <xsl:choose>
                  <xsl:when test="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO">
                  
                    <!-- usuario -->
                    
                    <!-- nombre responsable -->
                    <tr class="claro">
                      <td class="medio" width="25%">
                        Responsable:
                      </td>
                      <td>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_NOMBRE"/>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_APELLIDO1"/>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_APELLIDO2"/>
                      </td>
                    </tr>
                    <!-- telf movil usuario -->
                    <xsl:if test="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_TF_MOVIL!=''">
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Teléfono Móvil:
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_TF_MOVIL"/>
                        </td>
                      </tr>
                    </xsl:if>
                    <!-- telf usuario -->
                    <xsl:choose>
                      <xsl:when test="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_TF_FIJO!=''">
                        <tr class="claro">
                          <td class="medio" width="25%">
                            Teléfono:
                          </td>
                          <td>
                            &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_TF_FIJO"/>
                          </td>
                        </tr>
                      </xsl:when>
                      <xsl:otherwise>
                         <!-- telf centro -->
                        <xsl:choose>
                          <xsl:when test="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_TELEFONO!=''">
                            <tr class="claro">
                              <td class="medio" width="25%">
                                Teléfono:
                              </td>
                              <td>
                                &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_TELEFONO"/>
                              </td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            <!-- telf empresa -->
                            <xsl:choose>
                              <xsl:when test="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/EMP_TELEFONO!=''">
                                <tr class="claro">
                                  <td class="medio" width="25%">
                                    Teléfono:
                                  </td>
                                  <td>
                                    &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/EMP_TELEFONO"/>
                                  </td>
                                </tr>
                              </xsl:when>
                              <xsl:otherwise>
                                &nbsp;---
                              </xsl:otherwise>
                            </xsl:choose>
                            
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                    <!-- fax centro -->
                    <xsl:choose>
                      <xsl:when test="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_FAX!=''">
                        <tr class="claro">
                          <td class="medio" width="25%">
                            Fax:
                          </td>
                          <td>
                            &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_FAX"/>
                          </td>
                        </tr>
                      </xsl:when>
                      <xsl:otherwise>
                         <!-- fax empresa -->
                        <xsl:choose>
                          <xsl:when test="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/EMP_FAX!=''">
                            <tr class="claro">
                              <td class="medio" width="25%">
                                Fax:
                              </td>
                              <td>
                                &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/EMP_FAX"/>
                              </td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            &nbsp;--- 
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                     <!-- email responsable  -->
                    <tr class="claro">
                      <td class="medio" width="25%">
                        e-mail:
                      </td>
                      <td>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_EMAIL"/>
                      </td>
                    </tr>
                    <!-- email 2 responsable -->
                    <xsl:if test="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_EMAIL2!=''">
                      <tr class="claro">
                        <td class="medio" width="25%">
                          e-mail(2):
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/US_EMAIL2"/>
                        </td>
                      </tr>
                    </xsl:if>
                    
                    <tr class="blanco">
                      <td colspan="2">
                        &nbsp;
                      </td>
                    </tr>
                    
                    <!-- centro -->
                    
                    <!-- nombre centro -->
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Centro
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_NOMBRE"/>
                        </td>
                      </tr>
                      <!-- direccion centro -->
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Dirección
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_DIRECCION"/>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_CPOSTAL"/>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_POBLACION"/>
                          &nbsp;(<xsl:value-of select="Contactos/LISTACONTACTOS/EVALUACION/CONTACTO/CEN_PROVINCIA"/>)
                        </td>
                      </tr>
                  </xsl:when>
                  <xsl:otherwise>
                    <tr class="claro">
                      <td align="center" colspan="2">
                        <b>Usuario no Asignado</b>
                      </td>
                    </tr>
                  </xsl:otherwise>
                </xsl:choose>
              </table>



           </td>
          </tr>
          <tr>
            <td colspan="2">
              &nbsp;
              <br/>
              &nbsp;
            </td>
          </tr>
          <tr>
            <td>
        
            
            
              <!--     NEGOCIACION     -->
              
              <table width="95%" cellpadding="3" cellspacing="1" align="center" class="muyoscuro">
                <tr class="oscuro">
                  <td colspan="2">
                    <b>Comisión de Negociación</b>
                  </td>
                </tr>
                <xsl:choose>
                  <xsl:when test="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO">
                  
                    <!-- usuario -->
                    
                    <!-- nombre responsable -->
                    <tr class="claro">
                      <td class="medio" width="25%">
                        Responsable:
                      </td>
                      <td>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_NOMBRE"/>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_APELLIDO1"/>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_APELLIDO2"/>
                      </td>
                    </tr>
                    <!-- telf movil usuario -->
                    <xsl:if test="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_TF_MOVIL!=''">
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Teléfono Móvil:
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_TF_MOVIL"/>
                        </td>
                      </tr>
                    </xsl:if>
                    <!-- telf usuario -->
                    <xsl:choose>
                      <xsl:when test="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_TF_FIJO!=''">
                        <tr class="claro">
                          <td class="medio" width="25%">
                            Teléfono:
                          </td>
                          <td>
                            &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_TF_FIJO"/>
                          </td>
                        </tr>
                      </xsl:when>
                      <xsl:otherwise>
                         <!-- telf centro -->
                        <xsl:choose>
                          <xsl:when test="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_TELEFONO!=''">
                            <tr class="claro">
                              <td class="medio" width="25%">
                                Teléfono:
                              </td>
                              <td>
                                &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_TELEFONO"/>
                              </td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            <!-- telf empresa -->
                            <xsl:choose>
                              <xsl:when test="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/EMP_TELEFONO!=''">
                                <tr class="claro">
                                  <td class="medio" width="25%">
                                    Teléfono:
                                  </td>
                                  <td>
                                    &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/EMP_TELEFONO"/>
                                  </td>
                                </tr>
                              </xsl:when>
                              <xsl:otherwise>
                                &nbsp;---
                              </xsl:otherwise>
                            </xsl:choose>
                            
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                    <!-- fax centro -->
                    <xsl:choose>
                      <xsl:when test="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_FAX!=''">
                        <tr class="claro">
                          <td class="medio" width="25%">
                            Fax:
                          </td>
                          <td>
                            &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_FAX"/>
                          </td>
                        </tr>
                      </xsl:when>
                      <xsl:otherwise>
                         <!-- fax empresa -->
                        <xsl:choose>
                          <xsl:when test="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/EMP_FAX!=''">
                            <tr class="claro">
                              <td class="medio" width="25%">
                                Fax:
                              </td>
                              <td>
                                &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/EMP_FAX"/>
                              </td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            &nbsp;--- 
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                     <!-- email responsable  -->
                    <tr class="claro">
                      <td class="medio" width="25%">
                        e-mail:
                      </td>
                      <td>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_EMAIL"/>
                      </td>
                    </tr>
                    <!-- email 2 responsable -->
                    <xsl:if test="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_EMAIL2!=''">
                      <tr class="claro">
                        <td class="medio" width="25%">
                          e-mail(2):
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/US_EMAIL2"/>
                        </td>
                      </tr>
                    </xsl:if>
                    
                    <tr class="blanco">
                      <td colspan="2">
                        &nbsp;
                      </td>
                    </tr>
                    
                    <!-- centro -->
                    
                    <!-- nombre centro -->
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Centro
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_NOMBRE"/>
                        </td>
                      </tr>
                      <!-- direccion centro -->
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Dirección
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_DIRECCION"/>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_CPOSTAL"/>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_POBLACION"/>
                          &nbsp;(<xsl:value-of select="Contactos/LISTACONTACTOS/NEGOCIACION/CONTACTO/CEN_PROVINCIA"/>)
                        </td>
                      </tr>
                  </xsl:when>
                  <xsl:otherwise>
                    <tr class="claro">
                      <td align="center" colspan="2">
                        <b>Usuario no Asignado</b>
                      </td>
                    </tr>
                  </xsl:otherwise>
                </xsl:choose>
              </table>
              
            
            
            </td>
             <td>
   
   
             
             <!--      INCIDENCIAS      -->
             
             <table width="95%" cellpadding="3" cellspacing="1" align="center" class="muyoscuro">
                <tr class="oscuro">
                  <td colspan="2">
                    <b>Comisión de Incidencias</b>
                  </td>
                </tr>
                <xsl:choose>
                  <xsl:when test="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO">
                  
                    <!-- usuario -->
                    
                    <!-- nombre responsable -->
                    <tr class="claro">
                      <td class="medio" width="25%">
                        Responsable:
                      </td>
                      <td>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_NOMBRE"/>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_APELLIDO1"/>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_APELLIDO2"/>
                      </td>
                    </tr>
                    <!-- telf movil usuario -->
                    <xsl:if test="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_TF_MOVIL!=''">
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Teléfono Móvil:
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_TF_MOVIL"/>
                        </td>
                      </tr>
                    </xsl:if>
                    <!-- telf usuario -->
                    <xsl:choose>
                      <xsl:when test="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_TF_FIJO!=''">
                        <tr class="claro">
                          <td class="medio" width="25%">
                            Teléfono:
                          </td>
                          <td>
                            &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_TF_FIJO"/>
                          </td>
                        </tr>
                      </xsl:when>
                      <xsl:otherwise>
                         <!-- telf centro -->
                        <xsl:choose>
                          <xsl:when test="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_TELEFONO!=''">
                            <tr class="claro">
                              <td class="medio" width="25%">
                                Teléfono:
                              </td>
                              <td>
                                &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_TELEFONO"/>
                              </td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            <!-- telf empresa -->
                            <xsl:choose>
                              <xsl:when test="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/EMP_TELEFONO!=''">
                                <tr class="claro">
                                  <td class="medio" width="25%">
                                    Teléfono:
                                  </td>
                                  <td>
                                    &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/EMP_TELEFONO"/>
                                  </td>
                                </tr>
                              </xsl:when>
                              <xsl:otherwise>
                                &nbsp;---
                              </xsl:otherwise>
                            </xsl:choose>
                            
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                    <!-- fax centro -->
                    <xsl:choose>
                      <xsl:when test="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_FAX!=''">
                        <tr class="claro">
                          <td class="medio" width="25%">
                            Fax:
                          </td>
                          <td>
                            &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_FAX"/>
                          </td>
                        </tr>
                      </xsl:when>
                      <xsl:otherwise>
                         <!-- fax empresa -->
                        <xsl:choose>
                          <xsl:when test="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/EMP_FAX!=''">
                            <tr class="claro">
                              <td class="medio" width="25%">
                                Fax:
                              </td>
                              <td>
                                &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/EMP_FAX"/>
                              </td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            &nbsp;--- 
                          </xsl:otherwise>
                        </xsl:choose>
                        
                      </xsl:otherwise>
                    </xsl:choose>
                     <!-- email responsable  -->
                    <tr class="claro">
                      <td class="medio" width="25%">
                        e-mail:
                      </td>
                      <td>
                        &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_EMAIL"/>
                      </td>
                    </tr>
                    <!-- email 2 responsable -->
                    <xsl:if test="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_EMAIL2!=''">
                      <tr class="claro">
                        <td class="medio" width="25%">
                          e-mail(2):
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/US_EMAIL2"/>
                        </td>
                      </tr>
                    </xsl:if>
                    
                    <tr class="blanco">
                      <td colspan="2">
                        &nbsp;
                      </td>
                    </tr>
                    
                    <!-- centro -->
                    
                    <!-- nombre centro -->
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Centro
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_NOMBRE"/>
                        </td>
                      </tr>
                      <!-- direccion centro -->
                      <tr class="claro">
                        <td class="medio" width="25%">
                          Dirección
                        </td>
                        <td>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_DIRECCION"/>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_CPOSTAL"/>
                          &nbsp;<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_POBLACION"/>
                          &nbsp;(<xsl:value-of select="Contactos/LISTACONTACTOS/INCIDENCIAS/CONTACTO/CEN_PROVINCIA"/>)
                        </td>
                      </tr>
                  </xsl:when>
                  <xsl:otherwise>
                    <tr class="claro">
                      <td align="center" colspan="2">
                        <b>Usuario no Asignado</b>
                      </td>
                    </tr>
                  </xsl:otherwise>
                </xsl:choose>
              </table>
             
       
             
            </td>
          </tr>
        </table>
          
        </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>
  </xsl:template>
  
</xsl:stylesheet>
