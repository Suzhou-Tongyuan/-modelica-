within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model QuadraticCoreAirgap "教育示例：带气隙的铁芯"
  extends Modelica.Icons.Example;
  parameter SI.Length l=0.1 "铁芯外长";
  parameter SI.Length a=0.01 "正方形截面的边长";
  parameter Real mu_r=1000 "岩芯的相对渗透率";
  parameter SI.Length delta=0.001 "气隙长度";
  parameter Real sigma=0.1 "泄漏系数";
  parameter Integer N=500 "激励线圈匝数";
  parameter SI.Current I=1.5 "最大激励电流";
  Basic.ElectroMagneticConverter excitingCoil(N=N) 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Shapes.FixedShape.Cuboid leftLeg(
    nonLinearPermeability=false, 
    mu_rConst=mu_r, 
    l=l - a, 
    a=a, 
    b=a)                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-30,30})));
  Shapes.FixedShape.Cuboid upperYoke(
    nonLinearPermeability=false, 
    mu_rConst=mu_r, 
    l=l - a, 
    a=a, 
    b=a) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={0,50})));
  Shapes.FixedShape.Cuboid rightLeg(
    nonLinearPermeability=false, 
    mu_rConst=mu_r, 
    l=l - a - delta, 
    a=a, 
    b=a)                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={30,30})));
  Shapes.FixedShape.Cuboid airGap(
    nonLinearPermeability=false, 
    mu_rConst=1, 
    l=delta, 
    a=a, 
    b=a) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={30,-30})));
  Basic.ElectroMagneticConverter measuringCoil(N=1) 
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  Shapes.FixedShape.Cuboid lowerYoke(
    nonLinearPermeability=false, 
    mu_rConst=mu_r, 
    l=l - a, 
    a=a, 
    b=a) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        origin={0,-50})));
  Basic.Ground magneticGround 
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Electrical.Analog.Basic.Ground electricGround1 
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Electrical.Analog.Sources.RampCurrent rampCurrent(
    I=I, 
    duration=0.015, 
    startTime=0.01)                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-70,0})));
  Sensors.MagneticFluxSensor magFluxSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={-30,-30})));
  Electrical.Analog.Basic.Ground electricGround2 
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={70,0})));
  Basic.LeakageWithCoefficient leakage(c_usefulFlux=1 - sigma, G_m(start = 1e-8)) 
                                                         annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Blocks.Sources.RealExpression usefulReluctance(y=1/airGap.G_m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={20,-20})));
equation
  connect(excitingCoil.port_p, leftLeg.port_p) 
    annotation (Line(points={{-30,10},{-30,20}}, color={255,127,0}));
  connect(leftLeg.port_n, upperYoke.port_p) 
    annotation (Line(points={{-30,40},{-30,50},{-10,50}}, color={255,127,0}));
  connect(upperYoke.port_n, rightLeg.port_p) 
    annotation (Line(points={{10,50},{30,50},{30,40}}, color={255,127,0}));
  connect(rightLeg.port_n, measuringCoil.port_p) 
    annotation (Line(points={{30,20},{30,10}}, color={255,127,0}));
  connect(measuringCoil.port_n, airGap.port_p) 
    annotation (Line(points={{30,-10},{30,-20}}, color={255,127,0}));
  connect(lowerYoke.port_p, airGap.port_n) 
    annotation (Line(points={{10,-50},{30,-50},{30,-40}}, color={255,127,0}));
  connect(lowerYoke.port_n, magneticGround.port) 
    annotation (Line(points={{-10,-50},{-30,-50}}, color={255,127,0}));
  connect(electricGround1.p, excitingCoil.n) 
    annotation (Line(points={{-60,-10},{-50,-10}}, color={0,0,255}));
  connect(rampCurrent.p, electricGround1.p) 
    annotation (Line(points={{-70,-10},{-60,-10}}, color={0,0,255}));
  connect(rampCurrent.n, excitingCoil.p) 
    annotation (Line(points={{-70,10},{-50,10}}, color={0,0,255}));
  connect(measuringCoil.n, electricGround2.p) 
    annotation (Line(points={{50,-10},{60,-10}}, color={0,0,255}));
  connect(measuringCoil.p, voltageSensor.p) 
    annotation (Line(points={{50,10},{70,10}}, color={0,0,255}));
  connect(electricGround2.p, voltageSensor.n) 
    annotation (Line(points={{60,-10},{70,-10}}, color={0,0,255}));
  connect(excitingCoil.port_n, magFluxSensor.port_n) 
    annotation (Line(points={{-30,-10},{-30,-20}}, color={255,127,0}));
  connect(magFluxSensor.port_p, magneticGround.port) 
    annotation (Line(points={{-30,-40},{-30,-50}}, color={255,127,0}));
  connect(leakage.port_n, airGap.port_n) annotation (Line(points={{0, 
          -10},{0,-10},{0,-40},{30,-40}}, color={255,127,0}));
  connect(measuringCoil.port_p, leakage.port_p) 
    annotation (Line(points={{30,10},{0,10}}, color={255,127,0}));
  connect(leakage.R_mUsefulTot, usefulReluctance.y) 
    annotation (Line(points={{12,0},{20,0},{20,-9}}, color={0,0,127}));
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
所有磁势差的总和由激励线圈的毫米波覆盖.
</p>
<p>
利用参数值，可以通过分析计算验证结果:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>元素   </th><th>横截面</th><th>距离       </th><th>rel. permeability </th><th>B                   </th><th>H                                    </th><th>mmf              </th></tr>
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
<li>通过气隙的有用通量和</li>
<li>通过泄漏元件的泄漏通量.</li>
</ul>
<p>
然而，穿过气隙的磁电压和泄漏模型是相等的。
有用通量与堆芯内通量之比等于<code>1 - &sigma;</code>。
在磁芯中，由于每个元件串联在一起，所以它们的磁通量是相同的。
为了计算磁芯内磁通线的长度，使用了一条中等磁通线(虚线).
</p>
<p>
另外，在气隙中放置一个测量线圈。
根据法拉第定律，磁通的时间导数在激励线圈(正方向)和测量线圈(负方向)中都产生感应电压。
由于电流和磁通是线性时间依赖性斜坡，感应电压在斜坡期间是恒定的，否则为零。
请注意，由于磁场强度和磁通密度之间的非线性关系，使用非线性磁性材料会改变结果。
</p>
<p>
注意正确使用电场和磁场来定义零电势.
</p>
</html>"), experiment(StopTime=0.05, Interval=0.0001));
end QuadraticCoreAirgap;