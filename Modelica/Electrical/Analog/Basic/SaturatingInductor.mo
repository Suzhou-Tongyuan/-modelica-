within Modelica.Electrical.Analog.Basic;
model SaturatingInductor "带饱和的简单电感模型"
  extends Modelica.Electrical.Analog.Interfaces.OnePort(i(start=0));
  import Modelica.Constants.pi;
  import Modelica.Constants.eps;
  import Modelica.Constants.small;
  import Modelica.Math.atan;
  parameter SI.Current Inom(start=1) "额定电流" annotation(Dialog(
    groupImage="modelica://Modelica/Resources/Images/Electrical/Analog/Basic/SaturatingInductor_Lact_i_tight.png"));
  parameter SI.Inductance Lnom(start=1) 
    "在额定电流下的额定电感";
  parameter SI.Inductance Lzer(start=2*Lnom) 
    "电流接近0时的电感";
  parameter SI.Inductance Linf(start=Lnom/2) 
    "大电流时的电感";
  SI.Inductance Lact(start=Lzer) "当前电感";
  SI.MagneticFlux Psi "当前磁通";
protected
  parameter SI.Current Ipar(start=Inom/10, fixed=false);
initial equation
  (Lnom - Linf)/(Lzer - Linf)=Ipar/Inom*(pi/2 - atan(Ipar/Inom));
equation
  assert(Lzer > Lnom*(1 + eps), "Lzer (= " + String(Lzer) + 
    ") 必须大于 Lnom (= " + String(Lnom) + ")");
  assert(Linf < Lnom*(1 - eps), "Linf (= " + String(Linf) + 
    ") 必须小于 Lnom (= " + String(Lnom) + ")");
  Lact = Linf + (Lzer - Linf)*(if noEvent(abs(i)/Ipar<small) then 1 else atan(i/Ipar)/(i/Ipar));
  Psi = Linf*i + (Lzer - Linf)*Ipar*atan(i/Ipar);
  v = der(Psi);
  annotation (defaultComponentName="inductor", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{60,0},{90,0}}, color={0,0,255}), 
        Line(points={{-90,0},{-60,0}}, color={0,0,255}), 
        Text(
          extent={{-150,-40},{150,-80}}, 
          textString="Lnom=%Lnom"), 
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-60,-20},{60,-20}}, color={0,0,255})}), 
    Documentation(info="<html>
<p>这个模型近似描述了具有饱和影响的电感的行为，即电感的值取决于通过电感的电流(<strong>图&nbsp;1</strong>)。
随着电流增加，电感减小。请注意，这里没有考虑滞后效应。
</p>

<p>
磁通链的近似是基于带有额外线性项的<code>atan</code>函数，如<strong>图&nbsp;2</strong>所示：</p>

<blockquote><pre>
Psi=Linf*i+(Lzer-Linf)*Ipar*atan(i/Ipar)
L=Psi/i=Linf+(Lzer-Linf)*atan(i/Ipar)/(i/Ipar)
</pre></blockquote>

<p>
这种近似性能良好，且易于根据给定特性进行调整，仅需四个参数(<strong>表&nbsp;1</strong>)。
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>表&nbsp;1:</strong> 饱和电感模型的特性参数</caption>
  <tr>
    <th>变量</th>
    <th>描述</th>
  </tr>
  <tr>
    <td><code>Inom</code></td>
    <td>额定电流</td>
  </tr>
  <tr>
    <td><code>Lnom</code></td>
    <td>额定电流下的额定电感</td>
  </tr>
  <tr>
    <td><code>Lzer</code></td>
    <td>电流接近0时的电感；<code>Lzer</code> 必须大于 <code>Lnom</code></td>
  </tr>
  <tr>
    <td><code>Linf</code></td>
    <td>大电流时的电感；<code>Linf</code> 必须小于 <code>Lnom</code></td>
  </tr>
</table>

<p>
参数<code>Ipar</code>是从以下关系内部计算的：</p>
<blockquote><pre>
Lnom=Linf+(Lzer-Linf)*atan(Inom/Ipar)/(Inom/Ipar)
</pre></blockquote>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>图&nbsp;1:</strong>实际电感<code>Lact</code> 与电流 <code>i</code> 的关系</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Basic/SaturatingInductor_Lact_i.png\" alt=\"Lact vs. i\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>图&nbsp;2:</strong>实际磁通链<code>Psi</code> 与电流 <code>i</code> 的关系</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Basic/SaturatingInductor_Psi_i.png\" alt=\"Psi vs. i\">
    </td>
  </tr>
</table>

<p>在<strong>图&nbsp;2</strong>中，磁通斜率等于小电流时的<code>Lzer</code>。
当电流<code>i</code>接近无穷大时，磁通斜率的极限为<code>Linf</code>。
额定磁通由额定电感<code>Lnom</code>和额定电流<code>Inom</code>的乘积表示。
</p>
</html>", 
        revisions="<html>
<dl>
  <dt><strong>主要作者:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  D-93049 RegensburgGermany<br>
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>版本说明:</strong></dt>
  <dd>2019年7月23日：由Anton Haumer改进</dd>
  <dd>2004年5月27日：由Anton Haumer实现</dd>
 </dl>
</html>"));
end SaturatingInductor;