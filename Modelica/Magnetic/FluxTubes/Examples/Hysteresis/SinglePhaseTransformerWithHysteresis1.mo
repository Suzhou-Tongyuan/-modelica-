within Modelica.Magnetic.FluxTubes.Examples.Hysteresis;
model SinglePhaseTransformerWithHysteresis1
  extends Modelica.Icons.Example;
  Basic.Ground mag_ground 
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding1(N=10, i(fixed=true)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Basic.Ground el_ground1 
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=0.05) annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage vSource(f=400, V=8) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,0})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding2(N=10, i(fixed=true)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={30,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=2) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={62,20})));
  Modelica.Electrical.Analog.Basic.Ground el_ground2 
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Shapes.HysteresisAndMagnets.GenericHystTellinenTable core(
    asc(fixed=false), 
    mat=FluxTubes.Material.HysteresisTableData.M330_50A(), 
    includeEddyCurrents=true, 
    l=0.2, 
    A=5e-4, 
    MagRel(start=0.5, fixed=true)) 
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
initial equation
  core.derHstat = 0.0;
equation
  connect(winding1.port_n, mag_ground.port) annotation (Line(points={{-20,-10},{-20,-20},{0,-20}}, color={255,127,0}));
  connect(vSource.p, resistor1.p) annotation (Line(points={{-80,10},{-80,20},{-70,20}}, color={0,0,255}));
  connect(vSource.n, el_ground1.p) annotation (Line(points={{-80,-10},{-80,-20},{-60,-20}}, color={0,0,255}));
  connect(winding1.n, el_ground1.p) annotation (Line(points={{-40,-9.8},{-40,-20},{-60,-20}}, color={0,0,255}));
  connect(resistor1.n, winding1.p) annotation (Line(points={{-50,20},{-40,20},{-40,10}}, color={0,0,255}));
  connect(winding2.port_n, mag_ground.port) annotation (Line(points={{20,-10},{20,-20},{0,-20}}, color={255,127,0}));
  connect(winding2.p, resistor2.p) annotation (Line(points={{40,10},{40,20},{52,20}}, color={0,0,255}));
  connect(winding2.n, el_ground2.p) annotation (Line(points={{40,-9.8},{40,-20},{60,-20}}, color={0,0,255}));
  connect(resistor2.n, el_ground2.p) annotation (Line(points={{72,20},{80,20},{80,-20},{60,-20}}, color={0,0,255}));
  connect(winding1.port_p, core.port_p) annotation (Line(points={{-20,10},{-20,20},{-10,20}}, color={255,127,0}));
  connect(core.port_n, winding2.port_p) annotation (Line(points={{10,20},{20,20},{20,10}}, color={255,127,0}));
  annotation (experiment(StartTime=0, StopTime=0.02, Interval=4e-6, Tolerance=1e-006), Documentation(info="<html>
<p>
这个单相变压器的简单模型显示了由于铁芯材料（M330-50A）的剩磁而产生的浪涌电流。为了对铁芯材料进行精确建模，使用了 GenericHystTellinenTable 磁滞磁通管元件。磁芯组件的初始磁化 MagRel 设置为 80%。模拟设置:
</p>
<ul>
  <li>停止时间: 0.02 s</li>
  <li>间隔数: 5000</li>
  <li>容忍度: 1e-6</li>
</ul>
<p>
然后绘制磁芯 Core.B 的磁通密度与磁场强度 Core.H 的关系图，并绘制一次电流和二次电流的时间过程图，例如铁芯 Core.LossPower 的功耗图（见下图）。.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/SinglePhaseTransformerWithHysteresis1/plot01.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/SinglePhaseTransformerWithHysteresis1/plot02.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>

</html>"));
end SinglePhaseTransformerWithHysteresis1;