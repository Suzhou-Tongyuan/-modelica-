within Modelica.Magnetic.QuasiStatic.FundamentalWave.Losses;
model StrayLoad "取决于电流和速度的杂散负载损耗模型"
  extends Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.OnePort;
  extends Modelica.Electrical.Machines.Interfaces.FlangeSupport;
  import Modelica.Electrical.QuasiStatic.Polyphase.Functions.quasiRMS;
  parameter Modelica.Electrical.Machines.Losses.StrayLoadParameters 
    strayLoadParameters "杂散负载损耗参数";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
  SI.Current iRMS=quasiRMS(i);
equation
  v = {Complex(0, 0) for k in 1:m};
  if (strayLoadParameters.PRef <= 0) then
    tau = 0;
  else
    tau = -strayLoadParameters.tauRef*(iRMS/strayLoadParameters.IRef)^2* 
      sign(w)*(abs(w)/strayLoadParameters.wRef)^strayLoadParameters.power_w;
  end if;
  lossPower = -tau*w;
  annotation (defaultComponentName="strayLoss", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={85,170,255}, 
          pattern=LinePattern.Dot), Line(
          points={{-102,0},{100,0}}, 
          color={85,170,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
<p>
杂散负载损耗的建模与 EN 60034-2 和 IEEE 512 标准类似，即取决于电流的平方、
但在空载电流时不将其缩放为零.
</p>
<p>
关于角速度变化依赖性的估计，见:
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.References\">[Lang1984]</a>
</p>
<p>
杂散负载损耗的建模方式不会导致电路中的电压降。
相反，耗散的损耗是通过轴上的等效制动扭矩来考虑的.
</p>
<p>
杂散负载损失扭矩为
</p>
<blockquote><pre>
tau = PRef/wRef * (i/IRef)^2 * (w/wRef)^power_w
</pre></blockquote>
<p>
其中<code>i</code>为机器的电流，<code>w</code>为实际角速度。
杂散负载转矩对角速度的依赖关系由指数<code>power_w</code>表示.
</p>
<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.StrayLoadParameters\">StrayLoad parameters</a>
</p>
<p>
如果希望忽略杂散负载损耗，请设置<code>strayLoadParameters。PRef = 0</code>(这是默认值).
</p>
</html>"));
end StrayLoad;