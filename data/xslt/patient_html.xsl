<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical">
    <xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Patients</title>
                <link rel="stylesheet" href="../css/pagePatient.css"/>
            </head>
            <body>
                <table border="1">
                    <ul>
                        <li>Nom : <xsl:value-of select="/med:patient/med:nom"/></li>
                        <li>Prénom : <xsl:value-of select="/med:patient/med:prénom"/></li>
                        <li>Sexe : <xsl:value-of select="/med:patient/med:sexe"/></li>
                        <li>Naissance : <xsl:value-of select="/med:patient/med:naissance"/></li>
                        <li>N°securite sociale : <xsl:value-of select="/med:patient/med:numéroSS"/></li>
                        <li>Adresse : <xsl:value-of select="/med:patient/med:adresse/med:rue"/>, <xsl:value-of select="/med:patient/med:adresse/med:codePostal"/> (<xsl:value-of select="/med:patient/med:adresse/med:ville"/>)</li>
                        <h3>Visite</h3>
                        <table border="1">
                            <tr>
                                <th>Date</th>
                                <th>Soins à éffectuer</th>
                                <th>Intervenant</th>
                            </tr>
                            <xsl:apply-templates select="//med:visite"></xsl:apply-templates>
                        </table>
                    </ul>
                </table>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="med:visite">
        <td><xsl:value-of select="./@date"/></td>
        <td><xsl:value-of select="./med:acte"/></td>
        <td><xsl:value-of select="./med:intervenant/med:nom"/></td>
    </xsl:template>

</xsl:stylesheet>