<?xml version="1.0" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/" xmlns:hl7="urn:hl7-org:v3" version="1.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<axsl:param name="archiveDirParameter"/><axsl:param name="archiveNameParameter"/><axsl:param name="fileNameParameter"/><axsl:param name="fileDirParameter"/>

<!--PHASES-->


<!--PROLOG-->


<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template match="*" mode="schematron-select-full-path"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template match="*" mode="schematron-get-full-path"><axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><axsl:text>/</axsl:text><axsl:choose><axsl:when test="namespace-uri()=''"><axsl:value-of select="name()"/><axsl:variable name="p_1" select="1+    count(preceding-sibling::*[name()=name(current())])"/><axsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p_1"/>]</axsl:if></axsl:when><axsl:otherwise><axsl:text>*[local-name()='</axsl:text><axsl:value-of select="local-name()"/><axsl:text>' and namespace-uri()='</axsl:text><axsl:value-of select="namespace-uri()"/><axsl:text>']</axsl:text><axsl:variable name="p_2" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/><axsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of select="$p_2"/>]</axsl:if></axsl:otherwise></axsl:choose></axsl:template><axsl:template match="@*" mode="schematron-get-full-path"><axsl:text>/</axsl:text><axsl:choose><axsl:when test="namespace-uri()=''">@<axsl:value-of select="name()"/></axsl:when><axsl:otherwise><axsl:text>@*[local-name()='</axsl:text><axsl:value-of select="local-name()"/><axsl:text>' and namespace-uri()='</axsl:text><axsl:value-of select="namespace-uri()"/><axsl:text>']</axsl:text></axsl:otherwise></axsl:choose></axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<axsl:template match="node() | @*" mode="schematron-get-full-path-2"><axsl:for-each select="ancestor-or-self::*"><axsl:text>/</axsl:text><axsl:value-of select="name(.)"/><axsl:if test="preceding-sibling::*[name(.)=name(current())]"><axsl:text>[</axsl:text><axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><axsl:text>]</axsl:text></axsl:if></axsl:for-each><axsl:if test="not(self::*)"><axsl:text/>/@<axsl:value-of select="name(.)"/></axsl:if></axsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<axsl:template match="/" mode="generate-id-from-path"/><axsl:template match="text()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/></axsl:template><axsl:template match="comment()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/></axsl:template><axsl:template match="processing-instruction()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/></axsl:template><axsl:template match="@*" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.@', name())"/></axsl:template><axsl:template match="*" mode="generate-id-from-path" priority="-0.5"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:text>.</axsl:text><axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/></axsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<axsl:template match="node() | @*" mode="schematron-get-full-path-3"><axsl:for-each select="ancestor-or-self::*"><axsl:text>/</axsl:text><axsl:value-of select="name(.)"/><axsl:if test="parent::*"><axsl:text>[</axsl:text><axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><axsl:text>]</axsl:text></axsl:if></axsl:for-each><axsl:if test="not(self::*)"><axsl:text/>/@<axsl:value-of select="name(.)"/></axsl:if></axsl:template>

<!--MODE: GENERATE-ID-2 -->
<axsl:template match="/" mode="generate-id-2">U</axsl:template><axsl:template match="*" mode="generate-id-2" priority="2"><axsl:text>U</axsl:text><axsl:number level="multiple" count="*"/></axsl:template><axsl:template match="node()" mode="generate-id-2"><axsl:text>U.</axsl:text><axsl:number level="multiple" count="*"/><axsl:text>n</axsl:text><axsl:number count="node()"/></axsl:template><axsl:template match="@*" mode="generate-id-2"><axsl:text>U.</axsl:text><axsl:number level="multiple" count="*"/><axsl:text>_</axsl:text><axsl:value-of select="string-length(local-name(.))"/><axsl:text>_</axsl:text><axsl:value-of select="translate(name(),':','.')"/></axsl:template><!--Strip characters--><axsl:template match="text()" priority="-1"/>

<!--SCHEMA METADATA-->
<axsl:template match="/"><axsl:apply-templates select="/" mode="M2"/><axsl:apply-templates select="/" mode="M3"/><axsl:apply-templates select="/" mode="M4"/><axsl:apply-templates select="/" mode="M5"/><axsl:apply-templates select="/" mode="M6"/><axsl:apply-templates select="/" mode="M7"/><axsl:apply-templates select="/" mode="M8"/><axsl:apply-templates select="/" mode="M9"/></axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN TransmissionWrapperChecks-->


	<!--RULE -->
<axsl:template match="/*[1]" priority="1000" mode="M2">

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:id)=1 and string-length(hl7:id/@root)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.INVALID_ID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:creationTime)=1 and string-length(hl7:creationTime/@value)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.INVALID_CREATION_TIME***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:versionCode)=1 and string-length(hl7:versionCode/@code)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.INVALID_VERSION_CODE***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:interactionId[@root='2.16.840.1.113883.2.1.3.2.4.12']/@extension)=1 and hl7:interactionId[@root='2.16.840.1.113883.2.1.3.2.4.12']/@extension=local-name()"/><axsl:otherwise>***fault|ErrorBase1732.INCONSISTENT_HL7_INTERACTION_ID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:communicationFunctionRcv/hl7:device/hl7:id[@root='1.2.826.0.1285.0.2.0.107'])=1 and string-length(hl7:communicationFunctionRcv/hl7:device/hl7:id[@root = '1.2.826.0.1285.0.2.0.107']/@extension) &gt; 0"/><axsl:otherwise>***fault|ErrorBase1732.INVALID_COMM_FUNC_RCV***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:communicationFunctionSnd/hl7:device/hl7:id[@root='1.2.826.0.1285.0.2.0.107'])=1 and string-length(hl7:communicationFunctionSnd/hl7:device/hl7:id[@root = '1.2.826.0.1285.0.2.0.107']/@extension) &gt; 0"/><axsl:otherwise>***fault|ErrorBase1732.INVALID_COMM_FUNC_SND***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:ControlActEvent)=1"/><axsl:otherwise>***fault|ErrorBase1732.INVALID_CONTROL_ACT***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="true()">***report|interactionID|<axsl:text/><axsl:value-of select="hl7:interactionId[@root='2.16.840.1.113883.2.1.3.2.4.12']/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|messageVersion|<axsl:text/><axsl:value-of select="hl7:versionCode/@code"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|messageID|<axsl:text/><axsl:value-of select="hl7:id/@root"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|toASID|<axsl:text/><axsl:value-of select="hl7:communicationFunctionRcv/hl7:device/hl7:id[@root='1.2.826.0.1285.0.2.0.107']/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|fromASID|<axsl:text/><axsl:value-of select="hl7:communicationFunctionSnd/hl7:device/hl7:id[@root='1.2.826.0.1285.0.2.0.107']/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/></axsl:template><axsl:template match="text()" priority="-1" mode="M2"/><axsl:template match="@*|node()" priority="-2" mode="M2"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/></axsl:template>

<!--PATTERN ControlActChecks-->


	<!--RULE -->
<axsl:template match="/*[1]/hl7:ControlActEvent[1]" priority="1000" mode="M3">

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:author)=0 or count(hl7:author)=1"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_AUTHOR_INVALID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:author1)=1 or count(hl7:author1)=2"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_AUTHOR_INVALID_CARDINALITY***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:author1[1]/hl7:AgentSystemSDS[1]/hl7:agentSystemSDS[1])=1"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_AUTHOR_AGENT_INVALID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/></axsl:template><axsl:template match="text()" priority="-1" mode="M3"/><axsl:template match="@*|node()" priority="-2" mode="M3"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/></axsl:template>

<!--PATTERN AuthorCheck-Person-->


	<!--RULE -->
<axsl:template match="/*[1]/hl7:ControlActEvent[1]/hl7:author" priority="1000" mode="M4">

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:AgentPersonSDS/hl7:id[@root='1.2.826.0.1285.0.2.0.67'])=1 and string-length(hl7:AgentPersonSDS/hl7:id[@root='1.2.826.0.1285.0.2.0.67']/@extension)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_AUTHOR_INVALID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id[@root='1.2.826.0.1285.0.2.0.65'])=1 and string-length(hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id[@root='1.2.826.0.1285.0.2.0.65']/@extension)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_AUTHOR_INVALID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:AgentPersonSDS/hl7:part/hl7:partSDSRole/hl7:id[@root='1.2.826.0.1285.0.2.1.104'])=1 and string-length(hl7:AgentPersonSDS/hl7:part/hl7:partSDSRole/hl7:id[@root='1.2.826.0.1285.0.2.1.104']/@extension)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_AUTHOR_INVALID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="true()">***report|agentPersonSDSRole|<axsl:text/><axsl:value-of select="hl7:AgentPersonSDS/hl7:id[@root='1.2.826.0.1285.0.2.0.67']/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|agentPersonSDSPerson|<axsl:text/><axsl:value-of select="hl7:AgentPersonSDS/hl7:agentPersonSDS/hl7:id[@root='1.2.826.0.1285.0.2.0.65']/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|agentPersonSDSTargetRole|<axsl:text/><axsl:value-of select="hl7:AgentPersonSDS/hl7:part/hl7:partSDSRole/hl7:id[@root='1.2.826.0.1285.0.2.1.104']/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|agentPersonSDSCodeSystem|<axsl:text/><axsl:value-of select="hl7:AgentPersonSDS/hl7:id/@root"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/></axsl:template><axsl:template match="text()" priority="-1" mode="M4"/><axsl:template match="@*|node()" priority="-2" mode="M4"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/></axsl:template>

<!--PATTERN AuthorCheck-System1-->


	<!--RULE -->
<axsl:template match="/*[1]/hl7:ControlActEvent[1]/hl7:author1[1]/hl7:AgentSystemSDS/hl7:agentSystemSDS" priority="1000" mode="M5">

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:id[@root='1.2.826.0.1285.0.2.0.107'])=1 and string-length(hl7:id[@root='1.2.826.0.1285.0.2.0.107']/@extension)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_AUTHOR_AGENT_INVALID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="true()">***report|agentSystemSDS1|<axsl:text/><axsl:value-of select="hl7:id[@root='1.2.826.0.1285.0.2.0.107']/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|agentSystemSDS1CodeSystem|<axsl:text/><axsl:value-of select="hl7:id/@root"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></axsl:template><axsl:template match="text()" priority="-1" mode="M5"/><axsl:template match="@*|node()" priority="-2" mode="M5"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></axsl:template>

<!--PATTERN AuthorCheck-System2-->


	<!--RULE -->
<axsl:template match="/*[1]/hl7:ControlActEvent[1]/hl7:author1[2]/hl7:AgentSystemSDS/hl7:agentSystemSDS" priority="1000" mode="M6">

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:id)=1 and string-length(hl7:id/@root)&gt;0 and string-length(hl7:id/@extension)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_AUTHOR_AGENT2_INVALID***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="true()">***report|agentSystemSDS2|<axsl:text/><axsl:value-of select="hl7:id[@root='1.2.826.0.1285.0.2.0.107']/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></axsl:template><axsl:template match="text()" priority="-1" mode="M6"/><axsl:template match="@*|node()" priority="-2" mode="M6"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></axsl:template>

<!--PATTERN BodyExists-->


	<!--RULE -->
<axsl:template match="/*[1]/hl7:ControlActEvent[1]" priority="1000" mode="M7">

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:query)=1 or count(hl7:subject)=1"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_MANDATORY_ELEMENT_MISSING***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:query)=1 or count(hl7:subject/hl7:*)&gt;0"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_MANDATORY_ELEMENT_MISSING***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></axsl:template><axsl:template match="text()" priority="-1" mode="M7"/><axsl:template match="@*|node()" priority="-2" mode="M7"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></axsl:template>

<!--PATTERN checkClientVersion-->


	<!--RULE -->
<axsl:template match="/*/hl7:ControlActEvent" priority="1000" mode="M8">

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:clientVersion)=1"/><axsl:otherwise>***fault|ErrorBase1732.CONTROL_ACT_MANDATORY_ELEMENT_MISSING***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/></axsl:template><axsl:template match="text()" priority="-1" mode="M8"/><axsl:template match="@*|node()" priority="-2" mode="M8"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/></axsl:template>

<!--PATTERN extractFileJson-->


	<!--RULE -->
<axsl:template match="/*/hl7:ControlActEvent" priority="1000" mode="M9">

		<!--REPORT -->
<axsl:if test="true()">***report|querySize|<axsl:text/><axsl:value-of select="hl7:querySize"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|fileJson|<axsl:text/><axsl:value-of select="hl7:query"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|orgId|<axsl:text/><axsl:value-of select="hl7:orgId"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|fileName|<axsl:text/><axsl:value-of select="hl7:fileName"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|clientVersion|<axsl:text/><axsl:value-of select="hl7:clientVersion"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/></axsl:template><axsl:template match="text()" priority="-1" mode="M9"/><axsl:template match="@*|node()" priority="-2" mode="M9"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/></axsl:template></axsl:stylesheet>
