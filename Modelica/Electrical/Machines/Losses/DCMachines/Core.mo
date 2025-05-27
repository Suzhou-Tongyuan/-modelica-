within Modelica.Electrical.Machines.Losses.DCMachines;
model Core "核心损耗模型"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Machines.Losses.CoreParameters coreParameters(m=1) 
    "电枢核心损耗";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  input SI.AngularVelocity w 
    "再磁化角速度" annotation (Dialog(group="损耗"));
  SI.Conductance Gc "可变核心损耗导纳";
protected
  SI.AngularVelocity wLimit=noEvent(max(noEvent(abs(w)), 
      coreParameters.wMin)) "有限的角速度";
equation
  if (coreParameters.PRef <= 0) then
    Gc = 0;
    i = 0;
  else
    Gc = coreParameters.GcRef;
    // * (coreParameters.wRef/wLimit*coreParameters.ratioHysteresis + 1 - coreParameters.ratioHysteresis);
    i = Gc*v;
  end if;
  lossPower = v*i;
  annotation (Icon(graphics={Rectangle(
                extent={{-70,30},{70,-30}}, 
                lineColor={0,0,255}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Line(points={{70,0},{90,0}}), 
          Line(points={{-90,0},{-70,0}}),Line(points={{-70,10},{70,10}}, 
          color={0,0,255}),Line(points={{-70,-30},{70,-30}}, color={0,0,255}), 
          Line(points={{-70,-10},{70,-10}}, color={0,0,255}),Text(
                extent={{-150,90},{150,50}}, 
                textColor={0,0,255}, 
                textString="%name")}), Documentation(info="<html>
<p>
核心损耗可以分为<em>涡流</em>和<em>磁滞</em>损耗。因此，总核心损耗可以表示为
</p>
<blockquote><pre>
p=PRef*(ratioHysteresis*(wRef/w)+1-ratioHysteresis)*(v/VRef)^2
</pre></blockquote>
<p>
其中<code>w</code>是实际角速度，<code>v</code>是实际电压。术语<code>ratioHysteresis</code>是关于参考内电压和参考角速度的总核心损耗与磁滞损耗之比。
</p>

<p>
对于图1中的电压和角速度范围，总核心损耗对参数<code>ratioHysteresis</code>的依赖性如图2所示。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesVw.png\"
                alt=\"corelossesVw.png\"> </td>
  </tr>
  <tr><td> <strong>图1：</strong>电压与角速度</td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/corelossesPcw.png\"
                alt=\"corelossesPcw.png\"> </td>
  </tr>
  <tr><td> <strong>图2：</strong>核心损耗与角速度的关系(参数为<code>ratioHysteresis</code>)</td>
  </tr>
</table>

<h4>注意</h4>
<p>在当前实现中，假定<code>ratioHysteresis=0</code>。由于兼容性原因，此参数无法更改。</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.CoreParameters\">核心损耗参数</a>
</p>

</html>"));
end Core;