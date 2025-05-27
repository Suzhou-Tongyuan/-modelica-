within Modelica.Mechanics.Rotational.Interfaces;
connector Support "一维旋转轴的支撑组件"
  extends Flange;

  annotation (
    Documentation(info="<html>
<p>
这是用于一维旋转机械系统和模型的连接器，表示轴的支撑或轴承座。在此连接器中定义了以下变量：
</p>

<blockquote><pre>
phi: Absolute rotation angle of the support/housing in [rad].
tau: Reaction torque in the support/housing in [Nm].
</pre></blockquote>

<p>
支撑连接器通常被定义为条件连接器。
最方便的方法是利用它
</p>

<ul>
<li> 对于以图形方式构建的模型（模型是通过从基本组件中拖放来构建的）：<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>.<br> &nbsp;</li>

<li> 对于以文本方式构建的模型（基本模型）：<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2\">PartialElementaryOneFlangeAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2\">PartialElementaryTwoFlangesAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>.</li>
</ul>
</html>"), 

    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-150,150},{150,-150}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-100,100},{100,-100}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid)}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={Rectangle(
              extent={{-60,60},{60,-60}}, 
              lineColor={192,192,192}, 
              fillColor={192,192,192}, 
              fillPattern=FillPattern.Solid),Text(
              extent={{-160,100},{40,60}}, 
              textString="%name"),Ellipse(
              extent={{-40,40},{40,-40}}, 
              fillColor={135,135,135}, 
              fillPattern=FillPattern.Solid)}));
end Support;