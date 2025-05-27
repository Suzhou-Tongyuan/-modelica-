within Modelica.Electrical.Machines.Losses.InductionMachines;
model StrayLoad 
  "电流和速度相关的杂散负载损耗模型"
  extends Modelica.Electrical.Polyphase.Interfaces.OnePort;
  extends Machines.Interfaces.FlangeSupport;
  import Modelica.Electrical.Polyphase.Functions.quasiRMS;
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters 
    "杂散负载损耗参数";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  SI.Current iRMS=quasiRMS(i);
equation
  v = zeros(m);
  if (strayLoadParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -strayLoadParameters.tauRef*(iRMS/strayLoadParameters.IRef)^2* 
      sign(w)*(abs(w)/strayLoadParameters.wRef)^strayLoadParameters.power_w;
  end if;
  lossPower = -tau*w;
  annotation (Icon(graphics={
        Line(points={{-90,0},{90,0}}, color={0,0,255}), 
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={0,0,255}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,90},{150,50}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
<p>
杂散负载损耗模型与EN 60034-2和IEEE 112标准类似，即它们依赖于电流的平方，
但没有将它们缩放到无负载电流时。
</p>
<p>
关于速度变化的依赖性的估计，请参阅：<br>
W. Lang, Über die Bemessung verlustarmer Asynchronmotoren mit Käfigläufer für Pulsumrichterspeisung, Doctoral Thesis, Technical University of Vienna, 1984。
</p>
<p>
杂散负载损耗模型不会导致电路中的电压下降。
相反，通过轴上的等效制动扭矩考虑耗散损耗。
</p>
<p>
杂散负载损耗扭矩是
</p>
<blockquote><pre>
tau = PRef/wRef * (i/IRef)^2 * (w/wRef)^power_w
</pre></blockquote>
<p>
其中<code>i</code>是机器的电流，<code>w</code>是实际的角速度。
杂散负载扭矩对角速度的依赖性由指数<code>power_w</code>建模。
</p>
<h4>参见</h4>
<p><a href=\"modelica://Modelica.Electrical.Machines.Losses.StrayLoadParameters\">杂散负载参数</a>
</p>
<p>
如果希望忽略杂散负载损耗，请设置<code>strayLoadParameters.PRef=0</code>(这是默认值)。
</p>
</html>"));
end StrayLoad;