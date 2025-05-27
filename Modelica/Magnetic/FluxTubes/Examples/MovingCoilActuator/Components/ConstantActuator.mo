within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components;
model ConstantActuator 
  "用于系统模拟的简单行为执行器模型"

  parameter SI.ElectricalForceConstant k=3.88 "转换器常数";
  parameter SI.Resistance R=2.86 "线圈电阻";
  parameter SI.Inductance L=0.0051 "中行程线圈电感";
  parameter SI.Mass m_a=0.012 "电枢质量" 
    annotation (Dialog(group="衔铁和塞子"));
  parameter SI.TranslationalSpringConstant c=1e11 
    "冲击副之间的弹簧刚度" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalDampingConstant d=400 
    "冲击副之间的阻尼系数" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_min=-4e-3 "电枢最小位置" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_max=4e-3 "电枢最大位置" 
    annotation (Dialog(group="Armature and stopper"));

  SI.Position x(start=x_min, stateSelect=StateSelect.prefer) 
    "电枢位置，法兰位置的别名";

  Modelica.Electrical.Analog.Basic.Resistor r(final R=R) 
    "线圈电阻" annotation (Placement(transformation(extent={{-90, 
            50},{-70,70}})));
  FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
    final m=m_a, 
    final x_max=x_max, 
    final x_min=x_min, 
    final L=0, 
    final c=c, 
    final d=d, 
    n=2) "Armature inertia with stoppers at end of stroke range" 
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Modelica.Electrical.Analog.Basic.Inductor l(final L=L) 
    "线圈电感" annotation (Placement(transformation(extent={{-60, 
            50},{-40,70}})));
  Modelica.Electrical.Analog.Basic.TranslationalEMF 
    electroTranslationalConverter(final k=k) annotation (Placement(
        transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p 
    "电气连接器" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n 
    "电气连接器" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange 
    "部件法兰" annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
equation
  flange.s = x;

  connect(r.p, p) 
    annotation (Line(points={{-90,60},{-100,60},{-100,100}}, 
                                                  color={0,0,255}));
  connect(l.p, r.n) 
    annotation (Line(points={{-60,60},{-70,60}}, color={0,0,255}));
  connect(armature.flange_b, flange) annotation (Line(points={{80,0},{
          85,0},{90,0},{100,0}}, color={0,127,0}));
  connect(l.n, electroTranslationalConverter.p) annotation (Line(points= 
         {{-40,60},{-30,60},{-30,10}}, color={0,0,255}));
  connect(n, electroTranslationalConverter.n) annotation (Line(points={{-100,-100},{-30,-100},{-30,-10}}, 
                                           color={0,0,255}));
  connect(electroTranslationalConverter.flange, armature.flange_a) 
    annotation (Line(points={{-20,0},{0,0},{20,0},{60,0}}, color={0,127, 
          0}));
  connect(p, p) annotation (Line(points={{-100,100},{-100,100}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={
            {-100,-100},{100,100}}), graphics={Rectangle(
                  extent={{-80,100},{80,-100}}, 
                  lineColor={255,128,0}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-70,80},{72,-80}}, 
                  textColor={255,128,0}, 
                  textString="c"),Line(points={{-90,100},{-80,100}}, 
          color={0,0,255}),Line(points={{-90,-100},{-80,-100}}, 
                                                              color={0,0,255}), 
          Line(points={{80,0},{90,0}}, color={0,127,0}),Text(
                  extent={{150,150},{-150,110}}, 
                  textColor={0,0,255}, 
                  textString="%name")}), Documentation(info="<html>
<p>
与旋转直流电机类似，移动线圈和移动磁铁型平移电动执行器和发电机的机电能量转换可用以下两个转换方程来描述:
</p>

<blockquote><pre>
  F = c * i
V_i = c * v
</pre></blockquote>

<p>
与电动力或<em>洛伦兹</em>力F，变换器常数c，电流i，感应反电动势V_i和电枢速度v，该模型非常类似于众所周知的旋转单相直流电机的行为模型，除了它是平移运动。对于在气隙中有线圈、磁通密度为B、磁场内总导线长度为l的动圈执行器，变换器常数为
</p>

<blockquote><pre>
c = B * l.
</pre></blockquote>

<p>
假设变换器常数c以及线圈电阻R和电感L是已知的，例如，从测量或目录数据。因此，该模型非常适合与邻近子系统一起进行系统仿真，但不适用于执行器设计，其中电机常数是根据磁路的几何形状，材料特性和绕组数据找到的。参见<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. PermeanceActuator\">PermeanceActuator</a>是基于磁网络的更精确的执行器模型。由于相同的连接器，这两个模型都可以用于系统仿真，例如模拟一个行程，如<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.ArmatureStroke\">ArmatureStroke</a>所示。
</p>
</html>"));
end ConstantActuator;