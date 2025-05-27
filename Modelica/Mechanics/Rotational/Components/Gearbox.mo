within Modelica.Mechanics.Rotational.Components;
model Gearbox "齿轮箱的实际模型(基于LossyGear模型)"
  extends Modelica.Mechanics.Rotational.Icons.Gearbox;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport;

  parameter Real ratio(start=1) 
    "传动比（flange_a.phi/flange_b.phi）";
  parameter Real lossTable[:, 5]=[0, 1, 1, 0, 0] 
    "根据速度的齿轮网效率和轴承摩擦的数组（参见LossyGear的文档）";
  parameter SI.RotationalSpringConstant c(final min=Modelica.Constants.small, 
      start=1.0e5) "齿轮弹性（弹簧常数）";
  parameter SI.RotationalDampingConstant d(final min=0, start=0) 
    "齿轮阻尼（相对阻尼）";
  parameter SI.Angle b(final min=0) = 0 "总游隙";
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用phi_rel和w_rel作为状态" 
    annotation (HideResult=true, Dialog(tab="高级"));
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(
      final T=293.15);
  SI.Angle phi_rel(
    start=0, 
    stateSelect=stateSelect, 
    nominal=1e-4) = flange_b.phi - lossyGear.flange_b.phi 
    "齿轮弹性上的相对旋转角度（= flange_b.phi - lossyGear.flange_b.phi）";
  SI.AngularVelocity w_rel(
    start=0, 
    stateSelect=stateSelect) = der(phi_rel) 
    "齿轮弹性上的相对角速度（= der(phi_rel)）";
  SI.AngularAcceleration a_rel(start=0) = der(w_rel) 
    "齿轮弹性上的相对角加速度（= der(w_rel)）";

  Rotational.Components.LossyGear lossyGear(
    final ratio=ratio, 
    final lossTable=lossTable, 
    final useSupport=true, 
    final useHeatPort=true) annotation (Placement(transformation(extent={{-60, 
            -20},{-20,20}})));
  Rotational.Components.ElastoBacklash elastoBacklash(
    final b=b, 
    final c=c, 
    final phi_rel0=0, 
    final d=d, 
    final useHeatPort=true) annotation (Placement(transformation(extent={{
            20,-20},{60,20}})));
equation
  connect(flange_a, lossyGear.flange_a) annotation (Line(points={{-100,0},{
          -90,0},{-90,0},{-80,0},{-80,0},{-60,0}}));
  connect(lossyGear.flange_b, elastoBacklash.flange_a) annotation (Line(
        points={{-20,0},{-10,0},{0,0},{20,0}}));
  connect(elastoBacklash.flange_b, flange_b) annotation (Line(points={{60,0}, 
          {70,0},{70,0},{80,0},{80,0},{100,0}}));
  connect(elastoBacklash.heatPort, internalHeatPort) annotation (Line(
      points={{20,-20},{20,-60},{-100,-60},{-100,-80}}, color={191,0,0}));
  connect(lossyGear.heatPort, internalHeatPort) annotation (Line(
      points={{-60,-20},{-60,-60},{-100,-60},{-100,-80}}, color={191,0,0}));
  connect(lossyGear.support, internalSupport) annotation (Line(
      points={{-40,-20},{-40,-40},{0,-40},{0,-80}}));
  annotation (
    Documentation(info="<html><p>
该组件模拟了齿轮箱的基本特性，特别是在如下组件中：
</p>
<ul><li>
组件<strong>lossyGear</strong> </li>
<li>
组件<strong>elastoBacklash</strong> </li>
</ul><p>
齿轮的惯性未被建模。如有必要，则惯性必须通过连接到齿轮箱组件的左侧和/或右侧接口的惯性模型组件来考虑。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}),graphics={Text(
              extent={{-150,150},{150,110}}, 
              textColor={0,0,255}, 
              textString="%name"),Text(
              extent={{-150,70},{150,100}}, 
              textString="ratio=%ratio, c=%c"),Line(
              visible=useHeatPort, 
              points={{-100,-100},{-100,-30},{0,-30}}, 
              color={191,0,0}, 
              pattern=LinePattern.Dot)}));
end Gearbox;