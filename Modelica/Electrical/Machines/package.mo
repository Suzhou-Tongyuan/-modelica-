within Modelica.Electrical;
package Machines "电机库"
  extends Modelica.Icons.Package;

  annotation (
    preferredView="info", 
    Documentation(info="<html>
<p>要区分各种机器模型，请参阅<strong><a href=Modelica.Electrical.Machines.UsersGuide.Discrimination>用户说明-机器模型的区分</a></strong>中的详细内容。</p>

<p>
版权所有&copy; 1998-2020，Modelica协会及贡献者
</p>
</html>", revisions="<html>
</html>"), 
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          origin={2.835,10}, 
          fillColor={0,128,255}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-60,-60},{60,60}}), 
        Rectangle(
          origin={2.835,10}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-80,-60},{-60,60}}), 
        Rectangle(
          origin={2.835,10}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{60,-10},{80,10}}), 
        Rectangle(
          origin={2.835,10}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          extent={{-60,50},{20,70}}), 
        Polygon(
          origin={2.835,10}, 
          fillPattern=FillPattern.Solid, 
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{60, 
              -100},{-70,-100},{-70,-90}})}));
end Machines;