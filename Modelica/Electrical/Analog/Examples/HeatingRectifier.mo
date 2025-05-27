within Modelica.Electrical.Analog.Examples;
model HeatingRectifier "考虑热特性的整流器"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Semiconductors.Diode HeatingDiode1(
      useTemperatureDependency=true, useHeatPort=true) 
                annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Electrical.Analog.Basic.Ground G 
  annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(V=1, f=1) 
  annotation (Placement(transformation(
        origin={-70,40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));

  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=1, v(start=0, fixed=true)) 
  annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor HeatCapacitor1(C=1) 
  annotation (Placement(transformation(
        origin={-20,-50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ThermalConductor1(G=10) 
  annotation (Placement(transformation(
        origin={-20,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=1) 
  annotation (Placement(transformation(extent={{20,70},{40,90}})));
initial equation
  HeatCapacitor1.T = 293.15;

equation
  connect(SineVoltage1.p, HeatingDiode1.p) 
  annotation (Line(points={{-70,50},{-20,50}}, color={0,0,255}));
  connect(SineVoltage1.n, G.p) 
  annotation (Line(points={{-70,30},{-70,20}}, color={0,0,255}));
  connect(Capacitor1.n, G.p) 
  annotation (Line(points={{40,50},{40,20},{-70,20}}, color={0,0,255}));
  connect(HeatingDiode1.n, Capacitor1.p) 
  annotation (Line(points={{0,50},{20,50}}, color={0,0,255}));
  connect(HeatingDiode1.heatPort, ThermalConductor1.port_a) 
                                                          annotation (Line(
        points={{-10,40},{-10,0},{-20,0}}, color={191,0,0}));
  connect(ThermalConductor1.port_b, HeatCapacitor1.port) 
                                                       annotation (Line(points={{-20,-20}, 
          {-20,-25.75},{-20,-40}}, color={191,0,0}));
  connect(R.p, Capacitor1.p) 
  annotation (Line(points={{20,80},{20,50}}, color={0,0,255}));
  connect(R.n, Capacitor1.n) 
  annotation (Line(points={{40,80},{40,50}}, color={0,0,255}));

annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Text(
          extent={{-94,102},{0,74}}, 
          textString="HeatingRectifier", 
          textColor={0,0,255})}), 
                                Documentation(info="<html><p>
在电容器充电时，整流器产生的热量可以被检测或者观察到。
</p>
<p>
示例的仿真时间为5秒。用户可在“仿真--仿真浏览器”中勾选相应的“仿真结果变量”查看示例相关变量的图像。
</p>
</html>",revisions="<html>
<p><strong>版本信息：</strong></p>
<ul>
<li><em>2004/5/6   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>"), experiment(StopTime=5));
end HeatingRectifier;