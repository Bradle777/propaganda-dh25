<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="urn:functions"
    exclude-result-prefixes="#all"
    version="3.0">
    
    

    <xsl:function name="f:text-length" as="xs:integer">
        <xsl:param name="nodes" as="node()*" />
        <xsl:sequence select="
            sum(
            for $n in $nodes
            return string-length(normalize-space(string($n)))
            )
            " />
    </xsl:function>
    
    
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" doctype-system="about:legacy-compat"/>
        

    <xsl:template match="speech">
        <html>
            <head>
                <title>Speech — <xsl:value-of select="metadata/date"/></title>
                
                <style>
                    .navbar {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    background: #222;
                    padding: 10px;
                    z-index: 1000;
                    }
                    
                    .navbar a {
                    color: white;
                    margin-right: 15px;
                    text-decoration: none;
                    font-weight: bold;
                    }
                    
                    body {
                    padding-top: 60px;
                    }
                   
                   body {
                    margin: 0;
                    font-family: sans-serif;
                    display: grid;
                    grid-template-columns: 20% 65% 15%;
                    height: 100vh;
                    }
                    
                    
                    body::before {
                    content: "";
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background-image: url('https://upload.wikimedia.org/wikipedia/commons/6/6c/Constitution_of_the_United_States%2C_page_1.jpg');
                    background-repeat: no-repeat;
                    background-size: cover;
                    background-attachment: fixed;
                    opacity: 0.35;
                    z-index: -1;
                    }
                    
                    
                    #mainText {
                    background-color: #f5f5f5;
                    padding: 30px;
                    overflow-y: scroll;
                    font-size: 1.15rem;
                    line-height: 1.7;
                    }
                    
                    #statsMenu {
                    padding: 15px;
                    border-right: 1px solid #bbb;
                    overflow-y: auto;
                    }
                    
                    #statsPanel {
                    margin-top: 20px;
                    }
                    
                    
                    
                    #statsPanel {
                    padding: 15px;
                    border-right: 1px solid #bbb;
                    overflow-y: scroll;
                    }
                    #mainText {
                    padding: 30px;
                    overflow-y: scroll;
                    font-size: 1.15rem;
                    line-height: 1.7;
                    }
                    #menuPanel {
                    padding: 15px;
                    border-left: 1px solid #bbb;
                    overflow-y: scroll;
                    }
                    .toggle-btn {
                    cursor: pointer;
                    margin: 5px 0;
                    padding: 4px 8px;
                    border-radius: 6px;
                    display: block;
                    color: white;
                    font-weight: bold;
                    }
                    
                    .highlight-imm { background-color: #ff6b6b; }
                    .highlight-health { background-color: #4dabf7; }
                    .highlight-mil { background-color: #ffd43b; }
                    .highlight-env { background-color: #51cf66; }
                    .highlight-crime { background-color: #845ef7; }
                    .highlight-pa { background-color: #ffa94d; }
                    .highlight-eco { background-color: #63e6be; }
                    .highlight-soc { background-color: #f06595; }
                    
                    .highlight-f { background-color: #ffdddd; }
                    .highlight-d { background-color: #ddffdd; }
                    .highlight-e { background-color: #ddeeff; }
                    .highlight-positive { background-color: #e7ffe7; }
                    .highlight-neutral { background-color: #f0f0f0; }
                    .highlight-negative { background-color: #ffe7e7; }                    
                    .highlight-past { background-color: #f7f1d1; }
                    .highlight-present { background-color: #e1f7d1; }
                    .highlight-future { background-color: #d1e7f7; }
                    
                    
                    .active { outline: 3px solid yellow; }
                </style>
               
                <script>
                    function toggle(attr) {
           
                    document.querySelectorAll('[data-attr*="' + attr + '"]').forEach(el => {
                    el.classList.toggle("active");
                    el.classList.toggle("highlight-" + attr);
                    });
                    
                    
                    const blocks = document.querySelectorAll(".stat-block");
                    blocks.forEach(b => {
                    if (b.dataset.stat === attr) {
                    b.style.display = (b.style.display === "none" || b.style.display === "") 
                    ? "block" 
                    : "none";
                    } else {
                    b.style.display = "none";
                    }
                    });
                    }
                    
                    function toggleStat(attr) {
                    document.querySelectorAll('.stat-block').forEach(b => b.style.display = "none");
                    
                    const block = document.querySelector('.stat-block[data-stat="' + attr + '"]');
                    if (block) {
                    block.style.display = "block";
                    }
                    }
                    
                </script>
                
                
               
            </head>
            
            <body>
                
                <div class="navbar">
                    <a href="homepage.xhtml">Home</a>
                    <a href="methods.xhtml">Methods</a>
                    <a href="state_of_the_unions.xhtml">Texts</a>
                    <a href="analysis.xhtml">Analysis</a>
                    <a href="conclusion.xhtml">Conclusion</a>
                </div>
                

                <div id="statsMenu">
                    <h3>Statistics</h3>
                    
                    
                    <xsl:for-each select="//policy[not(@value = preceding::policy/@value)]">
                        <xsl:sort select="@value"/>
                        <div class="toggle-btn" style="background:#333;" onclick="toggleStat('{@value}')">
                            <xsl:value-of select="@value"/>
                        </div>
                    </xsl:for-each>
                    
                    <div id="statsPanel"></div>
                </div>
                
                    
                 
                    <div class="stat-block" data-stat="eco" style="display:none;">
                        <h3>Economics</h3>
                        <p><b>Occurrences:</b> 67</p>
                        <p><b>Text units:</b> 213.91</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>domestic (64)</li>
                            <li>positive connotation (54)</li>
                            <li>present moment (54)</li>
                        </ul>
                    </div>
                    
              
                    <div class="stat-block" data-stat="health" style="display:none;">
                        <h3>Health</h3>
                        <p><b>Occurrences:</b> 36</p>
                        <p><b>Text units:</b> 106.12</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>domestic (36)</li>
                            <li>present moment (33)</li>
                            <li>positive connotation (32)</li>
                        </ul>
                    </div>
                    
                    
                    <div class="stat-block" data-stat="crime" style="display:none;">
                        <h3>Crime</h3>
                        <p><b>Occurrences:</b> 10</p>
                        <p><b>Text units:</b> 246.27</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>domestic (10)</li>
                            <li>negative connotation (10)</li>
                            <li>present moment (9)</li>
                        </ul>
                    </div>
                    
                   
                    <div class="stat-block" data-stat="env" style="display:none;">
                        <h3>Environment</h3>
                        <p><b>Occurrences:</b> 7</p>
                        <p><b>Text units:</b> 207.82</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>domestic (7)</li>
                            <li>positive connotation (7)</li>
                            <li>future (4)</li>
                        </ul>
                    </div>
                    
                  
                    <div class="stat-block" data-stat="soc" style="display:none;">
                        <h3>Social Issues</h3>
                        <p><b>Occurrences:</b> 12</p>
                        <p><b>Text units:</b> 231.48</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>domestic (12)</li>
                            <li>present moment (10)</li>
                            <li>positive connotation (7)</li>
                        </ul>
                    </div>
                    
                   
                    <div class="stat-block" data-stat="imm" style="display:none;">
                        <h3>Immigration</h3>
                        <p><b>Occurrences:</b> 2</p>
                        <p><b>Text units:</b> 22.58</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>positive connotation (2)</li>
                            <li>present moment (2)</li>
                            <li>domestic (1)</li>
                        </ul>
                    </div>
                    
                    
                    <div class="stat-block" data-stat="mil" style="display:none;">
                        <h3>Military</h3>
                        <p><b>Occurrences:</b> 3</p>
                        <p><b>Text units:</b> 7.58</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>foreign (2)</li>
                            <li>past (2)</li>
                            <li>positive connotation (2)</li>
                        </ul>
                    </div>
                    
                    
                    <div class="stat-block" data-stat="dip" style="display:none;">
                        <h3>Foreign Affairs</h3>
                        <p><b>Occurrences:</b> 8</p>
                        <p><b>Text units:</b> 25.00</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>foreign (8)</li>
                            <li>present moment (8)</li>
                            <li>positive connotation (7)</li>
                        </ul>
                    </div>
                    
                  
                    <div class="stat-block" data-stat="pa" style="display:none;">
                        <h3>Party Agenda</h3>
                        <p><b>Occurrences:</b> 3</p>
                        <p><b>Text units:</b> 8.85</p>
                        <p><b>Co-occurs most with:</b></p>
                        <ul>
                            <li>domestic (3)</li>
                            <li>positive connotation (3)</li>
                            <li>present moment (3)</li>
                        </ul>
                    </div>
                    
                
                
                
                

                <div id="mainText">
                    <h1>State of the Union</h1>
                    <h2><xsl:value-of select="metadata/date"/></h2>
                    
                    <xsl:apply-templates select="body/*"/>
                </div>
                

                <div id="menuPanel">
                    <h3>Attributes</h3>
                    
              
                    <xsl:for-each select="//policy[not(@value = preceding::policy/@value)]">
                        <xsl:sort select="@value"/>
                        <div class="toggle-btn" style="background:#444;" onclick="toggle('{@value}')">
                            <xsl:value-of select="@value"/>
                        </div>
                    </xsl:for-each>
                    
                    
                    
                    
                </div>
                
            </body>
        </html>
    </xsl:template>
    

    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    

    <xsl:template match="policy">
        <span>

            <xsl:attribute name="data-attr">
                <xsl:value-of select="@value"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@type"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@when"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@connotation"/>
                <xsl:if test="@anthro">
                    <xsl:text> </xsl:text><xsl:value-of select="@anthro"/>
                </xsl:if>
            </xsl:attribute>
            
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    

    <xsl:template match="audience">
        <span>
            <xsl:attribute name="data-attr">
                <xsl:value-of select="@noise"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="ref">
        <span data-attr="ref">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>
