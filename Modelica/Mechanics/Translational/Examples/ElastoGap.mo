within Modelica.Mechanics.Translational.Examples;
model ElastoGap "演示ElastoGap的使用"
  extends Modelica.Icons.Example;
  Components.Fixed fixed 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Components.Rod rod1(L=2) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Components.Rod rod2(L=2) 
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Components.SpringDamper springDamper1(
    c=10, 
    s_rel0=1, 
    s_rel(fixed=false, start=1), 
    d=1.5) 
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Components.SpringDamper springDamper2(
    c=10, 
    s_rel0=1, 
    s_rel(fixed=false, start=1), 
    d=1.5) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Components.Mass mass1(
    s(fixed=true, start=2), 
    L=0, 
    m=1, 
    v(fixed=true)) 
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Components.ElastoGap elastoGap1(
    c=10, 
    s_rel(fixed=false, start=1.5), 
    s_rel0=1.5, 
    d=1.5) 
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Components.ElastoGap elastoGap2(
    c=10, 
    s_rel(fixed=false, start=1.5), 
    s_rel0=1.5, 
    d=1.5) 
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Components.Mass mass2(
    s(fixed=true, start=2), 
    L=0, 
    m=1, 
    v(fixed=true)) 
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  parameter SI.TranslationalDampingConstant d=1.5 "阻尼常数";
equation

  connect(rod1.flange_b, fixed.flange) annotation (Line(
      points={{-20,0},{0,0}}, color={0,127,0}));
  connect(fixed.flange, rod2.flange_a) annotation (Line(
      points={{0,0},{20,0}}, color={0,127,0}));
  connect(springDamper1.flange_a, rod1.flange_a) annotation (Line(
      points={{-40,30},{-50,30},{-50,0},{-40,0}}, color={0,127,0}));
  connect(springDamper2.flange_b, rod2.flange_b) annotation (Line(
      points={{40,30},{50,30},{50,0},{40,0}}, color={0,127,0}));
  connect(springDamper1.flange_b, mass1.flange_a) annotation (Line(
      points={{-20,30},{-10,30}}, color={0,127,0}));
  connect(mass1.flange_b, springDamper2.flange_a) annotation (Line(
      points={{10,30},{20,30}}, color={0,127,0}));
  connect(rod1.flange_a, elastoGap1.flange_a) annotation (Line(
      points={{-40,0},{-50,0},{-50,-30},{-40,-30}}, color={0,127,0}));
  connect(rod2.flange_b, elastoGap2.flange_b) annotation (Line(
      points={{40,0},{50,0},{50,-30},{40,-30}}, color={0,127,0}));
  connect(elastoGap1.flange_b, mass2.flange_a) annotation (Line(
      points={{-20,-30},{-10,-30}}, color={0,127,0}));
  connect(mass2.flange_b, elastoGap2.flange_a) annotation (Line(
      points={{10,-30},{20,-30}}, color={0,127,0}));
  annotation (
    experiment(StopTime=5, Interval=0.01), 
    Documentation(info="<html>
<p>
这个模型演示了ElastoGaps对特征频率的影响：
绘制mass1.s和mass2.s以及mass1.v和mass2.v可以看到这种效应。
</p>
<p>
虽然mass1一直受到弹簧/阻尼力的作用，但mass2并非如此，
因为elastoGap1在 s&nbsp;&gt;&nbsp;-0.5米时升起，而elastoGap2在 s&nbsp;&lt;&nbsp;+0.5 米时升起。
因此，只要 -0.5&nbsp;米&nbsp;&lt;&nbsp;s&nbsp;&lt;&nbsp;+0.5&nbsp;米，mass2 就可以自由移动。
</p>
</html>"));
end ElastoGap;