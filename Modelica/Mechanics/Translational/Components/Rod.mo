within Modelica.Mechanics.Translational.Components;
model Rod "无惯性的杆"
  extends Translational.Interfaces.PartialRigid;

equation
  0 = flange_a.f + flange_b.f;
  annotation (
    Documentation(info="<html>
<p>
一个没有惯性的平动杆，带有两个刚性连接的一维平动接口。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-100,0},{100,0}}, color={0,127,0}), 
                                                        Polygon(
          points={{50,-90},{20,-80},{20,-100},{50,-90}}, 
          lineColor={95,127,95}, 
          fillColor={95,127,95}, 
          fillPattern=FillPattern.Solid),    Line(points={{-60,-90},{20,-90}}, color={95,127,95}), 
                                                                               Rectangle(
          extent={{-60,10},{60,-10}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid),    Text(
              extent={{-150,80},{150,40}}, 
              textString="%name", 
              textColor={0,0,255}),Text(
              extent={{-150,-30},{150,-60}}, 
              textString="L=%L")}));
end Rod;