within Modelica.Magnetic.FluxTubes.Examples.BasicExamples;
model SaturatedInductor "铁磁磁芯饱和电感器"
  extends Modelica.Icons.Example;

  FluxTubes.Basic.Ground ground_m annotation (Placement(transformation(
          extent={{50,-30},{70,-10}})));
  Modelica.Electrical.Analog.Sources.SineVoltage source(
    f=50, 
    phase=pi/2, 
    V=230*sqrt(2)) "Voltage applied to inductor" annotation (Placement(
        transformation(
        origin={-80,10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor r(R=7.5) 
    "电感器线圈电阻" annotation (Placement(transformation(extent= 
            {{-61,10},{-41,30}})));
  FluxTubes.Basic.ElectroMagneticConverter coil(N=600, i(fixed=true)) 
    "电感器线圈" annotation (Placement(transformation(extent={{-30,0},{-10, 
            20}})));
  Basic.ConstantReluctance r_mLeak(R_m=1.2e6) "恒定漏磁阻" 
    annotation (Placement(transformation(
        origin={10,10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Shapes.FixedShape.Cuboid r_mAirPar(
    a=0.025, 
    b=0.025, 
    nonLinearPermeability=false, 
    mu_rConst=1, 
    l=0.0001) 
    "小寄生气隙的磁阻（由单片铁磁磁芯封装而成）" 
    annotation (Placement(transformation(extent={{26,10},{46,30}})));
  Shapes.FixedShape.Cuboid r_mFe(
    mu_rConst=1000, 
    a=0.025, 
    b=0.025, 
    nonLinearPermeability=true, 
    l=4*0.065, 
    material= 
        Material.SoftMagnetic.ElectricSheet.M350_50A(), 
    B(start=0)) "Reluctance of ferromagnetic inductor core" annotation (
      Placement(transformation(
        origin={60,10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-30},{-70,-10}})));

equation
  connect(source.p, r.p) 
    annotation (Line(points={{-80,20},{-61,20}}, color={0,0,255}));
  connect(r.n, coil.p) annotation (Line(points={{-41,20},{-30,20},{-30,20}}, color={0,0,255}));
  connect(source.n, coil.n) 
    annotation (Line(points={{-80,0},{-30,0},{-30,0}}, color={0,0,255}));
  connect(coil.port_p, r_mLeak.port_p) annotation (Line(points={{-10,20},{-10,20},{10,20}}, 
                            color={255,127,0}));
  connect(r_mLeak.port_p, r_mAirPar.port_p) 
    annotation (Line(points={{10,20},{26,20}}, color={255,127,0}));
  connect(r_mAirPar.port_n, r_mFe.port_p) 
    annotation (Line(points={{46,20},{54,20},{60,20}}, color={255,127,0}));
  connect(r_mFe.port_n, r_mLeak.port_n) annotation (Line(points={{60,0},{
          47.5,0},{35,0},{10,0}}, color={255,127,0}));
  connect(r_mFe.port_n, coil.port_n) 
    annotation (Line(points={{60,0},{-10,0},{-10,0}}, color={255,127,0}));
  connect(ground.p, source.n) annotation (Line(
      points={{-80,-10},{-80,0}}, color={0,0,255}));
  connect(ground_m.port, r_mFe.port_n) annotation (Line(
      points={{60,-10},{60,0}}, color={255,127,0}));
  annotation (experiment(StopTime=0.1, Tolerance=1e-007), Documentation(
        info="<html>
<p>
该模型展示了软磁材料非线性磁化特性的影响(忽略磁滞)。将正弦波电压加到具有矩形封闭铁磁磁芯的电感器上。将<strong>容差</strong>设置为<strong>1e-7</strong>， <strong>模拟0.1 s</strong>并绘图为例:
</p>

<blockquote><pre>
coil.i vs. time           // 由于铁芯材料饱和而产生的非谐波电流
r_mFe.mu_r vs. r_mFe.B    // 相对渗透率与岩心内磁通密度
r_mFe.B vs. r_mFe.H       // 磁化曲线B(H);滞后被忽视
</pre></blockquote>

<p>
代表铁磁磁芯的磁通管元件的磁化特性可以很容易地从简化的线性行为(非线性磁导率设为false和R_mFe)改变。mu_rConst设置为正值，最好是mu_rConst >> 1)到非线性行为(例如，在 <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">Material. SoftMagnetic</a>，非线性磁导率设为true)。这使得在非线性行为模拟之前，可以方便地对具有线性材料特性的磁路进行初始设计.
</p>

<h4>注释</h4>

<p>
如果电源电压在 t=0 时加到电感器上有一个零交叉点（即源相位设置为零，而不是 &pi;/2），则可以观察到典型的电感负载开关浪涌电流.
</p>
</html>"));
end SaturatedInductor;