within Modelica.Thermal.HeatTransfer.Components;
model ThermalResistor 
  "传输热量而不储存热量的集总热元件"
  extends Interfaces.Element1D;
  parameter SI.ThermalResistance R 
    "材料的恒定热阻";

equation
  dT = R*Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-90,70},{90,-70}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Forward), 
        Line(
          points={{-90,70},{-90,-70}}, 
          thickness=0.5), 
        Line(
          points={{90,70},{90,-70}}, 
          thickness=0.5), 
        Text(
          extent={{-150,120},{150,78}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-80},{150,-110}}, 
          textString="R=%R")}), 
    Documentation(info="<html><p>
这是一个描述热量传输而不储存的模型，与 <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\" target=\"\">ThermalConductor</a>&nbsp; 模型相同，但使用热阻而不是热导作为参数。 这对于热阻的串联连接非常有利， 尤其是在允许将热阻定义为零（即无温差）的情况下。
</p>
</html>"));
end ThermalResistor;