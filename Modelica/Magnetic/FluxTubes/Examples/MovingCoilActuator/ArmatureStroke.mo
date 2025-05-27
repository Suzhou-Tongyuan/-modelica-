within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator;
model ArmatureStroke 
  "两个动圈推杆模型在 t=0 时的电压阶跃后的电枢行程"

  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground pmGround annotation (Placement(
        transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Electrical.Analog.Sources.StepVoltage pmSource(startTime=0, V= 
        pmActuator.R*1.5) "Steady state current 1.5A" annotation (
      Placement(transformation(
        origin={-70,-30}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator pmActuator(
    material=Material.HardMagnetic.PlasticNdFeB(), 
    x(start=pmActuator.x_min, fixed=true), 
    armature(v(fixed=true)), 
    coil(i(fixed=true))) 
    "用磁导模型描述动圈传动器" annotation (
      Placement(transformation(extent={{-40,-40},{-20,-20}})));

  Modelica.Mechanics.Translational.Components.Mass pmLoad(m=0.05) 
    "除电枢质量外还需移动的负载" annotation (
      Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Electrical.Analog.Basic.Ground cGround annotation (Placement(
        transformation(extent={{-80,0},{-60,20}})));
  Modelica.Electrical.Analog.Sources.StepVoltage cSource(startTime=0, V= 
        cActuator.R*1.5) "Steady state current 1.5A" annotation (
      Placement(transformation(
        origin={-70,40}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator cActuator(
    x(start=cActuator.x_min, fixed=true), 
    armature(v(fixed=true)), 
    l(i(start=0, fixed=true))) 
    "用转换器常数描述动圈传动器" annotation (
      Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Mechanics.Translational.Components.Mass cLoad(m=0.05) 
    "除电枢质量外还需移动的负载" annotation (
      Placement(transformation(extent={{0,30},{20,50}})));
equation
  connect(pmLoad.flange_a, pmActuator.flange) 
    annotation (Line(points={{0,-30},{-20,-30}}, color={0,127,0}));
  connect(cGround.p, cSource.n) 
    annotation (Line(points={{-70,20},{-70,30}}, color={0,0,255}));
  connect(cLoad.flange_a, cActuator.flange) 
    annotation (Line(points={{0,40},{-20,40}}, color={0,127,0}));
  connect(cSource.p, cActuator.p) annotation (Line(points={{-70,50},{-56,50},{-56,50},{-40,50}}, 
                                  color={0,0,255}));
  connect(cSource.n, cActuator.n) annotation (Line(points={{-70,30},{-56,30},{-56,30},{-40,30}}, 
                                  color={0,0,255}));
  connect(pmSource.n, pmGround.p) 
    annotation (Line(points={{-70,-40},{-70,-50}}, color={0,0,255}));
  connect(pmSource.n, pmActuator.n) annotation (Line(points={{-70,-40},{-54,-40},{-54,-40},{-40,-40}}, 
                                     color={0,0,255}));
  connect(pmSource.p, pmActuator.p) annotation (Line(points={{-70,-20},{-55,-20},{-55,-20},{-40,-20}}, 
                                     color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Text(
                extent={{-98,98},{48,86}}, 
                textColor={0,0,255}, 
                textString= 
            "Comparison of a pull-in stroke of both converter models"), 
          Text( extent={{-98,90},{-30,80}}, 
                textColor={0,0,255}, 
                textString="after a voltage step at t=0")}), 
    experiment(StopTime=0.05, Tolerance=1e-007), 
    Documentation(info="<html>
<p>
看一下 <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a>和 <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a>
对于两个执行器模型的解释.</p>

<p>
时间t=0的电压阶跃应用于两个执行器模型。在每个模型中，电枢和附加的负载质量在cActuator中包含的两个止动器之间执行行程。电枢和永磁执行器。电枢。<strong>模拟0.05 s</strong>并绘制与时间的关系图(相同的物理量放在一个共同的图中进行比较):
</p>
<blockquote><pre>
cActuator.p.i                     // 转换器输入电流恒定模型
pmActuator.p.i                    // 渗透模型的输入电流
cActuator.armature.flange_a.f     // 变流器恒定模型的推杆力
pmActuator.armature.flange_a.f    // 渗透模型的推力
cActuator.x                       // 变流器恒定模型的电枢位置
pmActuator.x                      // 磁导模型的电枢位置
cActuator.L                       // 变流器电感恒定模型
pmActuator.L                      // 磁导模型的电感
</pre></blockquote>
<p>
两种推杆模型的初始电流上升都是由于推杆线圈的电感所致。电枢和负载加速后，电流因运动引起的反电势而下降。当两种型号的衔铁以最大衔铁位置到达限位器时，都会发生弹跳。在这个简单的例子中，由于没有任何形式的外部摩擦（除了止动器元件中的非线性阻尼），反弹相当剧烈。弹跳衰减后，两个推杆都在电枢闭锁的条件下运行.
</p>
<p>
虽然两种模型的稳态电流相同，但由于忽略了变流器恒定模型中的非线性力分量，稳态推杆力并不相同。两种模型电流上升的差异是由于在变流器常数模型中忽略了线圈电感的变化。.
</p>
</html>"));
end ArmatureStroke;