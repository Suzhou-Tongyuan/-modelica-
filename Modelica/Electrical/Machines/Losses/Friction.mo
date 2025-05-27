within Modelica.Electrical.Machines.Losses;
model Friction "角速度相关摩擦损耗模型"
  extends Machines.Interfaces.FlangeSupport;
  parameter FrictionParameters frictionParameters 
    "摩擦损耗参数";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
equation
  if (frictionParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -(if noEvent(abs(w)>frictionParameters.wLinear) then 
      frictionParameters.tauRef*sign(w)*(abs(w)/frictionParameters.wRef)^frictionParameters.power_w else 
      frictionParameters.tauLinear*w/frictionParameters.wLinear);
  end if;
  lossPower = -tau*w;
  annotation (Icon(graphics={
        Ellipse(
          extent={{-60,60},{60,-60}}, 
          fillColor={175,175,175}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,50},{50,-50}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-12,50},{8,30}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={135,135,135}), 
        Ellipse(
          extent={{-10,-30},{10,-50}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={135,135,135}), 
        Ellipse(
          extent={{24,-10},{44,-30}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={135,135,135}), 
        Ellipse(
          extent={{22,34},{42,14}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={135,135,135}), 
        Ellipse(
          extent={{-44,30},{-24,10}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={135,135,135}), 
        Ellipse(
          extent={{-44,-12},{-24,-32}}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={135,135,135}), 
        Ellipse(
          extent={{-30,30},{30,-30}}, 
          fillColor={175,175,175}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-20,20},{20,-20}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          visible=useHeatPort, 
          points={{-40,0},{-100,0},{-100,-90}}, 
          color={255,0,0}), 
        Line(
          points={{0,90},{0,0}}, 
          color={95,95,95}), 
        Line(
          points={{0,-60},{0,-90}}, 
          color={95,95,95}), 
        Text(
          extent={{-150,90},{150,60}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
<p>
摩擦损耗由以下方程式考虑
</p>
<blockquote><pre>
  tau/tauRef=(+w/wRef)^power_w    对于 w&gt;+wLinear
- tau/tauRef=(-w/wRef)^power_w    对于 w&lt;-wLinear
</pre></blockquote>
<p>
其中
</p>
<blockquote><pre>
tauRef*wRef=PRef
</pre></blockquote>
<p>
是参考角速度<code>wRef</code>下的摩擦转矩。
指数<code>power_w</code>对于轴向通风约为1.5，对于径向通风约为2.0。
</p>
<p>
出于稳定性考虑，摩擦转矩<code>tau</code>由线性曲线近似
</p>
<blockquote><pre>
tau/tauLinear=w/wLinear
</pre></blockquote>
<p>
其中
</p>
<blockquote><pre>
tauLinear=tauRef*(wLinear/wRef)^power_w
</pre></blockquote>
<p>
在<code>-wLinear&le;w&le;wLinear</code>的范围内，其中<code>wLinear=0.001*wRef</code>。扭矩与角速度的关系如图1所示
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/frictiontorque.png\"
                alt=\"frictiontorque.png\"> </td>
  </tr>
  <tr><td> <strong> Fig.1: </strong>摩擦损耗转矩与角速度关系，<code>power_w=2</code></td>
  </tr>
</table>
<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.FrictionParameters\">FrictionParameters</a>
</p>
<p>
如果想忽略摩擦损耗，将<code>frictionParameters.PRef=0</code>(默认值)。
</p>
</html>"));
end Friction;