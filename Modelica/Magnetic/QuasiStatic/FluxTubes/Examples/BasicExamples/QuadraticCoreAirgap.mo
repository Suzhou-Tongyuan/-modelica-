within Modelica.Magnetic.QuasiStatic.FluxTubes.Examples.BasicExamples;
model QuadraticCoreAirgap "教育示例：带气隙的铁芯"
  extends Modelica.Icons.Example;

  parameter SI.Length l=0.1 "铁芯外长";
  parameter SI.Length a=0.01 "正方形截面的边长";
  parameter Real mu_r=1000 "岩芯的相对渗透率";
  parameter SI.Length delta=0.001 "气隙长度";
  parameter Real sigma=0.1 "泄漏系数";
  parameter Integer N=500 "励磁线圈匝数";
  parameter SI.Current I=1.5 "最大激励电流";
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.ElectroMagneticConverter excitingCoil(N=N) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.Cuboid leftLeg(
    mu_rConst=mu_r, 
    l=l - a, 
    a=a, 
    b=a) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-20,30})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.Cuboid upperYoke(
    mu_rConst=mu_r, 
    l=l - a, 
    a=a, 
    b=a) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={10,50})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.Cuboid rightLeg(
    mu_rConst=mu_r, 
    l=l - a - delta, 
    a=a, 
    b=a) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,30})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.Cuboid airGap(
    mu_rConst=1, 
    l=delta, 
    a=a, 
    b=a) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,-30})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.ElectroMagneticConverter measuringCoil(N=1) annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape.Cuboid lowerYoke(
    mu_rConst=mu_r, 
    l=l - a, 
    a=a, 
    b=a) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        origin={10,-50})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.Ground magneticGround annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground electricGround1 annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sources.VariableCurrentSource currentSource(gamma(fixed=true, start=0)) 
                                                                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-60,0})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors.MagneticFluxSensor magFluxSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={-20,-30})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground electricGround2 annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={80,0})));
  Modelica.Magnetic.QuasiStatic.FluxTubes.Basic.LeakageWithCoefficient leakage(c_usefulFlux=1 - sigma, G_m(start = 1e-8)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={10,0})));
  Modelica.Blocks.Sources.RealExpression usefulReluctance(y=1/airGap.G_m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={30,-20})));
  Modelica.Blocks.Sources.Constant const(k=10.6103) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,30})));
  Modelica.ComplexBlocks.Sources.ComplexRampPhasor complexRamp(
    magnitude1=0, 
    magnitude2=I, 
    phi=0, 
    startTime=0.01, 
    duration=0.015) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,-30})));
equation
  connect(excitingCoil.port_p, leftLeg.port_p) 
    annotation (Line(points={{-20,10},{-20,20}}, color={255,127,0}));
  connect(leftLeg.port_n, upperYoke.port_p) 
    annotation (Line(points={{-20,40},{-20,50},{0,50}},   color={255,127,0}));
  connect(upperYoke.port_n, rightLeg.port_p) 
    annotation (Line(points={{20,50},{40,50},{40,40}}, color={255,127,0}));
  connect(rightLeg.port_n, measuringCoil.port_p) 
    annotation (Line(points={{40,20},{40,10}}, color={255,127,0}));
  connect(measuringCoil.port_n, airGap.port_p) 
    annotation (Line(points={{40,-10},{40,-20}}, color={255,127,0}));
  connect(lowerYoke.port_p, airGap.port_n) 
    annotation (Line(points={{20,-50},{40,-50},{40,-40}}, color={255,127,0}));
  connect(lowerYoke.port_n, magneticGround.port) 
    annotation (Line(points={{0,-50},{-20,-50}},   color={255,127,0}));
  connect(excitingCoil.port_n, magFluxSensor.port_n) 
    annotation (Line(points={{-20,-10},{-20,-20}}, color={255,127,0}));
  connect(magFluxSensor.port_p, magneticGround.port) 
    annotation (Line(points={{-20,-40},{-20,-50}}, color={255,127,0}));
  connect(leakage.port_n, airGap.port_n) annotation (Line(points={{10,-10},{10,-40},{40,-40}}, 
                                          color={255,127,0}));
  connect(measuringCoil.port_p, leakage.port_p) 
    annotation (Line(points={{40,10},{10,10}},color={255,127,0}));
  connect(leakage.R_mUsefulTot, usefulReluctance.y) 
    annotation (Line(points={{22,0},{30,0},{30,-9}}, color={0,0,127}));
  connect(currentSource.pin_n, excitingCoil.pin_p) annotation (Line(points={{-60,10},{-40,10}}, color={85,170,255}));
  connect(currentSource.pin_p, electricGround1.pin) annotation (Line(points={{-60,-10},{-50,-10}}, color={85,170,255}));
  connect(electricGround1.pin, excitingCoil.pin_n) annotation (Line(points={{-50,-10},{-40,-10}}, color={85,170,255}));
  connect(measuringCoil.pin_p, voltageSensor.pin_p) annotation (Line(points={{60,10},{80,10}}, color={85,170,255}));
  connect(measuringCoil.pin_n, electricGround2.pin) annotation (Line(points={{60,-10},{70,-10}}, color={85,170,255}));
  connect(electricGround2.pin, voltageSensor.pin_n) annotation (Line(points={{70,-10},{80,-10}}, color={85,170,255}));
  connect(const.y, currentSource.f) annotation (Line(points={{-80,19},{-80,6},{-72,6}}, color={0,0,127}));
  connect(complexRamp.y, currentSource.I) annotation (Line(points={{-80,-19},{-80,-6},{-72,-6}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
包含铁芯和气隙的磁路教育示例:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MagneticCircuit.png\" alt=\"Magnetic circuit with iron core and airgap\">
</div>
<p>
通过激励线圈施加正电方向的电流斜坡，导致电磁转换器正磁场方向的磁动力（mmf）上升。
毫米波反过来又导致磁通量沿着磁通量传感器指示的方向通过电路。
根据该磁通量，可以计算出磁路中每个元件的磁通密度。磁通密度用于推导磁场强度。
磁场强度乘以磁通线的长度就得出了每个元件的磁势差。
所有磁势差的总和就是励磁线圈的 mmf。
</p>
<p>
利用参数值，可以通过分析计算验证结果:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>元素   </th><th>横截面</th><th>length       </th><th>rel. permeability </th><th>B                   </th><th>H                                    </th><th>mmf              </th></tr>
<tr><td>left leg  </td><td>a*a          </td><td>l - a        </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>upper yoke</td><td>a*a          </td><td>l - a        </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>right leg </td><td>a*a          </td><td>l - a - delta</td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>airgap    </td><td>a*a          </td><td>delta        </td><td>1                 </td><td>useful flux / cross section</td><td>B/&mu;<sub>0</sub>            </td><td>H*length         </td></tr>
<tr><td>lower yoke</td><td>a*a          </td><td>l - a        </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>total     </td><td>             </td><td>             </td><td>                  </td><td>                    </td><td>                                     </td><td>&Sigma; mmf = N*I</td></tr>
</table>
<p>
请注意，存在漏磁通路径。因此，磁芯的总磁通分为
</p>
<ul>
<li>通过气隙的有用通量，以及</li>
<li>通过泄漏元件的泄漏通量.</li>
</ul>
<p>
然而，穿过气隙的磁电压和泄漏模型是相等的。
有用通量与堆芯内通量之比等于<code>1 - &sigma;</code>。
在磁芯中，由于每个元件串联在一起，所以它们的磁通量是相同的。
为了计算磁芯内磁通线的长度，使用了一条中等磁通线(虚线)
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
end QuadraticCoreAirgap;