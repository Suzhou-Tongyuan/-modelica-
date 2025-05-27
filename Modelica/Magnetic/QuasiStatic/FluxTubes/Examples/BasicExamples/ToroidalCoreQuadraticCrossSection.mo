within Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.BasicExamples;
model ToroidalCoreQuadraticCrossSection "教育示例：带气隙的铁芯"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Length r_o=0.055 "铁芯外半径";
  parameter SI.Length r_i=0.045 "铁芯内半径";
  parameter SI.Length l=0.01 "矩形截面长度";
  parameter SI.RelativePermeability mu_r=1000 "岩芯的相对渗透率";
  parameter SI.Length delta=0.001 "气隙长度";
  parameter SI.Angle alpha=(1 - delta/(2*pi*(r_o + r_i)/2))*2*pi "环形磁芯截面角";
  parameter Integer N=500 "励磁线圈匝数";
  parameter SI.Current I=1.5 "最大激励电流";
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.ElectroMagneticConverter excitingCoil(N=N) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.HollowCylinderCircumferentialFlux core(
    mu_rConst=mu_r, 
    l=l, 
    r_i=r_i, 
    r_o=r_o, 
    alpha=alpha) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        origin={0,30})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.HollowCylinderCircumferentialFlux airGap(
    mu_rConst=1, 
    l=l, 
    r_i=r_i, 
    r_o=r_o, 
    alpha=2*pi - alpha) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={0,-50})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.ElectroMagneticConverter measuringCoil(N=1) 
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground magneticGround 
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground electricGround1 
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource currentSource(gamma(fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-60,0})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.MagneticFluxSensor magFluxSensor 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={-20,-30})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground electricGround2 
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={60,0})));
  Blocks.Sources.Constant const(k=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,30})));
  ComplexBlocks.Sources.ComplexRampPhasor complexRamp(
    magnitude1=0, 
    magnitude2=I, 
    phi=0, 
    startTime=0.01, 
    duration=0.015) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,-30})));
equation
  connect(excitingCoil.port_n, magFluxSensor.port_n) 
    annotation (Line(points={{-20,-10},{-20,-20}}, color={255,127,0}));
  connect(magFluxSensor.port_p, magneticGround.port) 
    annotation (Line(points={{-20,-40},{-20,-50}}, color={255,127,0}));
  connect(magneticGround.port, airGap.port_n) 
    annotation (Line(points={{-20,-50},{-10,-50}}, color={255,127,0}));
  connect(excitingCoil.port_p, core.port_p) 
    annotation (Line(points={{-20,10},{-20,30},{-10,30}}, color={255,127,0}));
  connect(currentSource.pin_n, excitingCoil.pin_p) annotation (Line(points={{-60,10},{-40,10}}, color={85,170,255}));
  connect(currentSource.pin_p, electricGround1.pin) annotation (Line(points={{-60,-10},{-50,-10}}, color={85,170,255}));
  connect(electricGround1.pin, excitingCoil.pin_n) annotation (Line(points={{-50,-10},{-40,-10}}, color={85,170,255}));
  connect(electricGround2.pin, voltageSensor.pin_n) annotation (Line(points={{50,-10},{60,-10}}, color={85,170,255}));
  connect(const.y, currentSource.f) annotation (Line(points={{-80,19},{-80,6},{-72,6}}, color={0,0,127}));
  connect(complexRamp.y, currentSource.I) annotation (Line(points={{-80,-19},{-80,-6},{-72,-6}}, color={85,170,255}));
  connect(measuringCoil.pin_n, electricGround2.pin) annotation (Line(points={{40,-10},{50,-10}}, color={85,170,255}));
  connect(measuringCoil.pin_p, voltageSensor.pin_p) annotation (Line(points={{40,10},{50,10},{50,10},{60,10}}, color={85,170,255}));
  connect(core.port_n, measuringCoil.port_p) annotation (Line(points={{10,30},{20,30},{20,10}}, color={255,170,85}));
  connect(airGap.port_p, measuringCoil.port_n) annotation (Line(points={{10,-50},{20,-50},{20,-10}}, color={255,170,85}));
  annotation (Documentation(info="<html>
<p>
包含矩形截面环形铁芯和气隙的磁路教育示例:
</p>
<p>
通过激励线圈施加正电方向的电流斜坡，导致电磁转换器正磁场方向的磁动力（mmf）上升。
毫米波反过来又导致磁通量沿着磁通量传感器指示的方向通过电路。
根据该磁通量，可以计算出磁路中每个元件的磁通密度。磁通密度用于推导磁场强度。
磁场强度乘以磁通量线的长度就得出了每个元件的磁势差。
所有磁势差的总和由激励线圈的毫米波覆盖.
</p>
<p>
使用参数部分所示的数值，可以很容易地通过分析计算验证结果:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>元素   </th><th>横截面</th><th>长度                         </th><th>rel. permeability </th><th>B                   </th><th>H                                    </th><th>mmf              </th></tr>
<tr><td>core      </td><td>(r_o - r_i)*l</td><td>(r_o + r_i)/2*alpha             </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>airgap    </td><td>(r_o - r_i)*l</td><td>delta=(r_o + r_i)/2*(2*pi-alpha)</td><td>1</td><td>flux / cross section</td><td>B/(&mu;<sub>0</sub>)</td><td>H*delta         </td></tr>
<tr><td>total     </td><td>             </td><td>                               </td><td>                  </td><td>                    </td><td>                                     </td><td>&Sigma; mmf = N*I</td></tr>
</table>
<p>
请注意，由于不存在漏磁，每个元件的磁通量都是相同的 - 它们是串联连接的。
在计算磁通量线的长度时，使用中等磁通量线.
</p>
<p>
此外，气隙中还放置了一个测量线圈。
根据法拉第定律，磁通量的时间导数会在激励线圈（正方向）和测量线圈（负方向）中产生感应电压。
由于准静态电流和磁通量随时间变化，因此准静态感应电压也随时间变化。.
</p>
<p>
注意正确使用电场和磁场来定义零电势.
</p>
</html>"), experiment(StopTime=0.05, Interval=0.0001));
end ToroidalCoreQuadraticCrossSection;