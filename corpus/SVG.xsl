<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/2000/svg" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="prop-corpus" as="document-node()+"
        select="collection('./Valid Markup? select=*.xml')"/> <xsl:template name="xsl:initial-template">
            <root>
              <!--  <metadata>There are <xsl:value-of select="$prop-corpus//placeName =>
                        count("/> places in the corpus.</metadata>-->
                <xsl:apply-templates select="$prop-corpus"/>
            </root>
        </xsl:template>
    
    <!-- ================================================================ -->
    <!-- Stylesheet variables (preset)                                    -->
    <!-- ================================================================ -->
    <!-- number of pixels vertical for the Y axis -->
    <xsl:variable name="max_height" as="xs:double" select="500"/>
    <!-- default spacing variable -->
    <xsl:variable name="spacing" as="xs:double" select="100"/>
    <!-- number of pixels horizontal for X axis -->
    <xsl:variable name="max_width" as="xs:double" select="($spacing) * count($prop-corpus//speech)"/>
    <!--<xsl:variable name="issue" as="xs:string" select="@value='pa'"/>
    This is a placeholder for when I figure out how to change the thing depending on which
            issue the user selects, if not possible then I'll have to change it manually, oh well-->
    <!-- ================================================================ -->
    <!-- Templates                                                        -->
    <!-- ================================================================ -->
    <xsl:template match="/">
        <svg
            viewBox="-50 -{$max_height + 100} {$max_width + 200} {$max_height + 300}">
            <xsl:variable name="bruh" as="xs:double" select="($max_width)div(2)"/>
            <!-- Couldn't use div in the actual text thing lmao -->
            <text x="{$bruh}" y="60" fill="black">Year</text>
            <xsl:variable name="bruhh" as="xs:double" select="(($max_width)div(2))-100"/>
            
            <text x="{$bruhh}" y="-550" fill="black">Number of times *issue* was brought up</text>
            <text x="-300" y="25" transform="rotate(90)" fill="black">Mentions</text>
            <!-- ==================================================== -->
            <!-- Create per-election bubbles and vertical ruling      -->
            <!-- ==================================================== -->
            <xsl:apply-templates select="//speech"/>
            <!-- ==================================================== -->
            <!-- Create horizontal ruling with labels                 -->
            <!-- ==================================================== -->
            <!-- this axis is electoral votes, of which there are 538
                    so we want ruling lines in increments of 100 -->
            
            
            <xsl:for-each select="0 to 5">
                <xsl:variable name="ruling-height" as="xs:double" select=". div 5 * $max_height"/>
                <line x1="0" y1="-{$ruling-height}" x2="{$max_width}" y2="-{$ruling-height}" stroke="black" stroke-width="1"></line>
                <xsl:variable name="val" as="xs:double" select="position()"/>
                <text x="0" y="-{$ruling-height}" fill="black"><xsl:value-of select="$val"/></text>
            </xsl:for-each>
            <!-- Lines that go from left to right-->
            
        </svg>
    </xsl:template>
    
    <xsl:template match="speech">
        <!-- ============================================================ -->
        <!-- Template variables                                           -->
        <!-- ============================================================ -->
        
        
        <xsl:variable name="xpos" as="xs:double" select="(position()-1)*$spacing +($spacing div 2)"/>
        <line x1="{$xpos}" y1="15" x2="{$xpos}" y2="-{$max_height}" stroke="black" stroke-width="1"></line>
        <xsl:variable name="year" as="xs:string" select="metadata"/>
        <text x="{$xpos}" y="15" fill="black"><xsl:value-of select="$year"/></text>
       <!--  Up and down lines-->
        
        <!-- ============================================================ -->
        <!-- Create bubbles                                               -->
        <!-- ============================================================ -->
        <xsl:apply-templates/>
        <!-- ============================================================ -->
        <!-- Create vertical ruling line and label                        -->
        <!-- ============================================================ -->
        
        <!-- SECOND CHALLENGE: IN-CLASS CODE HERE -->
        
    </xsl:template>
    <xsl:template match="policy">
        <!-- ============================================================ -->
        <!-- Process individual candidates                                -->
        <!-- ============================================================ -->
        
        <xsl:variable name="xpos" as="xs:double" select="(count(preceding::speech))*$spacing +($spacing div 2)"/>
        <xsl:variable name="ypos" as="xs:double" select="(count(@value='pa')*100)"/>
       <!--  <xsl:variable name="height" as="xs:double" select="(math:sqrt(@popular_percentage) div math:pi())*10"/>
       <xsl:variable name="color" as="xs:string" select="
            if(@party='Republican') then 'red'
            else if(@party='Democrat') then 'blue'
            else 'green'
            "/>
        <circle cx="{$xpos}" cy="-{$ypos}" r="{$rad}" fill="{$color}" opacity=".5"/>
        <circle cx="{$xpos}" cy="-{$ypos}" r="2.5" fill="black" opacity="1"/>
        <xsl:variable name="yposs" as="xs:double" select="(@electoral_votes)+10"/>
        <text x="{$xpos}" y="-{$yposs}" fill="black"><xsl:value-of select="@popular_percentage"/></text>-->
        <rect x="{$xpos}" y="0" width="300" height="-{$ypos}" fill="black"/>

        <!-- remember to add a conditional fill for each party and change opacity-->
        
        <!-- THIRD CHALLENGE: IN-CLASS CODE HERE (x-pos, y-pos, radius) -->
        
        
        <!-- FOURTH CHALLENGE: IN-CLASS CODE HERE (inner circle, outer circle) -->
        
        
        <!-- FIFT CHALLENGE: IN-CLASS CODE HERE (bubble color if statements) -->
        
        
    </xsl:template>
</xsl:stylesheet>


