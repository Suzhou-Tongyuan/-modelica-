within Modelica.Electrical.Machines.Losses.DCMachines;
model StrayLoad 
  "依赖于电流和速度的空载损耗模型"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Machines.Interfaces.FlangeSupport;
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters 
    "空载损耗参数";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
equation
  v = 0;
  if (strayLoadParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -strayLoadParameters.tauRef*(i/strayLoadParameters.IRef)^2* 
      sign(w)*(abs(w)/strayLoadParameters.wRef)^strayLoadParameters.power_w;
  end if;
  lossPower = -tau*w;
  annotation (Icon(graphics={Line(points={{-90,0},{90,0}}, color={0,0,255}), 
          Rectangle(
                extent={{-70,30},{70,-30}}, 
                lineColor={0,0,255}, 
                pattern=LinePattern.Dot),Text(
                extent={{-150,90},{150,50}}, 
                textColor={0,0,255}, 
                textString="%name")}), Documentation(info="<html>
<p>
空载损耗力矩为
</p>
<blockquote><pre>
tau=PRef/wRef*(i/IRef)^2*(w/wRef)^power_w
</pre></blockquote>
<p>
其中<code>i</code>是机器的电流，<code>w</code>是实际角速度。
空载力矩对角速度的依赖性由指数<code>power_w</code>建模。
</p>
<p>
空载损耗的建模方式是，它们不会在电路中引起电压降。
相反，通过等效的制动力矩考虑了消耗的损失。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.StrayLoadParameters\">空载参数</a>
</p>
<p>
如果希望忽略空载损耗，请设置<code>strayLoadParameters.PRef=0</code>(这是默认值)。
</p>
</html>"));
end StrayLoad;