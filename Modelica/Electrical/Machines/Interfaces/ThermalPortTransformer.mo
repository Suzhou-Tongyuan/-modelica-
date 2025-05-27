within Modelica.Electrical.Machines.Interfaces;
connector ThermalPortTransformer "变压器的热端口"
  parameter Integer m=3 "相数" annotation(Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1[m] 
    "一次侧绕组的热端口" 
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort2[m] 
    "二次侧绕组的热端口" 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore 
    "（可选）铁心损耗的热端口" 
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    annotation (
    Diagram(graphics={Rectangle(
          extent={{-60,60},{60,-60}}, 
          lineColor={191,0,0}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), Ellipse(
              extent={{-50,50},{50,-50}}, 
              lineColor={191,0,0}, 
              fillColor={191,0,0}, 
              fillPattern=FillPattern.Solid)}), 
    Icon(graphics={Rectangle(
          extent={{-110,110},{110,-110}}, 
          lineColor={191,0,0}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), Ellipse(
              extent={{-80,80},{80,-80}}, 
              lineColor={191,0,0}, 
              fillColor={191,0,0}, 
              fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
变压器的热端口
</html>"));
end ThermalPortTransformer;