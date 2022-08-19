<?xml version="1.0" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:hl7="urn:hl7-org:v3" version="1.0"><!--Implementers: please note that overriding process-prolog or process-root is 
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
<axsl:template match="/"><axsl:apply-templates select="/" mode="M1"/><axsl:apply-templates select="/" mode="M2"/><axsl:apply-templates select="/" mode="M3"/><axsl:apply-templates select="/" mode="M4"/><axsl:apply-templates select="/" mode="M5"/><axsl:apply-templates select="/" mode="M6"/><axsl:apply-templates select="/" mode="M7"/></axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN checkQuery-->


	<!--RULE -->
<axsl:template match="hl7:QUPC_IN160101UK05/hl7:ControlActEvent[1]/hl7:query[1]" priority="1000" mode="M1">

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(hl7:dissentOverride/hl7:value[@codeSystem='2.16.840.1.113883.2.1.3.2.4.17.60']/@code)&gt;0"/><axsl:otherwise>***fault|ErrorBase1733.MANDATORY_FIELD_MISSING[checkQuery.missingDissentOverride]***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(hl7:nHSNumber/hl7:value[@root='2.16.840.1.113883.2.1.4.1']/@extension)=1"/><axsl:otherwise>***fault|ErrorBase1733.MANDATORY_FIELD_MISSING[checkQuery.missingNhsNumber]***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M1"/></axsl:template><axsl:template match="text()" priority="-1" mode="M1"/><axsl:template match="@*|node()" priority="-2" mode="M1"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M1"/></axsl:template>

<!--PATTERN checkFilterParameters-->


	<!--RULE -->
<axsl:template match="hl7:QUPC_IN160101UK05/hl7:ControlActEvent[1]/hl7:query[1]/hl7:filterParameters" priority="1000" mode="M2"><axsl:variable name="hasSetId" select="count(hl7:setID)=1"/><axsl:variable name="hasDocumentType" select="count(hl7:documentType)=1"/><axsl:variable name="hasDate" select="count(hl7:date)=1"/><axsl:variable name="hasNoChildren" select="count(hl7:*)=0"/><axsl:variable name="hasSetIdAndNotDocTypeOrDate" select="$hasSetId and not($hasDocumentType or $hasDate)"/><axsl:variable name="hasDocTypeOrDateAndNotSetId" select="($hasDocumentType or $hasDate) and not($hasSetId)"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="$hasSetIdAndNotDocTypeOrDate or $hasDocTypeOrDateAndNotSetId or $hasNoChildren"/><axsl:otherwise>***fault|ErrorBase1733.SET_ID_NOT_ALLOWED_WITH_OTHER_PARAMS[checkFilterParameters.invalidCombination]***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/></axsl:template><axsl:template match="text()" priority="-1" mode="M2"/><axsl:template match="@*|node()" priority="-2" mode="M2"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/></axsl:template>

<!--PATTERN checkQuerySetID-->


	<!--RULE -->
<axsl:template match="hl7:QUPC_IN160101UK05/hl7:ControlActEvent[1]/hl7:query[1]/hl7:filterParameters/hl7:setID" priority="1000" mode="M3">

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(hl7:value/@root)&gt;0"/><axsl:otherwise>***fault|ErrorBase1733.MANDATORY_FILTER_PARAMETER_MISSING[checkQuerySetID.missingSetID]***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/></axsl:template><axsl:template match="text()" priority="-1" mode="M3"/><axsl:template match="@*|node()" priority="-2" mode="M3"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/></axsl:template>

<!--PATTERN checkQueryDocumentType-->


	<!--RULE -->
<axsl:template match="hl7:QUPC_IN160101UK05/hl7:ControlActEvent[1]/hl7:query[1]/hl7:filterParameters/hl7:documentType" priority="1000" mode="M4">

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(hl7:value/@code)&gt;0"/><axsl:otherwise>***fault|ErrorBase1733.MANDATORY_FILTER_PARAMETER_MISSING[checkQueryDocumentType.missingDocumentTypeCode]***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(hl7:value/@codeSystem)&gt;0"/><axsl:otherwise>***fault|ErrorBase1733.MANDATORY_FILTER_PARAMETER_MISSING[checkQueryDocumentType.missingDocumentTypeCodeSystem]***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/></axsl:template><axsl:template match="text()" priority="-1" mode="M4"/><axsl:template match="@*|node()" priority="-2" mode="M4"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/></axsl:template>

<!--PATTERN checkQueryDocumentDate-->


	<!--RULE -->
<axsl:template match="hl7:QUPC_IN160101UK05/hl7:ControlActEvent[1]/hl7:query[1]/hl7:filterParameters/hl7:date" priority="1000" mode="M5">

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(hl7:value/hl7:low/@value)&gt;0"/><axsl:otherwise>***fault|ErrorBase1733.MANDATORY_FILTER_PARAMETER_MISSING[checkQueryDocumentDate.missingLow]***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(hl7:value/hl7:high/@value)&gt;0"/><axsl:otherwise>***fault|ErrorBase1733.MANDATORY_FILTER_PARAMETER_MISSING[checkQueryDocumentDate.missingHigh]***<axsl:value-of select="string('&#10;')"/></axsl:otherwise></axsl:choose><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></axsl:template><axsl:template match="text()" priority="-1" mode="M5"/><axsl:template match="@*|node()" priority="-2" mode="M5"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></axsl:template>

<!--PATTERN reportQuery-->


	<!--RULE -->
<axsl:template match="hl7:QUPC_IN160101UK05/hl7:ControlActEvent[1]/hl7:query[1]" priority="1000" mode="M6">

		<!--REPORT -->
<axsl:if test="true()">***report|dissentOverrideCode|<axsl:text/><axsl:value-of select="hl7:dissentOverride/hl7:value/@code"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="true()">***report|nhsNumber|<axsl:text/><axsl:value-of select="hl7:nHSNumber/hl7:value/@extension"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></axsl:template><axsl:template match="text()" priority="-1" mode="M6"/><axsl:template match="@*|node()" priority="-2" mode="M6"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></axsl:template>

<!--PATTERN reportFilterParameters-->


	<!--RULE -->
<axsl:template match="hl7:QUPC_IN160101UK05/hl7:ControlActEvent[1]/hl7:query[1]/hl7:filterParameters" priority="1000" mode="M7">

		<!--REPORT -->
<axsl:if test="count(hl7:setID)=1">***report|setID|<axsl:text/><axsl:value-of select="hl7:setID/hl7:value/@root"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="count(hl7:documentType)=1">***report|documentType/code|<axsl:text/><axsl:value-of select="hl7:documentType/hl7:value/@code"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="count(hl7:documentType)=1">***report|documentType/codeSystem|<axsl:text/><axsl:value-of select="hl7:documentType/hl7:value/@codeSystem"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="count(hl7:date)=1">***report|date/low|<axsl:text/><axsl:value-of select="hl7:date/hl7:value/hl7:low/@value"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if>

		<!--REPORT -->
<axsl:if test="count(hl7:date)=1">***report|date/high|<axsl:text/><axsl:value-of select="hl7:date/hl7:value/hl7:high/@value"/><axsl:text/>***<axsl:value-of select="string('&#10;')"/></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></axsl:template><axsl:template match="text()" priority="-1" mode="M7"/><axsl:template match="@*|node()" priority="-2" mode="M7"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></axsl:template></axsl:stylesheet>
