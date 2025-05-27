within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector PartialThermalPortDCMachines 
  "直流电机的部分热端口"
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortArmature 
    "电枢的热端口" 
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore 
    "（可选）核心损耗的热端口" 
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortStrayLoad 
    "（可选）杂散损耗的热端口" 
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortFriction 
    "（可选）摩擦损耗的热端口" 
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush 
    "（可选）刷子损耗的热端口" 
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
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
直流电机的部分热端口
</html>"));
end PartialThermalPortDCMachines;