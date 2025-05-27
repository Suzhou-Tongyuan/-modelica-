within Modelica.Electrical.Analog.Examples;
model ShowSaturatingInductor 
  "简单演示饱和电感模型的工作特性"
  extends Modelica.Icons.Example;
  parameter SI.Inductance Lzer=2 "电流接近0时对应的电感";
  parameter SI.Inductance Lnom=1 
    "额定电流时的额定电感";
  parameter SI.Current Inom=1 "额定电感";
  parameter SI.Inductance Linf=0.5 "大电流下的电感";
  parameter SI.Voltage U=1.25 "电压源(峰值)";
  parameter SI.Frequency f=1/(2*Modelica.Constants.pi) 
    "交流电频率";
  parameter SI.Angle phase=Modelica.Constants.pi/2 
    "电压源的电压相移";
  //output SI.Voltage v "Voltage drop over saturating inductor";
  //output SI.Current i "Current across saturating inductor";
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(
    V=U, 
    phase=phase, 
    f=f) 
    annotation (Placement(transformation(
        origin={-60,-6}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground Ground1 
    annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
  Modelica.Electrical.Analog.Basic.SaturatingInductor SaturatingInductance1(
    Lzer=Lzer, 
    Lnom=Lnom, 
    Inom=Inom, 
    Linf=Linf, 
    i(fixed=true)) 
    annotation (Placement(transformation(
        origin={-20,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Basic.Inductor Inductance1(L=Lnom, i(fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={20,0})));
equation
  //v=SaturatingInductance1.v;
  //i=SaturatingInductance1.i;
  connect(SineVoltage1.n, Ground1.p) annotation (Line(points={{-60,-16},{-60, 
          -16}}, color={0,0,255}));
  connect(SineVoltage1.n, SaturatingInductance1.n) annotation (Line(points={{-60,-16}, 
          {-20,-16},{-20,-10}}, color={0,0,255}));
  connect(SaturatingInductance1.p, SineVoltage1.p) annotation (Line(points={{-20,10}, 
          {-20,20},{-60,20},{-60,4}}, color={0,0,255}));
  connect(Inductance1.p, SineVoltage1.p) annotation (Line(
      points={{20,10},{20,20},{-60,20},{-60,4}}, color={0,0,255}));
  connect(Inductance1.n, SineVoltage1.n) annotation (Line(
      points={{20,-10},{20,-16},{-60,-16}}, color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Text(
          extent={{-80,84},{70,38}}, 
          textColor={0,0,255}, 
          textString="Show Saturating Inductor")}), 
    experiment(StopTime=6.2832, Interval=0.01), 
    Documentation(info="<html>
<p>这个简单的回路使用了电感值会变化的饱和电感。</p>
<p>这个回路的仿真时间为1秒。用户可以通过比较<code>SaturatingInductance1.p.i</code>和<code>Inductance1.p.i</code>的数值查看饱和电感与理想电感之间的差异。</p>
</html>"));
end ShowSaturatingInductor;