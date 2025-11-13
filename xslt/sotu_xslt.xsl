<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Placeholder</title>
            </head>
            <body>
                <h1>Placeholder</h1>
                <h2><xsl:apply-templates select="//metaData"/></h2>
                

                
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
     <!--
    <xsl:template match="p/descendant::*">
            <p>
                <xsl:apply-templates/>
            </p>
        </xsl:template>-->
        
        <xsl:template match = "audience">
            <i>
                <xsl:apply-templates/></i>
        </xsl:template>
       <!-- <xsl:template match = "metaData" mode="auth">
            <p> 
                <xsl:apply-templates select="author"/><xsl:text> and </xsl:text> <xsl:apply-templates select="editor"/></p>
        </xsl:template> --> 
        <xsl:template match="story" mode="toc">           
            
            <p><a href="#title{title}">
                    <xsl:apply-templates select="title" mode="toc"/></a></p>
        </xsl:template>
        
        <xsl:template match="story"><section>
                <h2><a id="#title{title}"><xsl:apply-templates select="title"/></a></h2>
                <i><xsl:apply-templates select="origin"/></i>
                
                <xsl:apply-templates select="p"/>
                
        </section>
        </xsl:template>
        <xsl:template match="p">
            <br><div><xsl:apply-templates/></div></br>
        </xsl:template>
  
</xsl:stylesheet>