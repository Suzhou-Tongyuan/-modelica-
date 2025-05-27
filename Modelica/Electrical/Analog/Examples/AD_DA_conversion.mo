within Modelica.Electrical.Analog.Examples;
model AD_DA_conversion "转换电路"
  extends Modelica.Icons.Example;
  parameter Integer N=7 "数字信号位宽";
  Modelica.Electrical.Analog.Ideal.AD_Converter aD_Converter(N=N, 
    Rin=1000000, 
    VRefLow=0, 
    VRefHigh=10) 
    annotation (Placement(transformation(extent={{-14,-10},{12,16}})));
  Modelica.Electrical.Digital.Sources.Pulse pulse(
    pulse=Modelica.Electrical.Digital.Interfaces.Logic.'1', 
    quiet=Modelica.Electrical.Digital.Interfaces.Logic.'0', 
    nperiod=-1, 
    width=1, 
    period=0.001, 
    startTime=0) 
             annotation (Placement(transformation(extent={{-32,32},{-12,52}})));
  Modelica.Electrical.Analog.Ideal.DA_Converter dA_Converter(N=N, Vref=10) 
    annotation (Placement(transformation(extent={{18,-10},{44,16}})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{44,-40},{64,-20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(
    V=5, 
    f=10, 
    offset=5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,4})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1) 
    annotation (Placement(transformation(extent={{-28,68},{-8,88}})));
equation
  connect(pulse.y, aD_Converter.trig) annotation (Line(
      points={{-12,42},{-1,42},{-1,14.7}}, color={127,0,127}));
  connect(sineVoltage.p, aD_Converter.p) annotation (Line(
      points={{-80,14},{-38.5,14},{-38.5,12.1},{-10.1,12.1}}, color={0,0,255}));
  connect(sineVoltage.n, aD_Converter.n) annotation (Line(
      points={{-80,-6},{-38,-6},{-38,-6.1},{-10.1,-6.1}}, color={0,0,255}));
  connect(ground.p, sineVoltage.n) annotation (Line(
      points={{54,-20},{-80,-20},{-80,-6}}, color={0,0,255}));
  connect(sineVoltage.p, resistor.p) annotation (Line(
      points={{-80,14},{-80,78},{-28,78}}, color={0,0,255}));
  connect(dA_Converter.trig, pulse.y) annotation (Line(
      points={{31,14.7},{31,42},{-12,42}}, color={127,0,127}));
  connect(aD_Converter.y, dA_Converter.x) annotation (Line(
      points={{8.1,3},{21.9,3}}, color={127,0,127}));
  connect(dA_Converter.p, resistor.n) annotation (Line(
      points={{40.1,12.1},{40.1,78},{-8,78}}, color={0,0,255}));
  connect(dA_Converter.n, ground.p) annotation (Line(
      points={{40.1,-6.1},{54,-6.1},{54,-20}}, color={0,0,255}));
  annotation (experiment(StopTime=0.2), 
    Documentation(info="<html>
<p>该简易转换器电路将一个模拟正弦信号转换成一个N位的逻辑信号(默认情况下为4位)，然后再将其反向转换回模拟信号。</p>
<ul>
<li>示例的仿真</li>
</ul>
<p>用户可在“仿真--仿真浏览器”中勾选相应的“仿真结果变量”查看示例的输入电压(aD_Converter.p.v)和输出电压(dA_Converter.p.v)。当修改“组件参数窗口”的参数N后，用户可通过仿真观察到数字信号宽度的变化。或者换一种方法，在“仿真--仿真结果变量”窗口处修改pulse.period的数值后，用户也可以通过这样的修改观察到数字信号宽度的变化。</p>
</html>", revisions="<html>
<ul>
<li><em>2009/10/13  </em>by Matthias Franke</li>
</ul>
</html>"));
end AD_DA_conversion;