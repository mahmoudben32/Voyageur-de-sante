<?xml version="1.0" encoding="UTF-8"?>



<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:cab="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes" >
    <xsl:output method="html"/>

    <xsl:param name="destinedId" select="001"/>
    <xsl:variable name="visiteDuJour" select="//cab:patient/cab:visite[@intervenant=$destinedId]"/>
    <xsl:variable name="actes" select="document('../xml/actes.xml', /)/act:ngap"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Profil de <xsl:value-of select='//cab:infirmier[@id=$destinedId]/cab:nom'/></title>
                <link>
                    <xsl:attribute name="href">../css/pageInfirmier.css</xsl:attribute>
                    <xsl:attribute name="type">text/css</xsl:attribute>
                    <xsl:attribute name="rel">stylesheet</xsl:attribute>
                </link>
                <script type="text/javascript" src="../js/facture.js"></script>
                <script type="text/javascript">
                    function openFacture(prenom, nom, actes) {
                        var width  = 500;
                        var height = 300;
                        if(window.innerWidth) {
                            var left = (window.innerWidth-width)/2;
                            var top = (window.innerHeight-height)/2;
                        }
                        else {
                            var left = (document.body.clientWidth-width)/2;
                            var top = (document.body.clientHeight-height)/2;
                        }
                        var factureWindow = window.open('','facture','menubar=yes, scrollbars=yes, top='+top+', left='+left+', width='+width+', height='+height+'');
                        var factureText = afficherFacture(prenom, nom, actes);
                        factureWindow.document.write(factureText);
                        }
                </script>


            </head>
            <body>
                Bonjour <xsl:value-of select='//cab:infirmier[@id=$destinedId]/cab:nom'/>,<br/>
                Aujourd'hui, vous avez <xsl:value-of select="count($visiteDuJour)"/> patients
                <br/>

                <ul>
                    <xsl:apply-templates select="$visiteDuJour/..">
                        <xsl:sort select="cab:visite/@date"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="cab:patient">
        <li>
            Nom : <xsl:value-of select="cab:nom"/>&#160;<xsl:value-of select="cab:prénom"/><br/>
            Adresse : <xsl:apply-templates select="cab:adresse"/>
            <ul>
                <xsl:apply-templates select="cab:visite"/>
            </ul>
        </li>
        <input>
            <xsl:attribute name="type">button</xsl:attribute>
            <xsl:attribute name="value">Facture</xsl:attribute>
            <xsl:attribute name="onclick">
                openFacture('<xsl:value-of select="cab:prénom"/>',
                            '<xsl:value-of select="cab:nom"/>',
                            '<xsl:value-of select="cab:visite/cab:acte"/>')
            </xsl:attribute>
        </input>
        <br/><br/>
        
        
        
    </xsl:template>
    <xsl:template match="cab:adresse">
        <xsl:if test="cab:étage != ''">
            <xsl:value-of select="cab:étage"/><sup>e</sup> étage,
        </xsl:if>
        <xsl:value-of select="cab:numéro"/>&#160;<xsl:value-of select="cab:rue"/>,
        <xsl:value-of select="cab:codePostal"/>&#160;<xsl:value-of select="cab:ville"/>
    </xsl:template>

    <xsl:template match="cab:visite" >
        <li>
            <p> Visite du <xsl:value-of select="@date" /></p>
            <ul>
                <xsl:apply-templates select="cab:acte"/>
            </ul>
        </li>
    </xsl:template>
    <xsl:template match="cab:acte" >
        <li>
            <xsl:variable name="id" select="@id"/>
            <xsl:value-of select="$actes/act:actes/act:acte[@id = $id]"/>
        </li>
    </xsl:template>

</xsl:stylesheet>