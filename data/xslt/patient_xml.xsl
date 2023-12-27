<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes"
                xmlns:xs="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output method="xml"/>

    
    <xsl:param name="destinedName" select="'Pien'"/> 
    
    
    <xsl:template match="/">

        <med:patient>
            <!-- On applique la template sur le patient
            qui a le même nom que celui en parametre 
            puis on affiche tout ses informations dans 
            la templates -->
            <xsl:attribute name="xs:schemaLocation">http://www.ujf-grenoble.fr/l3miage/medical ../xsd/patient.xsd</xsl:attribute>
            <xsl:apply-templates select="//med:patient[med:nom=$destinedName]"/>
        </med:patient>
        
    </xsl:template>
    
    
    <xsl:template match="med:patient">
        <med:nom><xsl:value-of select="med:nom"/></med:nom>
        <med:prénom><xsl:value-of select="med:prénom"/></med:prénom>
        <med:sexe><xsl:value-of select="med:sexe"/></med:sexe>
        <med:naissance><xsl:value-of select="med:naissance"/></med:naissance>
        <med:numéro><xsl:value-of select="med:numéro"/></med:numéro>
        <med:adresse>
            <med:rue><xsl:value-of select="med:adresse/med:rue"/></med:rue>
            <med:codePostal><xsl:value-of select="med:adresse/med:codePostal"/></med:codePostal>
            <med:ville><xsl:value-of select="med:adresse/med:ville"/></med:ville>
        </med:adresse>
        <xsl:apply-templates select="med:visite"/>

    </xsl:template>
    
    
    <xsl:template match="med:visite">
        <med:visite> 
            <xsl:attribute name="date"><xsl:value-of select="@date"/></xsl:attribute>
            <med:intervenant>
                <!-- On stocke l'id de l'infirmiere dans une variable-->
                <xsl:variable name="destinedId" select="@intervenant"/> 
                <med:nom><xsl:value-of select="//med:infirmier[@id=$destinedId]/med:nom"/></med:nom>
                <med:prénom><xsl:value-of select="//med:infirmier[@id=$destinedId]/med:prénom"/></med:prénom>
            </med:intervenant>
            <!-- Pour chaque acte on affiche sa descripiton-->
            <xsl:apply-templates select="med:acte"/>
        </med:visite>
    </xsl:template>
    
    
    <xsl:template match="med:acte">
        <!-- Pour chaque acte du patient -->
        <xsl:variable name="idActe" select="@id"/> 
        <!-- Pour chaque id du patient on regarde dans l'arborescence
        du fichiers actes.xml lorsque l'acte est égale à l'id du patient-->
        <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap/act:actes/act:acte[@id=$idActe]"/>
        <!-- Puis on affiche la description pour chauqe acte-->
        <med:acte><xsl:value-of select="$actes"/></med:acte>
    </xsl:template>

</xsl:stylesheet>