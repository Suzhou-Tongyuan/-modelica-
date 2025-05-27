within Modelica.Mechanics.Translational.Sensors;
model MultiSensor 
  "理想传感器，用于测量两个一维平动接口之间的绝对速度、力和功率"
  extends Translational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput power(unit="W") 
    "输出信号：一维平动接口 flange_a 中的功率" annotation (Placement(
        transformation(
        origin={-60,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput f(unit="N") 
    "输出信号：一维平动接口a和一维平动接口b中的力(f = flange_a.f = -flange_b.f)" 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="m/s") 
    "输出信号：一维平动接口的绝对速度" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=-90, 
        origin={60,-110})));
equation
  flange_a.s = flange_b.s;
  f = flange_a.f;
  v = der(flange_a.s);
  power = f*v;

  annotation (
    Documentation(info="<html><p>
以理想方式测量一维平动接口a的绝对速度，两个一维平动接口之间的力和功率，并分别将结果作为输出信号<strong>v</strong>、<strong>f</strong> 和 <strong>power</strong>。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={    Line(points={{-60, 
          -100},{-60,-60}}, color={0,0,127}), 
                              Line(points={{0,-100},{0,-60}}, color={0,0,127}), 
          Line(points={{60,-100},{60,-60}}, color={0,0,127}), 
        Text(
          extent={{-100,-60},{-60,-100}}, 
          textColor={64,64,64}, 
          textString="W"), 
        Text(
          extent={{-20,-60},{20,-100}}, 
          textColor={64,64,64}, 
          textString="N"), 
        Text(
          extent={{60,-60},{100,-100}}, 
          textColor={64,64,64}, 
          textString="m/s")}));
end MultiSensor;