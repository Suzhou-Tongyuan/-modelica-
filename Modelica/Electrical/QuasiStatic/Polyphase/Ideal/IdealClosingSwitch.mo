within Modelica.Electrical.QuasiStatic.Polyphase.Ideal;
model IdealClosingSwitch "多相理想闭合开关"
  extends QuasiStatic.Polyphase.Interfaces.TwoPlug;
  parameter SI.Resistance Ron[m](final min=zeros(m), start= 
        fill(1e-5, m)) "闭合状态的电阻";
  parameter SI.Conductance Goff[m](final min=zeros(m), start= 
        fill(1e-5, m)) "断开状态的导纳";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(
      final mh=m, final T=fill(293.15, m));
  Modelica.Blocks.Interfaces.BooleanInput control[m] 
    "true => p--n connected, false => switch open" annotation (Placement(
        transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  QuasiStatic.SinglePhase.Ideal.IdealClosingSwitch idealClosingSwitch[m](
    final Ron=Ron, 
    final Goff=Goff, 
    each final useHeatPort=useHeatPort) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(control, idealClosingSwitch.control) 
    annotation (Line(points={{0,120},{0,50},{0,12}}, color={255,0,255}));
  connect(idealClosingSwitch.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0}));
  connect(idealClosingSwitch.pin_p, plugToPins_p.pin_p) annotation (Line(
      points={{-10,0},{-68,0}}, color={85,170,255}));
  connect(idealClosingSwitch.pin_n, plugToPins_n.pin_n) annotation (Line(
      points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
  annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
                                   Line(points={{-90,0},{-44,0}}, color={85,170,255}), 
          Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170, 
          255}),Line(points={{-37,2},{40,40}}, color={85,170,255}), 
                                                      Line(points={{40,0},{
          90,0}}, color={85,170,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
              textString="%name", 
          textColor={0,0,255}), 
                Text(
              extent={{150,-80},{-150,-40}}, 
              textString="m=%m")}), Documentation(info="<html>
<p>
包含 m 个理想闭合开关（Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.IdealClosingSwitch）。
</p>
<p>
<strong>谨慎使用：</strong>
此开关仅用于结构变化，不用于快速开关序列，因为采用了准静态的模型。
</p>
</html>"));
end IdealClosingSwitch;