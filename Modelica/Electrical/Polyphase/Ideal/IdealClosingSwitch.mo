within Modelica.Electrical.Polyphase.Ideal;
model IdealClosingSwitch "多相理想闭合开关"
  extends Interfaces.TwoPlug; // 继承双插头接口
  parameter SI.Resistance Ron[m](final min=zeros(m), start= 
        fill(1e-5, m)) "闭合状态开关电阻";
  parameter SI.Conductance Goff[m](final min=zeros(m), start= 
        fill(1e-5, m)) "断开状态开关导纳";
  extends Polyphase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(
        293.15, m)); // 继承条件热端口接口
  Modelica.Blocks.Interfaces.BooleanInput control[m] 
    "true => 正负端连接, false => 开关打开" annotation (Placement(
        transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270))); // 控制输入
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch[m](
    final Ron=Ron, 
    final Goff=Goff, 
    each final useHeatPort=useHeatPort) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}))); // 理想闭合开关模型
equation
  connect(plug_p.pin, idealClosingSwitch.p) 
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255})); // 连接插头到开关的正端
  connect(idealClosingSwitch.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255})); // 连接开关的负端到插头
  connect(control, idealClosingSwitch.control) 
    annotation (Line(points={{0,120},{0,48},{0,12}}, color={255,0,255})); // 连接控制信号到开关控制端口
  connect(idealClosingSwitch.heatPort, heatPort) annotation (Line(
      points={{0,-10},{0,-100}}, color={191,0,0})); // 连接热端口
  annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-90,0},{-44,0}}, color={0,0,255}), 
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}), 
        Line(points={{-37,2},{40,40}}, color={0,0,255}), 
        Line(points={{40,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-80},{150,-40}}, 
          textString="m=%m")}), 
                              Documentation(info="<html>
<p>
包含m个理想闭合开关(Modelica.Electrical.Analog.Ideal.IdealClosingSwitch)。
</p><
</html>"));
end IdealClosingSwitch;