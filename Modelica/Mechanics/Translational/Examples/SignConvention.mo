within Modelica.Mechanics.Translational.Examples;
model SignConvention "用于所用符号约定的示例"
  extends Modelica.Icons.Example;
  Translational.Components.Mass mass1(
    L=1, 
    s(fixed=true), 
    v(fixed=true), 
    m=1) annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Translational.Sources.Force force1 annotation (Placement(transformation(
          extent={{0,60},{20,80}})));
  Modelica.Blocks.Sources.Constant constant1(k=1) annotation (Placement(
        transformation(extent={{-40,60},{-20,80}})));
  Translational.Components.Mass mass2(
    L=1, 
    s(fixed=true), 
    v(fixed=true), 
    m=1) annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Translational.Sources.Force force2 annotation (Placement(transformation(
          extent={{0,20},{20,40}})));
  Modelica.Blocks.Sources.Constant constant2(k=1) annotation (Placement(
        transformation(extent={{-40,20},{-20,40}})));
  Translational.Components.Mass mass3(
    L=1, 
    s(fixed=true), 
    v(fixed=true), 
    m=1) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Translational.Sources.Force force3(useSupport=false) 
                                                      annotation (Placement(
        transformation(extent={{20,-40},{0,-20}})));
  Modelica.Blocks.Sources.Constant constant3(k=1) annotation (Placement(
        transformation(extent={{60,-40},{40,-20}})));
  Translational.Components.Fixed fixed 
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
equation
  connect(constant1.y, force1.f) 
    annotation (Line(points={{-19,70},{-2,70}}, color={0,0,127}));
  connect(constant2.y, force2.f) 
    annotation (Line(points={{-19,30},{-2,30}}, color={0,0,127}));
  connect(constant3.y, force3.f) 
    annotation (Line(points={{39,-30},{22,-30}}, color={0,0,127}));
  connect(force1.flange, mass1.flange_a) annotation (Line(
      points={{20,70},{40,70}}, color={0,127,0}));
  connect(force2.flange, mass2.flange_b) annotation (Line(
      points={{20,30},{70,30},{70,10},{60,10}}, color={0,127,0}));
  connect(mass3.flange_b, force3.flange) annotation (Line(
      points={{-20,-30},{0,-30}}, color={0,127,0}));
  connect(fixed.flange, force3.support) annotation (Line(
      points={{10,-50},{10,-40}}, color={0,127,0}));
  annotation (
    Documentation(info="<html>
<p>
如果所有箭头指向同一方向，则为正力。
将导致正加速度&nbsp;<var>a</var>、速度&nbsp;<var>v</var> 和位置&nbsp;<var>s</var>。
</p>
<p>
对于1&nbsp;N 的力和1&nbsp;kg 的质量，这导致
</p>
<blockquote><pre>
a = 1 m/s2
v = 1 m/s，after 1 s (SlidingMass1.v)
s = 0.5 m， afeter 1 s (SlidingMass1.s)
</pre></blockquote>
<p>
加速度不可用于绘图。
</p>
<p>
系统 1) 和 2) 是等效的。无论力是在系统 1 中向 flange_a 推动，还是在系统 2 中向 flange_b 拉动，都没有关系。
</p><p>
当然，可以忽略箭头，并以任意方式连接模型。但是这样很难看出力的作用方向。
</p><p>
在第三个系统中，两个箭头相反，这意味着力的作用方向相反 (与另外两个示例中的方向相同)。
</p>
</html>"), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}),graphics={Text(
              extent={{-100,80},{-82,60}}, 
              textString="1)", 
              lineColor={0,0,255}),Text(
              extent={{-100,40},{-82,20}}, 
              textString="2)", 
              lineColor={0,0,255}),Text(
              extent={{-100,-20},{-82,-40}}, 
              textString="3)", 
              lineColor={0,0,255})}), 
    experiment(StopTime=1.0, Interval=0.001));
end SignConvention;