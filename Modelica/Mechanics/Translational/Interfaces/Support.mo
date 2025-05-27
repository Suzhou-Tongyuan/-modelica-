within Modelica.Mechanics.Translational.Interfaces;
connector Support "一维平动组件的支撑组件/外壳一维平动接口"
  extends Flange;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={Rectangle(
              extent={{-60,60},{60,-60}}, 
              fillColor={175,190,175}, 
              fillPattern=FillPattern.Solid, 
              pattern=LinePattern.None),           Text(
              extent={{-160,110},{40,50}}, 
              textColor={0,127,0}, 
              textString="%name"),Rectangle(
              extent={{-40,-40},{40,40}}, 
              lineColor={0,127,0}, 
              fillColor={0,127,0}, 
              fillPattern=FillPattern.Solid)}), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
              extent={{-90,-90},{90,90}}, 
              lineColor={0,127,0}, 
              fillColor={175,175,175}, 
              fillPattern=FillPattern.Solid),Rectangle(
          extent={{-150,150},{150,-150}}, 
          fillColor={175,190,175}, 
          fillPattern=FillPattern.Solid, 
          pattern=LinePattern.None),    Rectangle(
              extent={{-90,-90},{90,90}}, 
              lineColor={0,127,0}, 
              fillColor={0,127,0}, 
              fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
这是用于一维平动机械系统的连接器，用于建模轴的支撑或外壳。
此连接器定义了以下变量：
</p>

<blockquote><pre>
s: Absolute position of the support/housing in [m].
f: Reaction force in the support/housing in [N].
</pre></blockquote>
<p>
支撑连接器通常被定义为条件连接器。最方便的是将其用于以下情况
</p>
<ul>
<li>要以图形方式构建模型（即，通过从基本组件中拖放来构建模型）：<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>.<br>&nbsp;</li>
<li>要以文本方式构建模型（即，基本模型）：<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2\">PartialElementaryOneFlangeAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2\">PartialElementaryTwoFlangesAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>.</li>
</ul>
</html>"));
end Support;