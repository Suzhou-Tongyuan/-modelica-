within Modelica.Electrical.Analog.Semiconductors;
model Thyristor "简单晶闸管模型"
  parameter SI.Voltage VDRM(final min = 0) = 100 
    "正向击穿电压";
  parameter SI.Voltage VRRM(final min = 0) = 100 
    "反向击穿电压";
  parameter SI.Current IDRM = 0.1 "饱和电流";
  parameter SI.Voltage VTM = 1.7 "导通电压";
  parameter SI.Current IH = 6e-3 "保持电流";
  parameter SI.Current ITM = 25 "导通电流";

  parameter SI.Voltage VGT = 0.7 "门触发电压";
  parameter SI.Current IGT = 5e-3 "门触发电流";

  parameter SI.Time TON = 1e-6 "开关打开时间";
  parameter SI.Time TOFF = 15e-6 "开关闭合时间";
  parameter SI.Voltage Vt = 0.04 
    "等效温度电压(kT/qn)";
  parameter Real Nbv = 0.74 "反向穿透发射系数";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
  SI.Current iGK "Gate current";
  SI.Voltage vGK "Voltage between gate and cathode";
  SI.Voltage vAK "Voltage between anode and cathode";
  SI.Voltage vControl(start = 0);
  SI.Voltage vContot;
  SI.Voltage vConmain;

public
  Modelica.Electrical.Analog.Interfaces.PositivePin Anode annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin Cathode annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin Gate annotation(Placement(
    transformation(extent = {{90, 90}, {110, 110}}), iconTransformation(extent = {{90, 90}, {110, 110}})));

protected
  parameter SI.Voltage Von = 5;
  parameter SI.Voltage Voff = 1.5;
  parameter SI.Resistance Ron = (VTM - 0.7) / ITM 
    "正向导通模式电阻";
  parameter SI.Resistance Roff = (VDRM ^ 2) / VTM / IH 
    "阻塞模式电阻";

equation
  //Kirchhoff's equations
  Anode.i + Gate.i + Cathode.i = 0;
  vGK = Gate.v - Cathode.v;
  vAK = Anode.v - Cathode.v;

  // Gate and Control voltage
  iGK = Gate.i;
  vGK = smooth(0, (if vGK < 0.65 then VGT / IGT * iGK else 
    0.65 ^ 2 / VGT + iGK * (VGT - 0.65) / IGT));
  vContot = vConmain + smooth(0, if iGK < 0.95 * IGT then 0 else if iGK < 0.95 * IGT + 1e-3 then 10000 * (iGK - 0.95 * IGT) * vAK else 10 * vAK);
  der(vControl) = (vContot - vControl) / (if (vContot - vControl) > 0 then 1.87 * TON else 0.638 * TOFF);

  // Anode-Cathode characteristics
  Anode.i = smooth(1, if vAK < -VRRM then -VRRM / Roff * exp(-(vAK + VRRM) / (Nbv * Vt)) else 
    if vControl < Voff then vAK / Roff else 
    if vControl < Von then vAK / (sqrt(Ron * Roff) * (Ron / Roff) ^ ((3 * ((2 * vControl - Von - Voff) / (2 * (Von - Voff))) - 4 * ((2 * vControl - Von - Voff) / (2 * (Von - Voff))) ^ 3) / 2)) else 
    vAK / Ron);

  // holding effect and forward breakthrough
  vConmain = (if Anode.i > IH or vAK > VDRM then Von else 0);
  LossPower = Anode.i * Anode.v + Cathode.i * Cathode.v + Gate.i * Gate.v;
  annotation(
    Documentation(info = "<html>
<p>这是一个简单的三极管模型，它有三个接地：阳极、阴极和门。它有三种工作模式：导通、阻塞和反向通电。
</p>

<p>只要晶闸管处于阻断模式，它就表现为一个线性电阻 Roff=VDRM^2/(VTM*IH)。但是，如果阳极和阴极之间的电压超过了VDRM，或者正向门电流流动一段足够长的时间，晶闸管的模式就会转变为导通模式。晶闸管将保持在导通模式，直到阳极电流降至保持电流IH以下。没有办法通过门来关闭晶闸管。如果阳极和阴极之间的电压为负值，该模型将表示一个二极管(参数Vt、Nbv)，其具有反向击穿电压VRRM。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Semiconductors/Thyristor.png\"
     alt=\"Thyristor.png\">
</div>

<p>这个模型没有考虑dV/dt的开关作用。门电路对主电路没有影响。
</p>

</html>", 
    revisions = 
    "<html>
<ul>
<li><em>May 12, 2009   </em>
       by Matthias Franke
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Polygon(
    points = {{30, 0}, {-30, 40}, {-30, -40}, {30, 0}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-90, 0}, {40, 0}}, color = {0, 0, 255}), 
    Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), 
    Line(points = {{30, 40}, {30, -40}}, color = {0, 0, 255}), 
    Line(points = {{30, 20}, {100, 90}, {100, 100}}, 
    color = {0, 0, 255}), 
    Text(
    extent = {{-150, -40}, {150, -80}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end Thyristor;