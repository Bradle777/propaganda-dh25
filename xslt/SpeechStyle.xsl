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
                    const active = {};

                    function toggle(attr) {
                        active[attr] = !active[attr];

                        document.querySelectorAll('[data-attr*="' + attr + '"]').forEach(el => {
                            el.classList.toggle('active', active[attr]);
                            el.classList.toggle('highlight-' + attr, active[attr]);
                        });

                        updateStats();
                    }

                    function updateStats() {
                        const statsDiv = document.getElementById("statsPanel");
                        statsDiv.innerHTML = "";

                        Object.keys(active).forEach(attr => {
                            if (active[attr]) {
                                const els = [...document.querySelectorAll('[data-attr*="' + attr + '"]')];
                                const count = els.length;
                                let totalChars = 0;
                                els.forEach(e => {
                                totalChars += e.textContent.length;
                                });
                                const textUnits = (totalChars / 100).toFixed(2);
                                

                                const co = {};
                                els.forEach(e => {
                                    const attrs = e.dataset.attr.split(" ");
                                    attrs.forEach(a => {
                                        if (a !== attr) {
                                            co[a] = (co[a] || 0) + 1;
                                        }
                                    });
                                });

                                let coHTML = "";
                                Object.entries(co)
                                      .sort((a,b) => b[1]-a[1])
                                      .slice(0,5)
                                      .forEach(([a,c]) => {
                                          coHTML += a + ": " + c + "<br/>";
                                      });

                                    statsDiv.innerHTML += 
                                        "<h3>" + attr + "</h3>" +
                                        "<p><b>Occurrences:</b> " + count + "</p>" +
                                        "<p><b>Co-occurs most with:</b><br/>" + (coHTML || "None") + "</p>" +
                                        "<hr/>";
                    
                            }
                        });
                    }
              </script>
            </head>
            
            <body>
                

                <div id="statsPanel">
                    Click attribute buttons to see statistics.
                </div>
                

                <div id="mainText">
                    <h1>State of the Union</h1>
                    <h2><xsl:value-of select="metadata/date"/></h2>
                    
                    <xsl:apply-templates select="body/*"/>
                </div>
                

                <div id="menuPanel">
                    <h3>Attributes</h3>
                    
              
                    <xsl:for-each select="//policy/@value">
                        <xsl:sort/>
                        <xsl:if test="not(. = preceding::policy/@value)">
                            <div class="toggle-btn">
                                <xsl:attribute name="style">background:#444;</xsl:attribute>
                                <xsl:attribute name="onclick">toggle('<xsl:value-of select="."/>')</xsl:attribute>
                                <xsl:value-of select="."/>
                            </div>
                        </xsl:if>
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
