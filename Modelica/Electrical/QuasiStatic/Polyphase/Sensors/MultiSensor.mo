within Modelica.Electrical.QuasiStatic.Polyphase.Sensors;
model MultiSensor "用于测量电流、电压和功率的多相传感器"
  extends Modelica.Icons.RoundSensor;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  QuasiStatic.Polyphase.Interfaces.PositivePlug pc(final m=m) 
    "正极，电流路径" 
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug nc(final m=m) 
    "负极，电流路径" 
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  QuasiStatic.Polyphase.Interfaces.PositivePlug pv(final m=m) 
    "正极，电压路径" 
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug nv(final m=m) 
    "负极，电压路径" 
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput i[m](
    redeclare each final SI.Current re, redeclare each final SI.Current im) 
    "电流作为复合输出信号" annotation (Placement(transformation(
        origin={-60,-110}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v[m](
    redeclare each final SI.Voltage re, redeclare each final SI.Voltage im) 
    "电压作为复合输出信号" annotation (Placement(transformation(
        origin={60,-110}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower[m](
    redeclare each final SI.ActivePower re, redeclare each final SI.ReactivePower im) 
    "瞬时视在功率作为复合输出信号" annotation (Placement(transformation(
        origin={-110,-60}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPowerTotal(
    redeclare final SI.ActivePower re, redeclare final SI.ReactivePower im) 
    "瞬时视在功率之和作为复合输出信号" annotation (Placement(transformation(
        origin={110,-60}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  output SI.Current abs_i[m]=abs(i) "复合电流的绝对值";
  output SI.Angle arg_i[m]=arg(i) "复合电流的参数";
  output SI.Voltage abs_v[m]=abs(v) "复合电压的绝对值";
  output SI.Angle arg_v[m]=arg(v) "复合电压的参数";
  output SI.ApparentPower abs_apparentPower[m]=abs(apparentPower) "复合视在功率信号的绝对值";
  output SI.Angle arg_apparentPower[m]=arg(apparentPower) "复合视在功率信号的参数";
  output SI.ApparentPower abs_apparentPowerTotal=abs(apparentPowerTotal) "总复合视在功率的绝对值";
  output SI.Angle arg_apparentPowerTotal=arg(apparentPowerTotal) "总复合视在功率的参数";
  Modelica.ComplexBlocks.Interfaces.ComplexOutput temp[m](
      redeclare each final Modelica.Units.SI.Voltage re, redeclare each final Modelica.Units.SI.Voltage im);
equation
  Connections.branch(pc.reference, nc.reference);
  pc.reference.gamma = nc.reference.gamma;
  Connections.branch(pv.reference, nv.reference);
  pv.reference.gamma = nv.reference.gamma;
  Connections.branch(pc.reference, pv.reference);
  pc.reference.gamma = pv.reference.gamma;
  pc.pin.i + nc.pin.i = fill(Complex(0), m);
  pc.pin.v - nc.pin.v = fill(Complex(0), m);
  pv.pin.i = fill(Complex(0), m);
  nv.pin.i = fill(Complex(0), m);
  i = pc.pin.i;
  v = pv.pin.v - nv.pin.v;
  temp = conj(i);
    for j in 1:m loop
      apparentPower[j] = v[j] * temp[j];
    end for;
  //apparentPower = v.*conj(i);
  apparentPowerTotal = Complex(sum(apparentPower.re),sum(apparentPower.im));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,100},{0,70}}, color={85,170,255}), 
      Line(points = {{0,-70},{0,-100}}, color={85,170,255}), 
      Line(points = {{-100,0},{100,0}}, color={85,170,255}), 
      Line(points = {{0,70},{0,40}}), 
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
            textColor={64,64,64}), 
        Line(points={{100,-60},{80,-60},{56,-42}}, color={85,170,255}), 
        Text(
          extent={{-150,110},{150,150}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>这个多传感器用于测量多相系统的电流、电压和瞬时电功率，并具有分离的电压和电流路径。
电压路径的插头为pv和nv，电流路径的插头为pc和nc。
每个电流路径的内阻为零，每个电压路径的内阻为无穷大。</p>
<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">SinglePhase.Sensors.MultiSensor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor\">PowerSensor</a>
</p>
</html>",        revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
end MultiSensor;