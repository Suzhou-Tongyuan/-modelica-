within Modelica.Electrical.Polyphase.Examples.Utilities;
model AnalysatorDC "分析直流电压、电流和功率"
  extends Icons.RoundSensor;
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter SI.Frequency f=50 "电网频率";
  Analog.Interfaces.NegativePin nv "负电气引脚" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput pDC(unit="W") "平均功率" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        origin={-110,-60})));
  Modelica.Blocks.Interfaces.RealOutput iMean(unit="A") "平均电流" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput vMean(unit="V") "平均电压" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={60,-110})));
  Analog.Sensors.MultiSensor multiSensorDC annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Mean powerTotal(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-50,-30})));
  Modelica.Blocks.Math.Mean meanCurrent(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-20,-50})));
  Modelica.Blocks.Math.Mean meanVoltage(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={20,-50})));
equation
  connect(multiSensorDC.pc,multiSensorDC. pv) 
    annotation (Line(points={{-10,0},{-10,10},{0,10}}, color={0,0,255}));
  connect(multiSensorDC.nv, nv) 
    annotation (Line(points={{0,-10},{0,-100}}, color={0,0,255}));
  connect(powerTotal.y, pDC) annotation (Line(points={{-50,-41},{-50,-60},{-110,-60}}, 
                 color={0,0,127}));
  connect(multiSensorDC.power, powerTotal.u) 
    annotation (Line(points={{-11,-6},{-50,-6},{-50,-18}}, color={0,0,127}));
  connect(meanCurrent.y, iMean) annotation (Line(points={{-20,-61},{-20,-80},{-60, 
          -80},{-60,-110}}, color={0,0,127}));
  connect(multiSensorDC.i, meanCurrent.u) annotation (Line(points={{-6,-11},{-6, 
          -20},{-20,-20},{-20,-38}}, color={0,0,127}));
  connect(multiSensorDC.v, meanVoltage.u) annotation (Line(points={{6,-11},{6,-20}, 
          {20,-20},{20,-38}}, color={0,0,127}));
  connect(meanVoltage.y, vMean) annotation (Line(points={{20,-61},{20,-80},{60,-80}, 
          {60,-110}}, color={0,0,127}));
  connect(multiSensorDC.pc, p) 
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(multiSensorDC.nc, n) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (Icon(graphics={
        Text(
          extent={{-152,80},{148,120}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-100,-40},{-60,-80}}, 
            textColor={64,64,64}, 
            textString="W"), 
        Text(
          extent={{-80,-60},{-40,-100}}, 
            textColor={64,64,64}, 
            textString="A"), 
        Text(
          extent={{40,-60},{80,-100}}, 
            textColor={64,64,64}, 
            textString="V")}), Documentation(info="<html>
<p>
提供一个周期内的平均值：
</p>
<ul>
<li>功率</li>
<li>电压</li>
<li>电流</li>
</ul>
</html>"));
end AnalysatorDC;