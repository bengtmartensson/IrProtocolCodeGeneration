<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
    xmlns:exportformats="http://www.harctoolbox.org/exportformats"
    xmlns:harctoolbox="http://www.harctoolbox.org"
    version="2.0">
    <!-- Note: this file is XSLT 2.0, the generated file is XSLT 1.0 -->

    <xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:function name="harctoolbox:canonical-name">
        <xsl:param name="str"/>
        <xsl:value-of select="replace(lower-case($str), '[^_0-9A-Za-z-]', '-')"/>
    </xsl:function>

    <!-- default template for elements is to just ignore -->
    <xsl:template match="*"/>

    <xsl:template match="/">
        <xsl:comment>
            This file has been automatically generated by IrpTransmogrifier,
            using its protocol data base, and the transformation file lirc.xsl.

            Command- and remote names are required just to consist of
            non-whitespace characters. We therefore use translate(*, ' ', '_')
            instead of something more elaborate.

            Generating program: <xsl:value-of select="/NamedProtocols/@program-version"/>
            IRP database version: <xsl:value-of select="/NamedProtocols/@version"/>
            <xsl:text>
</xsl:text>
</xsl:comment>
        <exportformats:exportformat>
            <xsl:attribute name="name">Lirc</xsl:attribute>
            <xsl:attribute name="extension">lircd.conf</xsl:attribute>
            <xsl:attribute name="multiSignal">true</xsl:attribute>
            <xsl:attribute name="simpleSequence">false</xsl:attribute>
            <xsl:attribute name="metadata">true</xsl:attribute>
            <xsl:attribute name="xsi:schemaLocation" namespace="http://www.w3.org/2001/XMLSchema-instance">http://www.harctoolbox.org/exportformats http://www.harctoolbox.org/schemas/exportformats.xsd</xsl:attribute>

            <axsl:stylesheet>
                <xsl:namespace name="girr" select="'http://www.harctoolbox.org/Girr'"/>
                <xsl:namespace name="exporterutils" select="'http://xml.apache.org/xalan/java/org.harctoolbox.irscrutinizer.exporter.ExporterUtils'"/>
                <xsl:attribute name="version">1.0</xsl:attribute>

                <axsl:output method="text" />

            <axsl:template>
                <xsl:attribute name="match">/girr:remotes</xsl:attribute>
                <axsl:text xml:space="preserve"># </axsl:text>
                <axsl:value-of select="@title"/>
                <axsl:text>
#
# Creating tool: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">$creatingTool</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
# Creating user: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">$creatingUser</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
# Creating date: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">$creatingDate</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
# Encoding: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">$encoding</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
#
</axsl:text>
                <axsl:apply-templates>
                    <xsl:attribute name="select">girr:remote</xsl:attribute>
                </axsl:apply-templates>
            </axsl:template>

            <axsl:template>
                <xsl:attribute name="match">girr:remote</xsl:attribute>
                <axsl:text># Manufacturer: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">@manufacturer</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
# Model: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">@model</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
# Displayname: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">@displayName</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
# Device Class: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">@deviceClass</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
# Remotename: </axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">@remoteName</xsl:attribute>
                </axsl:value-of>
                <axsl:text>
#
</axsl:text>
                <axsl:apply-templates>
                    <xsl:attribute name="select">//girr:parameters[@protocol[not(. = ../../preceding-sibling::*//@protocol)]]</xsl:attribute>
                </axsl:apply-templates>
            </axsl:template>

            <!-- General case, raw codes -->
            <xsl:text xml:space="preserve">&#10;&#10;</xsl:text>
            <xsl:comment> ################ Default protocol rule, raw codes ############## </xsl:comment>
            <xsl:text xml:space="preserve">&#10;</xsl:text>
            <axsl:template>
                <xsl:attribute name="match">girr:parameters</xsl:attribute>
                <axsl:text>
# Raw signals
begin remote
&#9;name&#9;&#9;</axsl:text>
                <axsl:value-of>
                    <xsl:attribute name="select">translate(../../../@name, ' ', '_')</xsl:attribute>
                </axsl:value-of>
                <axsl:text>-raw
&#9;flags&#9;&#9;RAW_CODES
&#9;eps&#9;&#9;<xsl:value-of select="round(100*number(/NamedProtocols/@relative-tolerance))"/>
&#9;aeps&#9;&#9;<xsl:value-of select="round(/NamedProtocols/@absolute-tolerance)"/>
&#9;frequency&#9;</axsl:text>
        <axsl:value-of>
            <xsl:attribute name="select">/*//girr:command[1]/girr:raw/@frequency</xsl:attribute>
        </axsl:value-of>
        <axsl:text>
&#9;gap&#9;&#9;</axsl:text>
        <axsl:value-of select="/*//girr:command[1]/girr:raw/girr:repeat/girr:gap[position()=last()]"/>
        <axsl:text>
&#9;begin raw_codes
</axsl:text>
        <axsl:apply-templates select="/*//girr:command[girr:raw]" mode="raw"/>
        <axsl:text>&#9;end raw_codes
end remote
</axsl:text>
    </axsl:template>

    <axsl:template match="girr:command">
        <axsl:text># </axsl:text>
        <axsl:value-of select="translate(@name, ' ', '_')"/>
        <axsl:text xml:space="preserve"> not renderable, skipped
</axsl:text>
    </axsl:template>

    <axsl:template match="girr:command[girr:raw]" mode="raw">
        <axsl:text>&#9;&#9;name </axsl:text>
        <axsl:value-of select="translate(@name, ' ', '_')"/>
        <axsl:text xml:space="preserve">
</axsl:text>
        <axsl:apply-templates select="girr:raw[1]"/>
        <axsl:text xml:space="preserve">
</axsl:text>
    </axsl:template>

    <axsl:template match="girr:raw">
        <axsl:apply-templates select="girr:intro"/>
        <axsl:if test="not(girr:intro)">
            <axsl:apply-templates select="girr:repeat"/>
        </axsl:if>
    </axsl:template>

    <axsl:template match="girr:intro|girr:repeat">
        <axsl:text xml:space="preserve">&#9;&#9;&#9;</axsl:text>
        <axsl:apply-templates select="*"/>
    </axsl:template>

    <axsl:template match="girr:flash">
        <axsl:value-of select="."/>
        <axsl:text xml:space="preserve"> </axsl:text>
    </axsl:template>

    <axsl:template match="girr:gap">
        <axsl:value-of select="."/>
        <axsl:text xml:space="preserve"> </axsl:text>
    </axsl:template>

    <axsl:template match="girr:gap[position() mod 4 = 0]">
        <axsl:value-of select="."/>
        <axsl:text xml:space="preserve">
&#9;&#9;&#9;</axsl:text>
    </axsl:template>

    <axsl:template match="girr:gap[position()=last()]"/>


    <xsl:apply-templates select="NamedProtocols/NamedProtocol"/>
            </axsl:stylesheet>
        </exportformats:exportformat>
    </xsl:template>

    <xsl:template match="NamedProtocol">
        <xsl:apply-templates select="Protocol"/>
    </xsl:template>

    <xsl:template name="omitted-protocol">
        <xsl:param name="msg"/>
        <xsl:text xml:space="preserve">&#10;&#10;</xsl:text>
        <xsl:comment>
            <xsl:text> Protocol </xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text> omitted: </xsl:text>
            <xsl:value-of select="$msg"/>
            <xsl:text>.</xsl:text>
        </xsl:comment>
    </xsl:template>

    <!-- Have not implemented non-constant definitions yet -->
    <xsl:template match="NamedProtocol[Protocol/Definitions/Definition/Expression[not(Number)]]" priority="11">
        <xsl:call-template name="omitted-protocol">
            <xsl:with-param name="msg">Non-constant definitions not yet implemented</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Nuke protocols with too many bits -->
    <xsl:template match="NamedProtocol[Protocol/BitspecIrstream/IrStream/@numberOfBits &gt; 64]">
        <xsl:call-template name="omitted-protocol">
            <xsl:with-param name="msg">
                <xsl:text>Too many bits (</xsl:text>
            <xsl:value-of select="Protocol/BitspecIrstream/IrStream/@numberOfBits"/>
            <xsl:text> &gt; 64)"</xsl:text>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Nuke protocols with hierarchical BitspecIrstream -->
    <xsl:template match="NamedProtocol[Protocol/BitspecIrstream//BitspecIrstream]" priority='99'>
        <xsl:call-template name="omitted-protocol">
            <xsl:with-param name="msg">Hierarchical BitspecIrStreams</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Nuke biphase protocols with Gap between FiniteBitFields -->
    <xsl:template match="NamedProtocol[Protocol[@biphase='true']//IrStream/Gap[preceding-sibling::FiniteBitField and following-sibling::FiniteBitField]]" priority='399'>
        <xsl:call-template name="omitted-protocol">
            <xsl:with-param name="msg">Interleaved bitfields and durations</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Nuke protocols with non-constant bitlength -->
    <xsl:template match="NamedProtocol[Protocol/BitspecIrstream/NormalForm/*/FiniteBitField/Width[not(Number)]]" priority="999">
        <xsl:call-template name="omitted-protocol">
            <xsl:with-param name="msg">Variable number of bits</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Protocol with assignments do not fit into Lirc -->
    <xsl:template match="NamedProtocol[Protocol[.//Assignment and not(@toggle='true')]]" priority="10">
        <xsl:call-template name="omitted-protocol">
            <xsl:with-param name="msg">Assignment cannot be done in the Lirc framework</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Expressions as bitfields not implemented yet -->
    <xsl:template match="NamedProtocol[.//Data/Expression]">
        <xsl:call-template name="omitted-protocol">
            <xsl:with-param name="msg">Expressions as bitfields not implemented yet</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Variations not implemented yet -->
    <!--xsl:template match="NamedProtocol[.//Variation]">
        <xsl:comment>
            <xsl:text> Protocol </xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text> omitted: Variations not implemented yet </xsl:text>
        </xsl:comment>
    </xsl:template-->

    <!-- Expressions as bitfields not implemented yet -->
    <xsl:template match="NamedProtocol[Protocol[not(@pwm2='true')
                                                and not(@pwm4='true')
                                                and not(@biphase='true')]]" priority="1">
        <xsl:call-template name="omitted-protocol">
            <xsl:with-param name="msg">not one of the simple types (pwm2, pwm4, biphase)</xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Expressions as finitely repeating sequences not implemented -->
    <!--xsl:template match="NamedProtocol[.//IrStream[number(@repeatMin) > 1]]">
        <xsl:comment>
            <xsl:text> Protocol </xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text> omitted: finite repeats in IrSequences not implemented </xsl:text>
        </xsl:comment>
    </xsl:template-->

    <xsl:template match="Protocol">
        <xsl:text xml:space="preserve">&#10;&#10;</xsl:text>
        <xsl:comment> ################## Protocol <xsl:value-of select="../@name"/> ################ </xsl:comment>
        <xsl:text xml:space="preserve">&#10;</xsl:text>
        <xsl:comment xml:space="preserve"> IRP:<xsl:value-of select="../Irp"/> </xsl:comment>
        <xsl:text xml:space="preserve">&#10;</xsl:text>
        <axsl:template>
            <xsl:attribute name="match">girr:parameters[translate(@protocol, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = '<xsl:value-of select="lower-case(../@name)"/>']</xsl:attribute>
            <xsl:text xml:space="preserve">&#10;</xsl:text>
            <xsl:apply-templates select="BitspecIrstream" mode="warnIntroAndRepeat"/>
            <xsl:apply-templates select="BitspecIrstream" mode="warnEnding"/>
            <axsl:text xml:space="preserve">
# Protocol name: <xsl:value-of select="../@name"/>
begin remote&#10;&#9;name&#9;&#9;</axsl:text>
            <axsl:value-of select="translate(../../../@name, ' ', '_')"/>
<axsl:text><xsl:text>-</xsl:text><xsl:value-of select="../@name"/>
<xsl:apply-templates select="BitspecIrstream" mode="numberOfBits"/>
&#9;flags&#9;&#9;<xsl:apply-templates select="@pwm2"/><xsl:apply-templates select="@pwm4"/><xsl:apply-templates select="@biphase"/>
            <xsl:apply-templates select="BitspecIrstream/NormalForm/*[FiniteBitField][1]/Extent" mode="flags"/>
&#9;eps&#9;&#9;<xsl:if test="../@relative-tolerance">
    <xsl:value-of select="round(100*number(../@relative-tolerance))"/>
</xsl:if>
<xsl:if test="not(../@relative-tolerance)">
    <xsl:value-of select="round(100*number(/NamedProtocols/@relative-tolerance))"/>
</xsl:if>
&#9;aeps&#9;&#9;<xsl:value-of select="round(../@absolute-tolerance)"/>
<xsl:if test="not(../@absolute-tolerance)">
    <xsl:value-of select="round(/NamedProtocols/@absolute-tolerance)"/>
</xsl:if>
<xsl:apply-templates select="BitspecIrstream/BitSpec/BareIrStream[1]" mode="define-zero"/>
<xsl:apply-templates select="BitspecIrstream/BitSpec/BareIrStream[2]" mode="define-one"/>
<xsl:apply-templates select="BitspecIrstream/BitSpec/BareIrStream[3]" mode="define-two"/>
<xsl:apply-templates select="BitspecIrstream/BitSpec/BareIrStream[4]" mode="define-three"/>
<xsl:apply-templates select="BitspecIrstream" mode="header"/>
<xsl:apply-templates select="BitspecIrstream" mode="plead"/>
<xsl:apply-templates select="BitspecIrstream" mode="ptrail"/>
<xsl:apply-templates select="BitspecIrstream[NormalForm/Intro/*]/NormalForm/Repeat" mode="repeatFlag"/>
<xsl:apply-templates select="BitspecIrstream" mode="gapFlag"/>
<xsl:apply-templates select="BitspecIrstream[../@toggle='true' and NormalForm/*/FiniteBitField/Data[.='T']]" mode="toggle_bit"/><!-- obsolete synonom: repeat_bit -->
&#9;frequency&#9;<xsl:value-of select="GeneralSpec/@frequency"/>
&#9;begin codes
</axsl:text>
        <axsl:apply-templates>
            <xsl:attribute name="select">
                <xsl:text>/*//girr:command[girr:parameters[translate(@protocol, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = &apos;</xsl:text>
                <xsl:value-of select="lower-case(../@name)"/>
                <xsl:text>&apos;]]</xsl:text>
            </xsl:attribute>
        </axsl:apply-templates>
        <axsl:text>&#9;end codes
end remote
</axsl:text>
        </axsl:template>

        <axsl:template>
            <xsl:attribute name="name">command-<xsl:value-of select="harctoolbox:canonical-name(../@name)"/></xsl:attribute>
            <xsl:apply-templates select="ParameterSpecs/ParameterSpec"/>
            <xsl:apply-templates select="Definitions/Definition"/>
            <axsl:text xml:space="preserve">&#9;&#9;</axsl:text>
            <axsl:value-of select="translate(@name, ' ', '_')"/>
            <axsl:text>&#9;0x</axsl:text>
            <axsl:value-of>
                <xsl:attribute name="select">
                    <xsl:text>exporterutils:processBitFields(</xsl:text>
                    <xsl:apply-templates select="BitspecIrstream/NormalForm/Intro/FiniteBitField" mode="inCode"/>
                    <xsl:if test="not(BitspecIrstream/NormalForm/Intro/FiniteBitField)">
                        <xsl:apply-templates select="BitspecIrstream/NormalForm/Repeat/FiniteBitField" mode="inCode"/>
                    </xsl:if>
                    <xsl:text>)</xsl:text>
                </xsl:attribute>
            </axsl:value-of>
            <axsl:text xml:space="preserve">
</axsl:text>
        </axsl:template>

        <xsl:apply-templates select="BitspecIrstream/NormalForm/*[FiniteBitField and ../../../ParameterSpecs/ParameterSpec/Default]" mode="withDefaults"/>
        <xsl:apply-templates select="BitspecIrstream/NormalForm/Intro[FiniteBitField]" mode="withoutDefaults"/>
        <xsl:if test="not(BitspecIrstream/NormalForm/Intro[*])">
            <xsl:apply-templates select="BitspecIrstream/NormalForm/Repeat[FiniteBitField]" mode="withoutDefaults"/>
        </xsl:if>
   </xsl:template>

    <xsl:template match="BitspecIrstream" mode="warnEnding"/>

    <xsl:template match="BitspecIrstream[NormalForm/Ending[* and not(Assignment)]]" mode="warnEnding">
        <axsl:text># Warning: Protocol contains ending that cannot be expressed in Lirc&#10;</axsl:text>
    </xsl:template>

    <xsl:template match="BitspecIrstream" mode="warnIntroAndRepeat"/>

    <xsl:template match="BitspecIrstream[NormalForm/Intro/FiniteBitField and NormalForm/Repeat/FiniteBitField]" mode="warnIntroAndRepeat">
        <axsl:text># Warning: Protocol contains repeat elements that cannot be expressed in Lirc&#10;</axsl:text>
    </xsl:template>

    <xsl:template match="Intro|Repeat" mode="withoutDefaults">
        <xsl:comment> Version without defaults </xsl:comment>
        <axsl:template>
            <xsl:attribute name="match" xml:space="skip">
                <xsl:text>girr:command[translate(girr:parameters/@protocol, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='</xsl:text>
                <xsl:value-of select="lower-case(../../../../@name)"/>
                <xsl:text>'</xsl:text>
            <xsl:apply-templates select="../../../ParameterSpecs/ParameterSpec[Default]" mode="default-path"/>]</xsl:attribute>
            <axsl:call-template>
                <xsl:attribute xml:space="skip" name="name">
                    <xsl:text>command-</xsl:text>
                    <xsl:value-of xml:space="skip" select="harctoolbox:canonical-name(../../../../@name)"/>
                </xsl:attribute>
                <xsl:apply-templates select="../../../ParameterSpecs/ParameterSpec" mode="inCodeWithoutDefaults"/>
                <xsl:apply-templates select="../../../Definitions/Definition" mode="inCodeWithoutDefaults"/>
           </axsl:call-template>
        </axsl:template>
    </xsl:template>

    <xsl:template match="Intro|Repeat" mode="withDefaults">
        <xsl:comment> Version with defaults </xsl:comment>
        <axsl:template>
            <xsl:attribute name="match">girr:command[translate(girr:parameters/@protocol, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='<xsl:value-of select="lower-case(../../../../@name)"/>']</xsl:attribute>
            <axsl:call-template>
                <xsl:attribute xml:space="skip" name="name">
                    <xsl:text>command-</xsl:text>
                    <xsl:value-of xml:space="skip" select="harctoolbox:canonical-name(../../../../@name)"/>
                </xsl:attribute>
                <xsl:apply-templates select="../../../ParameterSpecs/ParameterSpec" mode="inCodeWithDefaults"/>
                <xsl:apply-templates select="../../../Definitions/Definition" mode="inCodeWithoutDefaults"/>
            </axsl:call-template>
        </axsl:template>
    </xsl:template>

    <xsl:template match="ParameterSpec" mode="default-path" xml:space="skip">
        <xsl:text> and girr:parameters/girr:parameter[@name='</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>']</xsl:text>
    </xsl:template>

    <xsl:template match="ParameterSpec">
        <axsl:param>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
        </axsl:param>
    </xsl:template>

    <xsl:template match="Definition">
        <axsl:param>
            <xsl:attribute name="name">
                <xsl:value-of select="Name/text()"/>
            </xsl:attribute>
        </axsl:param>
    </xsl:template>

    <xsl:template match="Definition" mode="inCodeWithoutDefaults">
        <axsl:with-param>
            <xsl:attribute name="name">
                <xsl:value-of select="Name/text()"/>
            </xsl:attribute>
            <xsl:attribute name="select">
                <xsl:text>number(</xsl:text>
                <xsl:value-of select="Expression/Number/text()"/>
                <xsl:text>)</xsl:text>
            </xsl:attribute>
        </axsl:with-param>
    </xsl:template>

    <xsl:template match="ParameterSpec" mode="inCodeWithoutDefaults">
        <axsl:with-param>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:attribute name="select">
                <xsl:text>number(girr:parameters/girr:parameter[@name='</xsl:text>
                <xsl:value-of select="@name"/>
                <xsl:text>']/@value)</xsl:text>
            </xsl:attribute>
        </axsl:with-param>
    </xsl:template>

    <xsl:template match="ParameterSpec" mode="inCodeWithDefaults">
        <axsl:with-param>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:attribute name="select">
                <xsl:text>number(girr:parameters/girr:parameter[@name='</xsl:text>
                <xsl:value-of select="@name"/>
                <xsl:text>']/@value)</xsl:text>
            </xsl:attribute>
        </axsl:with-param>
    </xsl:template>

    <xsl:template match="ParameterSpec[Default]" mode="inCodeWithDefaults">
        <axsl:with-param>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:attribute name="select">
                <xsl:apply-templates select="Default"/>
            </xsl:attribute>
        </axsl:with-param>
    </xsl:template>

    <xsl:template match="parameter" mode="inCode">
        <axsl:with-param>
            <xsl:attribute name="name">
                <xsl:value-of select="@name"/>
            </xsl:attribute>
            <xsl:attribute name="select">
                <xsl:text>number(girr:parameters/girr:parameter[@name='</xsl:text>
                <xsl:value-of select="@name"/>
                <xsl:text>']/@value)</xsl:text>
            </xsl:attribute>
        </axsl:with-param>
    </xsl:template>

    <xsl:template match="Default">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="Expression">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="BinaryOperator">
        <xsl:text>(</xsl:text>
        <xsl:apply-templates select="Expression[1]"/>
        <xsl:text>)</xsl:text>
        <xsl:value-of select="@kind"/>
        <xsl:text>(</xsl:text>
        <xsl:apply-templates select="Expression[2]"/>
        <xsl:text>)</xsl:text>
    </xsl:template>

    <xsl:template match="Name">
        <xsl:text>number(girr:parameters/girr:parameter[@name='</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>']/@value)</xsl:text>
    </xsl:template>

    <xsl:template name="bool-attribute">
        <xsl:value-of select="."/>
        <xsl:text>()</xsl:text>
    </xsl:template>

    <xsl:template match="@complement">
        <xsl:call-template name="bool-attribute"/>
    </xsl:template>

    <xsl:template match="@reverse">
        <xsl:call-template name="bool-attribute"/>
    </xsl:template>

    <xsl:template match="@reverse[ancestor::Protocol[GeneralSpec/@bitDirection='lsb']]">
        <xsl:if test=".='true'">
            <xsl:text>false()</xsl:text>
        </xsl:if>
        <xsl:if test="not(.='true')">
            <xsl:text>true()</xsl:text>
        </xsl:if>

    </xsl:template>

    <xsl:template match="finiteBitField" mode="namedTemplate">
        <axsl:with-param>
            <xsl:attribute name="name">
                <xsl:value-of select="data"/>
            </xsl:attribute>
        </axsl:with-param>
    </xsl:template>

    <xsl:template match="FiniteBitField" mode="inCode">
        <xsl:apply-templates select="@complement"/>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="@reverse"/>
        <xsl:text>, </xsl:text>

        <!--xsl:text>, number(girr:parameters/girr:parameter[@name='</xsl:text-->
        <xsl:apply-templates select="Data" mode="inFiniteBitField"/>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="Width"/>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="Chop"/>
        <xsl:if test="not(position()=last())">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Width|Chop">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="data" mode="inFiniteBitField">
        <xsl:apply-templates select="node()" mode="inFiniteBitField"/>
    </xsl:template>

    <xsl:template match="Name" mode="inFiniteBitField">
        <xsl-text>$</xsl-text>
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="function" mode="toggle_bit"/>

    <xsl:template match="BitspecIrstream" mode="numberOfBits">
        <xsl:text xml:space="preserve">&#10;&#9;bits&#9;&#9;</xsl:text>
        <xsl:value-of select="NormalForm/*[FiniteBitField][1]/@numberOfBits"/>
    </xsl:template>

    <xsl:template match="BitspecIrstream" mode="toggle_bit">
        <xsl:text xml:space="preserve">
&#9;toggle_bit&#9;</xsl:text>
        <xsl:apply-templates select="NormalForm/*/FiniteBitField[Data/Name[.='T']]" mode="toggle_bit_position"/>
    </xsl:template>

    <xsl:template match="FiniteBitField" mode="toggle_bit_position">
        <xsl:value-of select="1 + sum(preceding-sibling::FiniteBitField/Width)"/>
    </xsl:template>

    <xsl:template match="BitspecIrstream" mode="header">
        <xsl:apply-templates select="NormalForm/Intro[*]" mode="header"/>
        <xsl:if test="not(NormalForm/Intro[*])">
            <xsl:apply-templates select="NormalForm/Repeat" mode="header"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Intro|Repeat" mode="header"/>

    <xsl:template match="Intro[ *[1][name()='Flash']  and  *[2][name()='Gap'] ]
                      | Repeat[ *[1][name()='Flash']  and  *[2][name()='Gap'] ]" mode="header">
        <xsl:text xml:space="preserve">
&#9;header&#9;</xsl:text>
        <xsl:apply-templates select="Flash[1]"/>
        <xsl:apply-templates select="Gap[1]"/>
    </xsl:template>

    <xsl:template match="BitspecIrstream" mode="plead">
        <xsl:apply-templates select="NormalForm/Intro" mode="plead"/>
        <xsl:if test="not(NormalForm/Intro[*])">
            <xsl:apply-templates select="NormalForm/Repeat" mode="plead"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Intro|Repeat" mode="plead"/>

    <xsl:template match="Intro[*[1][name()='Flash']  and  *[2][name()='FiniteBitField']]
                      | Repeat[*[1][name()='Flash']  and  *[2][name()='FiniteBitField']]" mode="plead">
        <xsl:text xml:space="preserve">
&#9;plead&#9;</xsl:text>
        <xsl:apply-templates select="Flash[1]"/>
    </xsl:template>

    <xsl:template match="Intro[*[1][name()='Flash']  and  *[2][name()='Gap'] and *[3][name()='Flash'] ]
                      | Repeat[*[1][name()='Flash']  and  *[2][name()='Gap'] and *[3][name()='Flash'] ]" mode="plead">
        <xsl:text xml:space="preserve">
&#9;plead&#9;</xsl:text>
        <xsl:apply-templates select="Flash[2]"/>
    </xsl:template>

    <xsl:template match="Repeat" mode="repeatFlag"/>

    <xsl:template match="Repeat[*[1][name()='Flash']  and  *[2][name()='Gap'] and not(*[name()='FiniteBitField'])]" mode="repeatFlag">
        <xsl:text xml:space="preserve">
&#9;repeat&#9;</xsl:text>
        <xsl:apply-templates select="Flash[1]"/>
        <xsl:apply-templates select="Gap[1]"/>
    </xsl:template>

    <xsl:template match="BitspecIrstream" mode="gapFlag">
        <xsl:apply-templates select="NormalForm/Intro" mode="gapFlag"/>
        <xsl:if test="not(NormalForm/Intro[*])">
            <xsl:apply-templates select="NormalForm/Repeat" mode="gapFlag"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Intro|Repeat" mode="gapFlag"/>

    <xsl:template match="Intro[Extent]|Repeat[Extent]" mode="gapFlag">
        <xsl:text xml:space="preserve">
&#9;gap&#9;</xsl:text>
        <xsl:apply-templates select="Extent[1]" mode="gap"/>
    </xsl:template>

    <xsl:template match="Intro[*[position()=last()][name()='Gap']]
                      | Repeat[*[position()=last()][name()='Gap']]" mode="gapFlag">
        <xsl:text xml:space="preserve">
&#9;gap&#9;</xsl:text>
<xsl:apply-templates select="Gap[position()=last()]"/>
    </xsl:template>

    <xsl:template match="BitspecIrstream" mode="ptrail">
        <xsl:apply-templates select="NormalForm/Intro" mode="ptrail"/>
        <xsl:if test="not(NormalForm/Intro[*])">
            <xsl:apply-templates select="NormalForm/Repeat" mode="ptrail"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Intro|Repeat" mode="ptrail"/>

    <xsl:template match="Intro[Flash[preceding-sibling::FiniteBitField]]
                      | Repeat[Flash[preceding-sibling::FiniteBitField]]" mode="ptrail">
        <xsl:text xml:space="preserve">
&#9;ptrail&#9;</xsl:text>
        <xsl:apply-templates select="Flash[preceding-sibling::FiniteBitField and position()=last()]"/>
    </xsl:template>

    <xsl:template xml:space="skip" name="multiply">
        <xsl:param name="x"/>
        <xsl:param name="y"/>
        <xsl:value-of select="round(number($x)*number($y))"/>
    </xsl:template>

    <xsl:template match="BareIrStream" mode="define-zero">
        <xsl:text xml:space="preserve">&#10;&#9;zero&#9;</xsl:text>
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="BareIrStream" mode="define-one">
        <xsl:text xml:space="preserve">&#10;&#9;one&#9;</xsl:text>
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="BareIrStream" mode="define-two">
        <xsl:text xml:space="preserve">&#10;&#9;two&#9;</xsl:text>
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="BareIrStream" mode="define-three">
        <xsl:text xml:space="preserve">&#10;&#9;three&#9;</xsl:text>
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="Flash[@unit='']|Gap[@unit='']">
        <xsl:text>&#9;</xsl:text>
        <xsl:call-template name="multiply">
            <xsl:with-param name="x">
                <xsl:apply-templates select="*"/>
            </xsl:with-param>
            <xsl:with-param name="y">
                <xsl:value-of select="number(ancestor::Protocol/GeneralSpec/@unit)"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="Flash[@unit='m']|Gap[@unit='m']">
        <xsl:text>&#9;</xsl:text>
        <xsl:call-template name="multiply">
            <xsl:with-param name="x">
                <xsl:apply-templates select="*"/>
            </xsl:with-param>
            <xsl:with-param name="y" select="1000"/>
        </xsl:call-template>
        <xsl:value-of select="1000 * @time"/>
    </xsl:template>

    <xsl:template match="Flash[@unit='u']|Gap[@unit='u']">
        <xsl:text>&#9;</xsl:text>
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="Extent[@unit='m']" mode="gap">
        <xsl:text>&#9;</xsl:text>
        <xsl:call-template name="multiply">
            <xsl:with-param name="x">
                <xsl:apply-templates select="*"/>
            </xsl:with-param>
            <xsl:with-param name="y" select="1000"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="Number">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template match="NameOrNumber">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="NumberWithDecimals">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template match="@pwm2[.='true']">
        <xsl:text>SPACE_ENC</xsl:text>
    </xsl:template>

    <xsl:template match="@pwm4[.='true']">
        <xsl:text>RCMM</xsl:text>
    </xsl:template>

    <xsl:template match="@biphase[.='true']">
        <xsl:text>RC5</xsl:text>
    </xsl:template>

    <!-- REVERSE is not reliable; do not use -->

    <xsl:template match="Extent" mode="flags">
        <xsl:text>|CONST_LENGTH</xsl:text>
    </xsl:template>

</xsl:transform>