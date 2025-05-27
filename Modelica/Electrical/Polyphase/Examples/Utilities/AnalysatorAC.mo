within Modelica.Electrical.Polyphase.Examples.Utilities;
model AnalysatorAC "分析交流电压、电流和功率"
  extends Icons.RoundSensor;
  extends Modelica.Electrical.Polyphase.Interfaces.TwoPlug;
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems;
  parameter SI.Frequency f=50 "电网频率";
  final parameter Integer mSystems=numberOfSymmetricBaseSystems(m) 
    "基本系统数量";
  final parameter Integer mBasic=integer(m/mSystems) 
    "基本系统的相数";
  final parameter Integer kPolygon=if m==2 then 1 else integer((mBasic - 1)/2) 
    "最大多边形电压的替代";
  Interfaces.NegativePlug plug_nv(final m=m) 
    "带有m个引脚的负极性多相电气插头" annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput pTotal(unit="W") "总功率，平均值"  annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={110,-60})));
  Modelica.Blocks.Interfaces.RealOutput iFeed[m](each unit="A") 
    "馈电电流的有效值，第一次谐波" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput vLL1[m](each unit="V") 
    "第一次谐波的线电压的有效值" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={-110,-60})));
  Modelica.Blocks.Interfaces.RealOutput vLN[m](each unit="V") 
    "第一次谐波的线到中性电压的有效值" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={60,-110})));
  Sensors.MultiSensor multiSensorAC(m=m) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Basic.MultiDelta multiDelta(m=m, kPolygon=kPolygon) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-90,30})));
  Sensors.VoltageSensor voltageSensor(m=m) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-70,30})));
  Modelica.Blocks.Math.Harmonic iH1[m](each f=f, each k=1) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=90, 
        origin={-20,-50})));
  Modelica.Blocks.Math.Harmonic vH1[m](each f=f, each k=1) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=90, 
        origin={20,-50})));
  Modelica.Blocks.Math.Mean powerTotal(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={50,-30})));
  Modelica.Blocks.Math.Harmonic voltageLine2Line[m](each f=f, each k=1) 
    "线电压" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-50,-30})));
equation
  connect(plug_p, multiSensorAC.pc) 
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(multiSensorAC.pc, multiSensorAC.pv) 
    annotation (Line(points={{-10,0},{-10,10},{0,10}}, color={0,0,255}));
  connect(multiSensorAC.nc, plug_n) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(multiSensorAC.nv, plug_nv) 
    annotation (Line(points={{0,-10},{0,-100}}, color={0,0,255}));
  connect(multiDelta.plug_p, voltageSensor.plug_p) 
    annotation (Line(points={{-90,20},{-70,20}}, color={0,0,255}));
  connect(multiDelta.plug_n, voltageSensor.plug_n) 
    annotation (Line(points={{-90,40},{-70,40}}, color={0,0,255}));
  connect(plug_p, multiDelta.plug_p) 
    annotation (Line(points={{-100,0},{-90,0},{-90,20}}, color={0,0,255}));
  connect(voltageLine2Line.y_rms, vLL1) annotation (Line(points={{-44,-41},{-44, 
          -60},{-110,-60}}, color={0,0,127}));
  connect(voltageSensor.v, voltageLine2Line.u) 
    annotation (Line(points={{-59,30},{-50,30},{-50,-18}}, color={0,0,127}));
  connect(multiSensorAC.powerTotal,powerTotal.u) 
    annotation (Line(points={{11,-6},{50,-6},{50,-18}}, color={0,0,127}));
  connect(powerTotal.y, pTotal) 
    annotation (Line(points={{50,-41},{50,-60},{110,-60}}, color={0,0,127}));
  connect(multiSensorAC.i, iH1.u) annotation (Line(points={{-6,-11},{-6,-20},{-20, 
          -20},{-20,-38}}, color={0,0,127}));
  connect(iH1.y_rms, iFeed) annotation (Line(points={{-14,-61},{-16,-61},{-16,-80}, 
          {-60,-80},{-60,-110}}, color={0,0,127}));
  connect(vH1.y_rms, vLN) annotation (Line(points={{26,-61},{26,-80},{60,-80},{60, 
          -110}}, color={0,0,127}));
  connect(multiSensorAC.v, vH1.u) annotation (Line(points={{6,-11},{6,-20},{20,-20}, 
          {20,-38}}, color={0,0,127}));
  annotation (Icon(graphics={
        Text(
          extent={{-152,80},{148,120}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{60,-40},{100,-80}}, 
            textColor={64,64,64}, 
            textString="W"), 
        Text(
          extent={{-80,-60},{-40,-100}}, 
            textColor={64,64,64}, 
            textString="A"), 
        Text(
          extent={{40,-60},{80,-100}}, 
            textColor={64,64,64}, 
            textString="V"), 
        Text(
          extent={{-100,-40},{-60,-80}}, 
            textColor={64,64,64}, 
          textString="V")}), Documentation(info="<html>
<p>
提供一个周期内总功率的平均值以及每个相的以下值：
</p>
<ul>
<li>线电压的第一次谐波的有效值</li>
<li>线到中性电压的第一次谐波的有效值</li>
<li>馈电电流的第一次谐波的有效值</li>
</ul>
</html>"));
end AnalysatorAC;