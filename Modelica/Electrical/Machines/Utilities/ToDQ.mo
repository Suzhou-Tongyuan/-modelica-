within Modelica.Electrical.Machines.Utilities;
block ToDQ 
  "将瞬时定子输入转换为转子固定空间矢量"
  extends Modelica.Blocks.Interfaces.MIMO(final nin=m, final nout=2);
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  parameter Integer p "极对数";
  Modelica.Blocks.Math.Gain toGamma(final k=p) annotation (Placement(
        transformation(
        origin={0,-50}, 
        extent={{10,-10},{-10,10}}, 
        rotation=270)));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(
        transformation(
        origin={0,-120}, 
        extent={{20,-20},{-20,20}}, 
        rotation=270)));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor(final m=m) 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(phi, toGamma.u) 
    annotation (Line(points={{0,-120},{0,-120},{0,-62}}, color={0,0,127}));
  connect(rotator.angle, toGamma.y) 
    annotation (Line(points={{0,-12},{0,-39},{0,-39}}, color={0,0,127}));
  connect(toSpacePhasor.y, rotator.u) annotation (Line(
      points={{-39,0},{-12,0}}, color={0,0,127}));
  connect(u, toSpacePhasor.u) annotation (Line(
      points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(rotator.y, y) annotation (Line(
      points={{11,0},{110,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
将多相输入值<code>u[m]</code>转换为相应的空间矢量，然后使用提供的机械转子角度phi将其旋转到转子固定参考系中。输出结果是空间矢量的结果d和q分量，排列在一个向量<code>y[2]</code>中。
</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.FromDQ\">FromDQ</a>
</p>
</html>"));
end ToDQ;