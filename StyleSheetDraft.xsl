<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="html" indent="yes"/>
    
   
    <xsl:param name="highlight" select="''"/>
    <xsl:variable name="active" select="tokenize($highlight, ',')"/>
    
    <!-- Document root -->
    <xsl:variable name="doc" select="/*"/>
    
 
    <xsl:variable name="schema-elements" as="xs:string*"
        select="('ref','dp','fp','health','mil','context','party','eco','env','imm','soc','crime')"/>
    
    <!-- attributes present in doc -->
    <xsl:variable name="all-attributes"
        select="distinct-values($doc//@*/name())"/>
    
    
    <!-- CSS -->
    <xsl:template name="style">
        <style>
            body {
            font-family: sans-serif;
            margin: 0; padding: 0;
            }
            #leftmenu, #rightmenu {
            position: fixed;
            top: 0;
            width: 240px;
            height: 100vh;
            overflow-y: auto;
            background: #fafafa;
            }
            #leftmenu {
            left: 0;
            border-right: 1px solid #aaa;
            }
            #rightmenu {
            right: 0;
            border-left: 1px solid #aaa;
            }
            #main {
            margin-left: 250px;
            margin-right: 250px;
            padding: 1em;
            }
            h1 { font-weight:bold; }
            p { margin-bottom:1em; }
            .highlight {
            background-color: #fff4a8;
            padding: 2px;
            border-radius: 2px;
            }
        </style>
    </xsl:template>
    
    
    <!-- MAIN -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Speech</title>
                <xsl:call-template name="style"/>
            </head>
            <body>
                
                <!-- Attribute Menu -->
                <div id="leftmenu">
                    <h3>Attributes</h3>
                    <ul>
                        <xsl:for-each select="$all-attributes">
                            <xsl:sort/>
                            <li>
                                <b><xsl:value-of select="."/></b>
                                
                                <ul>
                                    <xsl:for-each
                                        select="distinct-values($doc//*[@*[name()=current()]]/name())">
                                        <xsl:sort/>
                                        <li><xsl:value-of select="."/></li>
                                    </xsl:for-each>
                                </ul>
                                
                                <!-- attribute values -->
                                <ul>
                                    <xsl:variable name="attName" select="."/>
                                    <xsl:for-each
                                        select="distinct-values($doc//@*[name()=$attName])">
                                        <xsl:sort/>
                                        <xsl:variable name="v" select="."/>
                                        <xsl:variable name="sig"
                                            select="concat($attName,'.',string($v))"/>
                                        <xsl:variable name="newList"
                                            select="string-join(distinct-values(($active,$sig)), ',')"/>
                                        
                                        <li>
                                            <a href="?highlight={$newList}#firstHit">
                                                <xsl:value-of select="concat($attName,'=',string($v))"/>
                                            </a>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
                
                
                <!-- Elements Menu -->
                <div id="rightmenu">
                    <h3>Elements</h3>
                    <ul>
                        <xsl:for-each select="$schema-elements">
                            <xsl:sort/>
                            <xsl:variable name="ename" select="."/>
                            <xsl:variable name="newList"
                                select="string-join(distinct-values(($active,$ename)), ',')"/>
                            <li>
                                <a href="?highlight={$newList}#firstHit">
                                    <xsl:value-of select="$ename"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
                
                
                <!-- View -->
                <div id="main">
                    <xsl:apply-templates select="$doc"/>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    
    <!-- Root -->
    <xsl:template match="text">
        <h1><xsl:value-of select="normalize-space(text()[1])"/></h1>
        <xsl:apply-templates select="p"/>
    </xsl:template>
    
    
    <!-- paragraph -->
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    
    <!-- Highlighting -->
    <xsl:template match="*">
        <xsl:variable name="ename" select="name()"/>
        <xsl:variable name="attSigs"
            select="for $a in @* return concat(name($a),'.',string($a))"/>
        
        <xsl:variable name="needsHighlight"
            select="($ename = $active) or exists($attSigs[. = $active])"/>
        
        <xsl:choose>
            <xsl:when test="$needsHighlight">
                
                <xsl:if test="not(//*[@id='firstHit'])">
                    <span id="firstHit" class="highlight">
                        <xsl:apply-templates/>
                    </span>
                </xsl:if>
                <xsl:if test="//*[@id='firstHit']">
                    <span class="highlight">
                        <xsl:apply-templates/>
                    </span>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- text -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
