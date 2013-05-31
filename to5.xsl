<?xml version='1.0'?>
<!DOCTYPE doc SYSTEM "../../../lib/xml/xsl.dtd" >
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:x="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="x">
 <xsl:template match="x:meta[@name='Content-Type']">
  <meta charset="utf-8"/>
 </xsl:template>
 
 <xsl:template match="x:div[@class='section' or @class='figure' or @class='figcaption']">
  <xsl:element name="{@class}" namespace="http://www.w3.org/1999/xhtml"><xsl:apply-templates select="node()|@*[local-name()!='class']"/></xsl:element>
 </xsl:template>
 
 <xsl:template match="x:div[starts-with(@class,'section ')]">
  <section class="{substring(@class,9)}"><xsl:apply-templates select="node()|@*[local-name()!='class']"/></section>
 </xsl:template>

 <xsl:template match="node()">
  <xsl:copy>
   <xsl:apply-templates select="node()|@*"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="@*">
  <xsl:copy/>
 </xsl:template>
</xsl:stylesheet>
