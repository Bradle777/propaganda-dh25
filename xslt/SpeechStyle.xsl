<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="urn:functions"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
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
    
    <xsl:function name="f:label" as="xs:string">
        <xsl:param name="code" as="xs:string"/>
        
        <xsl:choose>
            <xsl:when test="$code='eco'">Economics</xsl:when>
            <xsl:when test="$code='crime'">Crime</xsl:when>
            <xsl:when test="$code='dip'">Foreign Affairs</xsl:when>
            <xsl:when test="$code='env'">Environment</xsl:when>
            <xsl:when test="$code='health'">Health</xsl:when>
            <xsl:when test="$code='imm'">Immigration</xsl:when>
            <xsl:when test="$code='mil'">Military</xsl:when>
            <xsl:when test="$code='pa'">Party Agenda</xsl:when>
            <xsl:when test="$code='soc'">Social Issues</xsl:when>
            <xsl:when test="$code='ref'">Reference</xsl:when>
            
            
            <xsl:when test="$code='d'">Domestic</xsl:when>
            <xsl:when test="$code='f'">Foreign</xsl:when>
            
            <xsl:otherwise>
                <xsl:value-of select="$code"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    
    
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" doctype-system="about:legacy-compat"/>
        

    <xsl:template match="speech">
        <html>
            <head>
                <title>Speech — <xsl:value-of select="metadata/date"/></title>
                
                <style>
                    .navbar {
                    list-style-type: none;
                    padding: 0px;
                    margin: 10px 10px 20px 0px;
                    overflow: hidden;
                    background-color: black;
                    width: 100%;
                    text-align: center;
                    
                    
                    position: relative;
                    z-index: 10;
                    }
                    
                    .navbar a {
                    padding: 0px;
                    float: left;
                    display: block;
                    color: white;
                    text-align: center;
                    padding: 15px 102px;
                    text-decoration: none;
                    font-family: "Arial";
                    }
                    
                    #layoutGrid {
                    display: grid;
                    grid-template-columns: 20% 65% 15%;
                    height: calc(100vh);
                    overflow: hidden;
                    }
                    
                   
                   body {
                   margin: 0;
                   font-family: sans-serif;
                   padding-top: 0;
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
                    opacity: 0.5;
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
                    
                    #statsMenu { grid-column: 1; }
                    #mainText { grid-column: 2; }
                    #menuPanel { grid-column: 3; }
                    
                    
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
                    
                    #menuPanel .toggle-btn.active {
                    outline: 2px solid white;
                    filter: brightness(200%);
                    }
                    
                    .toggle-btn.stat-active {
                    outline: 2px solid white;
                    filter: brightness(200%);
                    }
                    
                    
                    .block-highlight-eco    { background-color: rgba(99, 230, 190, 0.25); }
                    .block-highlight-health { background-color: rgba(77, 171, 247, 0.25); }
                    .block-highlight-crime  { background-color: rgba(132, 94, 247, 0.25); }
                    .block-highlight-env    { background-color: rgba(81, 207, 102, 0.25); }
                    .block-highlight-pa     { background-color: rgba(255, 169, 77, 0.25); }
                    .block-highlight-soc    { background-color: rgba(240, 101, 149, 0.25); }
                    .block-highlight-mil    { background-color: rgba(255, 212, 59, 0.25); }
                    .block-highlight-imm    { background-color: rgba(255, 107, 107, 0.25); }
                    .block-highlight-dip    { background-color: rgba(255, 255, 0, 0.25); }
                    .block-highlight-ref { background-color: rgba(180, 180, 180, 0.35); }
                    
                    
                    .highlight-f { background-color: #ffdddd; }
                    .highlight-d { background-color: #ddffdd; }
                    .highlight-e { background-color: #ddeeff; }
                    .highlight-positive { background-color: green; }
                    .highlight-neutral { background-color: gray; }
                    .highlight-negative { background-color: red; }                    
                    .highlight-past { background-color: #f7f1d1; }
                    .highlight-present { background-color: #e1f7d1; }
                    .highlight-future { background-color: #d1e7f7; }
                    
                    .attr-category {
                    margin-bottom: 20px;
                    padding-bottom: 10px;
                    border-bottom: 1px solid #999;
                    }
                    
                    .check-row {
                    display: block;
                    margin: 6px 0;
                    }
                    
                    .reset-btn {
                    margin-top: 20px;
                    padding: 6px 10px;
                    border-radius: 6px;
                    font-weight: bold;
                    cursor: pointer;
                    }
                    
                    .speech-block {
                    display: block;
                    width: 100%;
                    }
                    
                    .speech-block {
                    padding: 0;
                    margin: 0;
                    border-radius: 4px;
                    }
                    
                    [class*="block-highlight-"] {
                    display: block;
                    width: 100%;
                    padding: 0;
                    border-radius: 4px;
                    }
                    
                    
                </style>
               
                <script>
                    function toggle(attr) {
                    
                    
                    const btn = document.querySelector(`#menuPanel .toggle-btn[onclick="toggle('${attr}')"]`);
                    if (btn) btn.classList.toggle("active");
                    
                    
                    document.querySelectorAll('[data-attr*="' + attr + '"]').forEach(el => {
                    el.classList.toggle("active");
                    el.classList.toggle("highlight-" + attr);
                    });
                    }
                    
                    
                    function toggleStat(attr) {
                    
                    
                    document.querySelectorAll('#statsMenu .toggle-btn')
                    .forEach(btn => btn.classList.remove("stat-active"));
                    
                    
                    let activeBtn = document.querySelector(`#statsMenu .toggle-btn[onclick="toggleStat('${attr}')"]`);
                    if (activeBtn) activeBtn.classList.add("stat-active");
                    
                    
                    document.querySelectorAll('.stat-block').forEach(b => b.style.display = "none");
                    
                    
                    const block = document.querySelector('.stat-block[data-stat="' + attr + '"]');
                    if (block) block.style.display = "block";
                    }
                    
                    function resetAll() {
                    
                    
                    document.querySelectorAll('#menuPanel input[type="checkbox"]').forEach(b => {
                    b.checked = false;
                    });
                    
                    
                    document.querySelectorAll('[data-attr]').forEach(el => {
                    el.classList.remove('active');
                    
                    
                    [...el.classList].forEach(cls => {
                    if (cls.startsWith("highlight-")) {
                    el.classList.remove(cls);
                    }
                    });
                    
                    let parentP = el.closest(".speech-block");
                    if (parentP) {
                    [...parentP.classList].forEach(c => {
                    if (c.startsWith("block-highlight-")) {
                    parentP.classList.remove(c);
                    }
                    });
                    }
                    
                    
                    });
                    }
                    
                    
                    function checkFilter() {
                    
                    document.querySelectorAll('.speech-block').forEach(p => {
                    [...p.classList].forEach(c => {
                    if (c.startsWith("block-highlight-")) {
                    p.classList.remove(c);
                    }
                    });
                    });
                    
                    
                    
                    const selections = { value: [], connotation: [], when: [], identity: [] };
                    
                    document.querySelectorAll('#menuPanel input[type="checkbox"]:checked')
                    .forEach(box => {
                    const cat = box.dataset.cat;
                    selections[cat].push(box.value);
                    });
                    
                    const majorCats = ["eco", "health", "crime", "env", "pa", "soc", "mil", "imm", "dip", "ref"];
                    
                    document.querySelectorAll('[data-attr]').forEach(el => {
                    
                    const data = el.dataset.attr;
                    let show = true;
                    
                    for (let cat in selections) {
                    if (selections[cat].length > 0) {
                    let pass = false;
                    selections[cat].forEach(val => {
                    if ((" " + data + " ").includes(" " + val + " ")) pass = true;
                    });
                    if (!pass) show = false;
                    }
                    }
                    
                    
                    if (show) {
                    el.classList.add('active');
                    
                  
                    [...el.classList].forEach(cls => {
                    if (cls.startsWith("highlight-")) el.classList.remove(cls);
                    });
                    
                    
                    el.dataset.attr.split(" ").forEach(val => {
                    el.classList.add("highlight-" + val);
                    });
                    
                    
                    let parentP = el.closest(".speech-block");
                    if (parentP) {
                    const policySelections = selections.value;
                    if (policySelections.length > 0) {
                    majorCats.forEach(cat => {
                    if ((" " + data + " ").includes(" " + cat + " ")) {
                    parentP.classList.add("block-highlight-" + cat);
                    }
                    });
                    }
                    }
                    }
                    
                  
                    else {
                    el.classList.remove('active');
                    
                    [...el.classList].forEach(cls => {
                    if (cls.startsWith("highlight-")) el.classList.remove(cls);
                    });
                    
                   
                    let parentP = el.closest(".speech-block");
                    if (parentP) {
                    [...parentP.classList].forEach(c => {
                    if (c.startsWith("block-highlight-")) {
                    parentP.classList.remove(c);
                    }
                    });
                    }
                    }
                    
                    }); 
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
                
           <div id="layoutGrid">
                    

                <div id="statsMenu">
                    <h3>Statistics</h3>
                    
                    
                    <xsl:for-each select="//policy[not(@value = preceding::policy/@value)]">
                        <xsl:sort select="@value"/>
                        <div class="toggle-btn" style="background:#333;" onclick="toggleStat('{@value}')">
                            <xsl:value-of select="f:label(@value)"/>
                        </div>
                    </xsl:for-each>
                    
                    <div id="statsPanel">
                
                    
                 
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
                    </div>
                </div>
                
                
                
                

                <div id="mainText">
                    <h1>State of the Union</h1>
                    <h2><xsl:value-of select="metadata/date"/></h2>
                    
                    <xsl:apply-templates select="body/*"/>
                </div>
                

                <div id="menuPanel">
                    <h3>Attributes</h3>
                    

                    
                    
                    <div class="attr-category">
                        <p><b>Policy Area</b></p>
                        <xsl:for-each select="//policy[not(@value = preceding::policy/@value)]">
                            <xsl:sort select="@value"/>
                            <label class="check-row">
                                <input type="checkbox" onclick="checkFilter()" value="{@value}" data-cat="value"/>
                                <xsl:value-of select="f:label(@value)"/>
                            </label>
                        </xsl:for-each>
                        <label class="check-row">
                            <input type="checkbox" onclick="checkFilter()" value="ref" data-cat="value"/>
                            Reference
                        </label>
                        
                    </div>
                    
                    <div class="attr-category">
                        <p><b>Identity</b></p>
                        
                        <label class="check-row">
                            <input type="checkbox" onclick="checkFilter()" value="d" data-cat="identity"/>
                            Domestic
                        </label>
                        
                        <label class="check-row">
                            <input type="checkbox" onclick="checkFilter()" value="f" data-cat="identity"/>
                            Foreign
                        </label>
                    </div>
                    
                    
                    <div class="attr-category">
                        <p><b>Connotation</b></p>
                        <xsl:for-each select="//policy[not(@connotation = preceding::policy/@connotation)]">
                            <xsl:sort select="@connotation"/>
                            <label class="check-row">
                                <input type="checkbox" onclick="checkFilter()" value="{@connotation}" data-cat="connotation"/>
                                <xsl:value-of select="@connotation"/>
                            </label>
                        </xsl:for-each>
                    </div>
                    
                    
                    <div class="attr-category">
                        <p><b>Time Frame</b></p>
                        <xsl:for-each select="//policy[not(@when = preceding::policy/@when)]">
                            <xsl:sort select="@when"/>
                            <label class="check-row">
                                <input type="checkbox" onclick="checkFilter()" value="{@when}" data-cat="when"/>
                                <xsl:value-of select="@when"/>
                            </label>
                        </xsl:for-each>
                    </div>
                    
                   
                    <button class="reset-btn" onclick="resetAll()">Reset</button>
                    
                    
                </div>   
                    
                    
                </div>
                
            </body>
        </html>
    </xsl:template>
    

    <xsl:template match="p">
        <p class="speech-block">
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
        <span class="speech-block" data-attr="ref">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>
