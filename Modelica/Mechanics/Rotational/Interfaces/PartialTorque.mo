within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialTorque 
  "作用在一维转动接口上的扭矩的部分模型（加速一维转动接口）"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  SI.Angle phi 
    "一维转动接口相对于支撑组件的角度（= 一维转动接口.phi - 支撑.phi）";

equation
  phi = flange.phi - phi_support;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-96,96},{96,-96}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{0,-62},{0,-100}}), 
        Text(
          extent={{-150,150},{150,110}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Polygon(
          points={{94,26},{80,84},{50,62},{94,26}}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-50,-98},{-30,-80},{-42,-72},{-50,-98}}, 
          fillPattern=FillPattern.Solid), 
        Line(
          visible=not useSupport, 
          points={{-50,-120},{-30,-100}}), 
        Line(
          visible=not useSupport, 
          points={{-30,-120},{-10,-100}}), 
        Line(
          visible=not useSupport, 
          points={{-10,-120},{10,-100}}), 
        Line(
          visible=not useSupport, 
          points={{10,-120},{30,-100}}), 
        Line(
          visible=not useSupport, 
          points={{-30,-100},{30,-100}}), 
    Line(
      points={{-48,-92},{-38,-76},{-18,-64},{0,-60},{18,-64},{38,-76},{48,-92}}, 
      smooth=Smooth.Bezier), 
    Line(
      points={{-86,40},{-74,66},{-56,86},{-20,100},{20,100},{60,80},{82,48}}, 
      smooth=Smooth.Bezier)}), 
    Documentation(info="<html>
<p>
作用在一维转动接口上的扭矩的部分模型。

</p>
<p>
如果<em>useSupport=true</em>，则支撑连接器条件性启用，并且需要连接。<br>
如果<em>useSupport=false</em>，则支撑连接器条件性禁用，并且组件将内部固定到地面。
</p>
</html>"));
end PartialTorque;