within Modelica.Electrical.PowerConverters.ACDC;
package Control "整流器的控制组件"
  extends Modelica.Icons.Package;
  annotation (Documentation(info="<html>
<p>
提供了一个带有信号输入和<code>2*m</code>个触发信号的通用控制器，
其中<code>m</code>是任意相数。
还包括具有电气连接器的其他特定拓扑的控制器。
</p>

<h4>滤波器</h4>

<p>
每个控制器都配备了一个可选的
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Filter\">滤波器</a>
用于过滤输入电压。默认情况下，滤波器已启用。
</p>

<p>
如果电网中存在显著的电压降，使整流器的输入电压波形失真，则需要此类滤波器。
PowerConverters 库中包含的滤波器是具有附加滤波器特定相位滞后补偿的一阶滤波器。
但是，重要的是要注意，滤波器的暂态可能会导致一些初始影响，在一定时间后会恶化。
</p>

<h4>启用</h4>

<p>
特定拓扑的控制器允许启用和禁用触发信号。
控制器的内部启用信号是从参数<code>constantEnable</code>派生的，
如果<code>useConstantEnable = true</code>。
如果<code>useConstantEnable = false</code>，则内部启用信号将从可选信号输入<code>enable</code>中获取。
</p>
</html>"));
end Control;