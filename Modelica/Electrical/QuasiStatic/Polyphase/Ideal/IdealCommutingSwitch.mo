﻿within Modelica.Electrical.QuasiStatic.Polyphase.Ideal;
model IdealCommutingSwitch "多相理想切换开关"
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  parameter SI.Resistance Ron[m](final min=zeros(m), start= 
        fill(1e-5, m)) "闭合状态的电阻";
  parameter SI.Conductance Goff[m](final min=zeros(m), start= 
        fill(1e-5, m)) "断开状态的导纳";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, final T=fill(293.15, m));
  Modelica.Blocks.Interfaces.BooleanInput control[m] 
    "true => p--n2 连接，false => p--n1 连接" annotation (
      Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  QuasiStatic.Polyphase.Interfaces.PositivePlug plug_p(final m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug plug_n2(final m=m) 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug plug_n1(final m=m) annotation (
      Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(
          extent={{90,30},{110,50}})));
  QuasiStatic.SinglePhase.Ideal.IdealCommutingSwitch idealCommutingSwitch[m](
    final Ron=Ron, 
    final Goff=Goff, 
    each final useHeatPort=useHeatPort) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  QuasiStatic.Polyphase.Basic.PlugToPins_p plugToPins_p(final m=m) 
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  QuasiStatic.Polyphase.Basic.PlugToPins_n plugToPins_n1(final m=m) annotation (
     Placement(transformation(
        origin={80,60}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  QuasiStatic.Polyphase.Basic.PlugToPins_n plugToPins_n2(final m=m) annotation (
     Placement(transformation(
        origin={80,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
equation
  connect(control, idealCommutingSwitch.control) 
    annotation (Line(points={{0,120},{0,48},{0,12}}, color={255,0,255}));
  connect(idealCommutingSwitch.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  connect(plugToPins_n1.plug_n, plug_n1) annotation (Line(
      points={{82,60},{92,60},{92,40},{100,40}}, color={85,170,255}));
  connect(plugToPins_n2.plug_n, plug_n2) annotation (Line(
      points={{82,0},{90,0},{90,0},{100,0}}, color={85,170,255}));
  connect(plugToPins_n2.pin_n, idealCommutingSwitch.n2) annotation (Line(
      points={{78,0},{44,0},{44,0},{10,0}}, color={85,170,255}));
  connect(idealCommutingSwitch.n1, plugToPins_n1.pin_n) annotation (Line(
      points={{10,4},{10,60},{78,60}}, color={85,170,255}));
  connect(plugToPins_p.plug_p, plug_p) annotation (Line(
      points={{-82,0},{-100,0}}, color={85,170,255}));
  connect(idealCommutingSwitch.p, plugToPins_p.pin_p) annotation (Line(
      points={{-10,0},{-78,0}}, color={85,170,255}));
  annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
                               Ellipse(extent={{-44,4},{-36,-4}}, lineColor= 
           {85,170,255}),Line(points={{-90,0},{-44,0}}, color={85,170,255}), 
          Line(points={{-37,2},{40,40}}, color={85,170,255}),Line(points={{40,40},{90,40}}, 
                           color={85,170,255}), 
                              Line(points={{40,0},{90,0}}, color={85,170,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
              textString="%name", 
          textColor={0,0,255}), 
                Text(
              extent={{150,-80},{-150,-40}}, 
              textString="m=%m")}), Documentation(info="<html>
<p>
包含 m 个单相理想对换开关（Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.IdealCommutingSwitch）。
</p>
<p>
<strong>谨慎使用：</strong>
此开关仅用于结构变化，不用于快速开关序列，因为采用了准静态的模型。
</p>
</html>"));
end IdealCommutingSwitch;