within Modelica.Electrical.Machines.Losses.InductionMachines;
model Core "铁芯损耗模型"
  parameter Machines.Losses.CoreParameters coreParameters(m=3) 
    "铁芯参数";
  //for backwards compatibility present but unused
  final parameter Integer m=coreParameters.m "相数" annotation(Evaluate=true);
  parameter Real turnsRatio(final min=Modelica.Constants.small) 
    "定子有效匝数/转子有效匝数(如果用作转子铁芯)";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  Machines.Interfaces.SpacePhasor spacePhasor annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent= 
           {{-110,-10},{-90,10}})));
  input SI.AngularVelocity w 
    "磁化角速度" annotation (Dialog(group="Losses"));
  SI.Conductance Gc "变化的铁芯损耗导纳";
protected
  SI.AngularVelocity wLimit=noEvent(max(noEvent(abs(w)), 
      coreParameters.wMin)) "限制的角速度";
equation
  if (coreParameters.PRef <= 0) then
    Gc = 0;
    spacePhasor.i_ = zeros(2);
  else
    Gc = coreParameters.GcRef;
    //  * (coreParameters.wRef/wLimit*coreParameters.ratioHysteresis + 1 - coreParameters.ratioHysteresis);
    spacePhasor.i_ = Gc*spacePhasor.v_;
  end if;
  lossPower = 3/2*(+spacePhasor.v_[1]*spacePhasor.i_[1] + spacePhasor.v_[2]*spacePhasor.i_[2]);
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-70,0}}), 
        Line(points={{-70,10},{70,10}}, color={0,0,255}), 
        Line(points={{-70,-30},{70,-30}}, color={0,0,255}), 
        Line(points={{-70,-10},{70,-10}}, color={0,0,255}), 
        Line(
          points={{70,0},{80,0}}, 
          color={0,0,255}), 
        Line(
          points={{80,20},{80,-20}}, 
          color={0,0,255}), 
        Line(
          points={{90,14},{90,-14}}, 
          color={0,0,255}), 
        Line(
          points={{100,8},{100,-8}}, 
          color={0,0,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
<p>
铁芯损耗可以分为<strong>涡流</strong>和<strong>滞后</strong>损耗。总铁芯损耗可以表示为
</p>
<blockquote><pre>
P=PRef*(ratioHysteresis*(wRef/w)+1-ratioHysteresis)*(V/VRef)^2
</pre></blockquote>
<p>
其中<code>w</code>是实际的磁化角速度，<code>V</code>是实际的电压。
术语<code>ratioHysteresis</code>是滞后损耗与参考电压和频率的总铁芯损耗的比率。
</p>

<p>
在当前实现中，由于Modelica不提供复数，因此未考虑滞后损耗。
因此，隐含地设置<code>ratioHysteresis=0</code>。关于电压和频率范围，请参阅图 1，总铁芯损耗对参数<code>ratioHysteresis</code>的依赖性在图2中显示。
当前实现有以下缺点，相对于考虑<code>ratioHysteresis&gt;0</code>的模型：
</p>
<ul>
<li>低估了恒定磁场区域的损耗(<code>w</code>&lt;<code>wRef</code>)</li>
<li>高估了磁场削弱区域的损耗(<code>w</code>&gt;<code>wRef</code>)</li>
</ul>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesVw.png\"
                alt=\"corelossesVw.png\"> </td>
  </tr>
  <tr><td> <strong>图 1:</strong>电压与角速度</td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesPcw.png\"
                alt=\"corelossesPcw.png\"> </td>
  </tr>
  <tr><td> <strong>图 2:</strong>铁芯损耗与角速度的关系，参数为<code>ratioHysteresis</code></td>
  </tr>
</table>

<h4>注意</h4>
<p>在当前实现中，假设<code>ratioHysteresis=0</code>。 由于兼容性原因，无法更改此参数。</p>

<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.CoreParameters\">铁芯损耗参数</a>
</p>

</html>"));
end Core;