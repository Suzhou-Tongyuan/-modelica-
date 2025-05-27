within Modelica.Thermal.HeatTransfer.Examples;
model TwoMasses "简单的导热示例"
  extends Modelica.Icons.Example;
  parameter SI.Temperature T_final_K(fixed=false) 
    "预计最终温度";
  HeatTransfer.Components.HeatCapacitor mass1(C=15, T(start=373.15, fixed=true)) 
    annotation (Placement(transformation(extent={{-100,20},{-40,80}})));
  HeatTransfer.Components.HeatCapacitor mass2(C=15, T(start=273.15, fixed=true)) 
    annotation (Placement(transformation(extent={{40,20},{100,80}})));
  HeatTransfer.Components.ThermalConductor conduction(G=10) 
    annotation (Placement(transformation(extent={{-30,-20},{30,40}})));
  HeatTransfer.Celsius.TemperatureSensor Tsensor1 
    annotation (Placement(transformation(extent={{-60,-80},{-20,-40}})));
  HeatTransfer.Celsius.TemperatureSensor Tsensor2 
    annotation (Placement(transformation(extent={{60,-80},{20,-40}})));
equation
  connect(mass1.port, conduction.port_a) annotation (Line(points={{-70,20}, 
          {-70,10},{-30,10}}, color={191,0,0}));
  connect(conduction.port_b, mass2.port) annotation (Line(points={{30,10},{
          70,10},{70,20}}, color={191,0,0}));
  connect(mass1.port, Tsensor1.port) annotation (Line(points={{-70,20},{-70, 
          -60},{-60,-60}}, color={191,0,0}));
  connect(mass2.port, Tsensor2.port) annotation (Line(points={{70,20},{70, 
          -60},{60,-60}}, color={191,0,0}));
initial equation
  T_final_K = (mass1.T*mass1.C + mass2.T*mass2.C)/(mass1.C + mass2.C);
  annotation (Documentation(info="<html>
<p>
本示例演示了通过导热元件连接的两个质量体的热响应。两个质量体具有相同的热容，但初始温度不同（T1 = 100 [°C]，T2 = 0 [°C]）。
温度较高的质量体将会冷却，而温度较低的质量体将会加热。
它们将分别逐渐接近由系统总初始能量与各元件热容之和计算得到的最终温度<strong>T_final_K</strong>
(<strong>T_final_degC</strong>)。
</p>
<p>
模拟时间为 5 秒，并绘制以下变量：
mass1.T, mass2.T, T_final_K 或
Tsensor1.T, Tsensor2.T, T_final_degC
</p>
</html>"), 
    experiment(StopTime=1.0, Interval=0.001));
end TwoMasses;