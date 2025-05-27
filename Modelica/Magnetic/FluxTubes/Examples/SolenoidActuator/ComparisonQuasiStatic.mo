within Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator;
model ComparisonQuasiStatic 
  "两个电磁线圈模型的电枢强制运动速度较慢，因此电磁场和电流都是准静态的"

  extends Modelica.Icons.Example;

  parameter SI.Voltage v_step=12 "应用电压";

  Modelica.Blocks.Sources.Ramp x_set(
    duration=10, 
    height=-(advancedSolenoid.x_max - advancedSolenoid.x_min), 
    offset=advancedSolenoid.x_max) 
    "指定电枢位置，从 x_max 到 x_min 的慢速强制运动" 
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Electrical.Analog.Basic.Ground advancedGround annotation (
      Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Electrical.Analog.Sources.StepVoltage advancedSource(V=v_step) 
    annotation (Placement(transformation(
        origin={-70,50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  FluxTubes.Examples.SolenoidActuator.Components.AdvancedSolenoid advancedSolenoid 
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Mechanics.Translational.Sources.Position advancedFeed_x(f_crit= 
       1000, exact=false) 
                         annotation (Placement(transformation(
        origin={0,50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Modelica.Electrical.Analog.Basic.Ground simpleGround annotation (
      Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Modelica.Electrical.Analog.Sources.StepVoltage simpleSource(V=v_step) 
    annotation (Placement(transformation(
        origin={-70,-50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  FluxTubes.Examples.SolenoidActuator.Components.SimpleSolenoid simpleSolenoid 
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Mechanics.Translational.Sources.Position simpleFeed_x(f_crit= 
        1000, exact=false) annotation (Placement(transformation(
        origin={0,-50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[0.00025,
        -85.8619, 0.00014821, 0.11954; 0.0005, -59.9662, 0.00013931,
        0.11004; 0.00075, -41.0806, 0.0001277, 0.098942; 0.001, -28.88,
        0.00011587, 0.088425; 0.00125, -21.4113, 0.00010643, 0.08015;
        0.0015, -16.8003, 9.9406e-005, 0.073992; 0.00175, -13.6942,
        9.3416e-005, 0.068792; 0.002, -11.1188, 8.8564e-005, 0.064492;
        0.00225, -9.6603, 8.4505e-005, 0.060917; 0.0025, -8.4835,
        8.1215e-005, 0.058017; 0.00275, -7.4658, 7.7881e-005, 0.055125;
        0.003, -6.5591, 7.5197e-005, 0.052733; 0.00325, -5.9706,
        7.2447e-005, 0.05035; 0.0035, -5.5013, 7.0342e-005, 0.048525;
        0.00375, -5.0469, 6.8527e-005, 0.046867; 0.004, -4.6573,
        6.6526e-005, 0.045158; 0.00425, -4.2977, 6.4425e-005, 0.043442;
        0.0045, -4.0912, 6.2747e-005, 0.04205; 0.00475, -3.7456,
        6.1231e-005, 0.040733; 0.005, -3.5869, 5.9691e-005, 0.039467]) 
    "Valid for u_source=12V only; column 1: position, col.2: force, col.3: armature flux, col.4: inductance" 
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(advancedGround.p, advancedSource.n) 
    annotation (Line(points={{-70,30},{-70,40}}, color={0,0,255}));
  connect(x_set.y, advancedFeed_x.s_ref) annotation (Line(points={{59,0}, 
          {20,0},{20,50},{12,50}}, color={0,0,127}));
  connect(simpleSolenoid.p, simpleSource.p) annotation (Line(points={{-40,-40},{-50,-40},{-50,-40},{-70,-40}}, 
                                               color={0,0,255}));
  connect(simpleSolenoid.n, simpleSource.n) annotation (Line(points={{-40,-60},{-50,-60},{-50,-60},{-70,-60}}, 
                                               color={0,0,255}));
  connect(simpleSolenoid.flange, simpleFeed_x.flange) 
    annotation (Line(points={{-20,-50},{-10,-50}}, color={0,127,0}));
  connect(advancedSolenoid.n, advancedSource.n) annotation (Line(points={{-40,40},{-50,40},{-50,40},{-70,40}}, 
                                                color={0,0,255}));
  connect(simpleFeed_x.s_ref, x_set.y) annotation (Line(points={{12,-50}, 
          {20,-50},{20,0},{59,0}}, color={0,0,127}));
  connect(x_set.y, comparisonWithFEA.u) annotation (Line(points={{59,0},{50,0},{50,50},{58,50}}, 
                                  color={0,0,127}));
  connect(advancedFeed_x.flange, advancedSolenoid.flange) 
    annotation (Line(points={{-10,50},{-20,50}}, color={0,127,0}));
  connect(advancedSource.p, advancedSolenoid.p) annotation (Line(points={{-70,60},{-50,60},{-50,60},{-40,60}}, 
                                                color={0,0,255}));
  connect(simpleGround.p, simpleSource.n) 
    annotation (Line(points={{-70,-70},{-70,-60}}, color={0,0,255}));
  annotation (experiment(StopTime=10, Tolerance=1e-007), Documentation(
        info="<html>
<p>
看看<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples. SolenoidActuator\">SolenoidActuator</a> 一般注释和 <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components. SimpleSolenoid\">SimpleSolenoid</a>和<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components. AdvancedSolenoid\">AdvancedSolenoid</a>磁网络模型的详细描述.
</p>

<p>
与实际推杆的静态力-行程测量类似，两种推杆模型的电枢在这里都被迫缓慢移动。因此，可以忽略线圈电感和衔铁运动引起的电气子系统的动态变化，从而获得静态力-冲程特性。为了说明整块磁网络模型的预期精度，我们将静态有限元分析获得的结果作为参考（与位置相关的力、电枢磁通和致动器电感）。请注意，这些参考值仅对默认电源电压 v_step=12V 直流有效!
</p>

<p>
设置<strong>容差</strong>为<strong>1e-7</strong>， <strong>模拟10秒</strong>。在一个公共窗口中绘制两种磁网模型的电磁力和有限元参考<strong>vs。电枢位置x_set.y</strong>:
</p>

<blockquote><pre>
simpleSolenoid.armature.flange_a.f     // 电磁力的简单磁网模型
advancedSolenoid.armature.flange_a.f   // 电磁力的先进磁网络模型
comparisonWithFEA.y[1]                 // 以有限元分析为参考得到电磁力
</pre></blockquote>

<p>
电磁力或磁阻力的作用方向总是减小气隙长度。在确定的电枢位置坐标 x 下，模型的力为负值.
</p>

<p>
通过电枢的磁通量和致动器的静态电感都说明了两种磁网络模型之间的差异。与力类似，在一个共同的绘图窗口中比较每个变量的这些量（绘图与电枢位置 x_set.y 的关系）:
</p>

<blockquote><pre>
simpleSolenoid.g_mFeArm.Phi            // 简单磁网络模型的电枢磁通
advancedSolenoid.g_mFeArm.Phi          // 先进磁网络模型的电枢磁通
comparisonWithFEA.y[2]                 // 以有限元分析为参考得到的磁通量

simpleSolenoid.coil.L_stat             // 简单磁网络模型的静态电感
advancedSolenoid.L_statTot             // 两部分线圈串联，采用先进的网络模式
comparisonWithFEA.y[3]                 // 静态电感以有限元法为参考
</pre></blockquote>

<p>
正如在两种磁网络模型的描述中所提到的，可以看出，在大气隙时，先进的电磁模型的电枢磁通和电感比简单模型高。这种差异对动态模型行为的影响可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.ComparisonPullInStroke\">ComparisonPullInStroke</a>中进行分析。
</p>
</html>"));
end ComparisonQuasiStatic;