within Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities;
model Battery "简单电池模型"
  parameter SI.Voltage V0 "空载电压";
  parameter SI.Current INominal "额定电流";
  parameter SI.Resistance Ri=0.05*V0/INominal "内阻";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p 
    annotation (Placement(transformation(extent={{50,110},{70,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n 
    annotation (Placement(transformation(extent={{-70,110},{-50,90}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-90,80})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=V0) 
    annotation (Placement(transformation(extent={{10,50},{-10,70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=Ri) 
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={60,70})));
equation
  connect(ground.p, pin_n) 
    annotation (Line(points={{-80,80},{-60,80},{-60,100}}, color={0,0,255}));
  connect(pin_n, constantVoltage.n) 
    annotation (Line(points={{-60,100},{-60,60},{-10,60}}, color={0,0,255}));
  connect(constantVoltage.p, resistor.p) 
    annotation (Line(points={{10,60},{60,60}}, color={0,0,255}));
  connect(resistor.n, pin_p) 
    annotation (Line(points={{60,80},{60,100}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                        Text(
        extent={{-120,-100},{120,-140}}, 
        textString="%name", 
        textColor={0,0,255}),           Text(
        extent={{-100,-60},{100,-80}}, 
        textColor={0,0,255}, 
          textString="V0=%V0"), 
        Rectangle(extent={{-70,90},{-50,80}}, lineColor={28,108,200}), 
        Rectangle(
          extent={{50,90},{70,80}}, 
          lineColor={28,108,200}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-100,80},{100,-40}}, 
          lineColor={28,108,200}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          radius=10), 
        Rectangle(
          extent={{-92,72},{-4,-32}}, 
          lineColor={28,108,200}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{4,72},{92,-32}}, 
          lineColor={28,108,200}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid)}),    Documentation(info="<html>
<p>
这是一个简单的直流电源模型，由恒定的直流电压和内阻组成。
</p>
</html>"));
end Battery;