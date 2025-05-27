within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model MultiSensor "用于测量电流、电压和功率的传感器"
  extends Modelica.Icons.RoundSensor;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  QuasiStatic.SinglePhase.Interfaces.PositivePin pc 
    "正引脚，电流路径" 
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin nc 
    "负引脚，电流路径" 
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  QuasiStatic.SinglePhase.Interfaces.PositivePin pv 
    "正引脚，电压路径" 
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin nv 
    "负引脚，电压路径" 
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput i(
    redeclare final SI.Current re, redeclare final SI.Current im) 
    "复数输出信号的电流" annotation (Placement(transformation(
        origin={-60,-110}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90), iconTransformation(
        extent={{10,10},{-10,-10}}, 
        rotation=90, 
        origin={-60,-110})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v(
    redeclare final SI.Voltage re, redeclare final SI.Voltage im) 
    "复数输出信号的电压" annotation (Placement(transformation(
        origin={60,-110}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90), iconTransformation(
        extent={{10,10},{-10,-10}}, 
        rotation=90, 
        origin={60,-110})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower(
    redeclare final SI.ActivePower re, redeclare final SI.ReactivePower im) 
    "瞬时视在功率的复数输出信号" annotation (Placement(transformation(
        origin={-110,-60}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180), iconTransformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={-110,-60})));
  output SI.Current abs_i=abs(i) "复数电流的绝对值";
  output SI.Angle arg_i=arg(i) "复数电流的幅角";
  output SI.Voltage abs_v=abs(v) "复数电压的绝对值";
  output SI.Angle arg_v=arg(v) "复数电压的幅角";
  output SI.ApparentPower abs_apparentPower=abs(apparentPower) "复数视在功率的绝对值";
  output SI.Angle arg_apparentPower=arg(apparentPower) "复数视在功率的幅角";
equation
  Connections.branch(pc.reference, nc.reference);
  pc.reference.gamma = nc.reference.gamma;
  Connections.branch(pv.reference, nv.reference);
  pv.reference.gamma = nv.reference.gamma;
  Connections.branch(pc.reference, pv.reference);
  pc.reference.gamma = pv.reference.gamma;
  pc.i + nc.i = Complex(0);
  pc.v - nc.v = Complex(0);
  pv.i = Complex(0);
  nv.i = Complex(0);
  i = pc.i;
  v = pv.v - nv.v;
  apparentPower = v*conj(i);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,100},{0,70}}, color={85,170,255}), 
      Line(points = {{0,-70},{0,-100}}, color={85,170,255}), 
      Line(points = {{-100,0},{100,0}}, color={85,170,255}), 
      Line(points = {{0,70},{0,40}}), 
        Text(
          extent={{-150,110},{150,150}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-100,-60},{-80,-60},{-56,-42}}, 
                                                   color={85,170,255}), 
        Line(points={{-60,-100},{-60,-80},{-42,-56}}, 
                                                   color={85,170,255}), 
        Line(points={{60,-100},{60,-80},{42,-56}}, 
                                                color={85,170,255}), 
        Text(
          extent={{-100,-20},{-60,-60}}, 
            textColor={64,64,64}, 
            textString="V.A"), 
        Text(
          extent={{-80,-60},{-40,-100}}, 
            textString="A", 
            textColor={64,64,64}), 
        Text(
          extent={{40,-60},{80,-100}}, 
            textString="V", 
            textColor={64,64,64})}), 
    Documentation(info="<html>
<p>这个多传感器用于测量单相系统的电流、电压和瞬时电功率，并具有分离的电压和电流路径。
电压路径的引脚是pv和nv，电流路径的引脚是pc和nc。
电流路径的内部电阻为零，电压路径的内部电阻为无穷大。</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
</p>
</html>", revisions="<html>
<ul>
<li><em>20170306</em> 由Anton Haumer首次实现</li>
</ul>
</html>"));
end MultiSensor;