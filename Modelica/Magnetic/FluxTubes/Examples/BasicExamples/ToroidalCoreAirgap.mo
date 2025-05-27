within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model ToroidalCoreAirgap "教育示例：带气隙的铁芯"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Length r=0.05 "铁芯中间半径";
  parameter SI.Length d=0.01 "圆柱截面直径";
  parameter SI.RelativePermeability mu_r=1000 "岩芯的相对渗透率";
  parameter SI.Length delta=0.001 "气隙长度";
  parameter SI.Angle alpha=(1 - delta/(2*pi*r))*2*pi "环形磁芯截面角";
  parameter Integer N=500 "励磁线圈匝数";
  parameter SI.Current I=1.5 "最大激励电流";
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter excitingCoil(N=N) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Shapes.FixedShape.Toroid core(
    nonLinearPermeability=false, 
    mu_rConst=mu_r, 
    r=r, 
    d=d, 
    alpha=alpha) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={0,30})));
  Shapes.FixedShape.Toroid                             airGap(
    nonLinearPermeability=false, 
    mu_rConst=1, 
    r=r, 
    d=d, 
    alpha=2*pi - alpha) 
         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={0,-50})));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter measuringCoil(N=1) 
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground magneticGround 
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Modelica.Electrical.Analog.Basic.Ground electricGround1 
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
    I=I, 
    duration=0.015, 
    startTime=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-60,0})));
  Modelica.Magnetic.FluxTubes.Sensors.MagneticFluxSensor magFluxSensor 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={-20,-30})));
  Modelica.Electrical.Analog.Basic.Ground electricGround2 
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={60,0})));
equation
  connect(core.port_n, measuringCoil.port_p) 
    annotation (Line(points={{10,30},{20,30},{20,10}}, color={255,127,0}));
  connect(measuringCoil.port_n, airGap.port_p) 
    annotation (Line(points={{20,-10},{20,-50},{10,-50}}, 
                                                 color={255,127,0}));
  connect(electricGround1.p, excitingCoil.n) 
    annotation (Line(points={{-50,-10},{-40,-10}}, color={0,0,255}));
  connect(rampCurrent.p, electricGround1.p) 
    annotation (Line(points={{-60,-10},{-50,-10}}, color={0,0,255}));
  connect(rampCurrent.n, excitingCoil.p) 
    annotation (Line(points={{-60,10},{-40,10}}, color={0,0,255}));
  connect(measuringCoil.n, electricGround2.p) 
    annotation (Line(points={{40,-10},{50,-10}}, color={0,0,255}));
  connect(measuringCoil.p, voltageSensor.p) 
    annotation (Line(points={{40,10},{60,10}}, color={0,0,255}));
  connect(electricGround2.p, voltageSensor.n) 
    annotation (Line(points={{50,-10},{60,-10}}, color={0,0,255}));
  connect(excitingCoil.port_n, magFluxSensor.port_n) 
    annotation (Line(points={{-20,-10},{-20,-20}}, color={255,127,0}));
  connect(magFluxSensor.port_p, magneticGround.port) 
    annotation (Line(points={{-20,-40},{-20,-50}}, color={255,127,0}));
  connect(magneticGround.port, airGap.port_n) 
    annotation (Line(points={{-20,-50},{-10,-50}}, color={255,127,0}));
  connect(excitingCoil.port_p, core.port_p) 
    annotation (Line(points={{-20,10},{-20,30},{-10,30}}, color={255,127,0}));
  annotation (Documentation(info="<html>
<p>
包含圆形截面环形铁芯和气隙的磁路教育示例:
</p>
<p>
通过激励线圈施加正电方向的电流斜坡，导致电磁转换器正磁场方向的磁动力（mmf）上升。
毫米波反过来又导致磁通量沿着磁通量传感器指示的方向通过电路。
根据该磁通量，可以计算出磁路中每个元件的磁通密度。磁通密度用于推导磁场强度。
磁场强度乘以磁通线的长度就得出了每个元件的磁势差。
所有磁势差的总和由激励线圈的毫米波覆盖.
</p>
<p>
使用 \"参数 \"部分所示的数值，可以通过分析计算轻松验证结果:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>元素   </th><th>横截面     </th><th>距离             </th><th>rel. permeability </th><th>B                   </th><th>H                                    </th><th>mmf              </th></tr>
<tr><td>core      </td><td>d<sup>2</sup>*pi/4</td><td>r*alpha             </td><td>&mu;<sub>r</sub>  </td><td>flux / cross section</td><td>B/(&mu;<sub>r</sub>*&mu;<sub>0</sub>)</td><td>H*length         </td></tr>
<tr><td>airgap    </td><td>d<sup>2</sup>*pi/4</td><td>delta=r*(2*pi-alpha)</td><td>1</td><td>flux / cross section</td><td>B/(&mu;<sub>0</sub>)</td><td>H*delta         </td></tr>
<tr><td>total     </td><td>                  </td><td>                   </td><td>                  </td><td>                    </td><td>                                     </td><td>&Sigma; mmf = N*I</td></tr>
</table>
<p>
请注意，由于不存在漏磁，每个元件的磁通量都是相同的 - 它们是串联连接的。
在计算磁通量线的长度时，使用位于环形线圈中间的磁通量线.
</p>
<p>
此外，气隙中还放置了一个测量线圈。
根据法拉第定律，磁通量的时间导数会在激励线圈（正方向）和测量线圈（负方向）中产生感应电压。
由于电流是以与时间相关的线性斜坡形式给出的，因此斜坡期间的感应电压是恒定的，否则为零。
请注意，由于磁场强度和磁通密度之间的非线性关系，使用非线性磁性材料会改变这一结果.
</p>
<p>
注意正确使用电场和磁场来定义零电势.
</p>
</html>"), experiment(StopTime=0.05, Interval=0.0001));
end ToroidalCoreAirgap;