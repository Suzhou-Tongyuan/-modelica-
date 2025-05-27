within Modelica.Electrical.Machines;
package Thermal "连接热模型的模型库"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={Ellipse(
          extent={{-65,-63},{65,63}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<h4>热概念</h4>
<p>
每个机器模型都配备有特定于机器的条件<code>thermalPort</code>。
如果<code>useThermalPort==false</code>，则在机器内部使用指定恒定温度的特定于机器的热环境。
如果<code>useThermalPort==true</code>，则必须从外部连接热模型或指定温度的机器特定热环境。
另一方面，所有损耗都会耗散到这个内部或外部的热环境中。
</p>
<p>
机器特定的热连接器库含<a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">heatPort</a>s，用于机器类型的所有相关损耗源，尽管一些损耗源尚未实现；
这些heatPorts在机器内部保持未连接状态，即HeatFlowRate为零，
但它们必须连接到内部或外部热环境中的恒定温度源。
在这个库中提供了用于常量温度(<code>useTemperatureInputs==false</code>)或通过信号输入指定温度的简单机器特定热环境。
</p>
<h4>损耗源</h4>
<p>
到目前为止，只实现了定子绕组和转子绕组的欧姆损耗。
它们被建模为<a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">线性温度依赖电阻</a>：
</p>
<blockquote><pre>
ROperational=RRef*(1+alphaRef*(TOperational-TRef))
</pre></blockquote>
<h5>参数</h5>
<ul>
<li>参考温度下的电阻<code>RRef</code></li>
<li>参考温度<code>TRef</code></li>
<li>20℃时的线性温度系数<code>alpha20</code></li>
<li>操作温度<code>TOperational</code>
(如果<code>useThermalPort==false</code>；否则，通过heatPort提供操作温度)</li>
<li>额定温度<code>TNominal</code>
(用于计算变压器的变比)</li>
</ul>
<p>
20℃时的线性温度系数<code>alpha20</code>必须转换为参考温度<code>TRef</code>：
</p>
<blockquote><pre>
                      alpha20
alphaRef = -------------------------------
            1 + alpha20 * (TRef - 293.15)
</pre></blockquote>
<p>
为此，提供了函数<a href=\"modelica://Modelica.Electrical.Machines.Thermal.convertAlpha\">convertAlpha</a>。
在子库<a href=\"modelica://Modelica.Electrical.Machines.Thermal.Constants\">Constants</a>中定义了常用材料的20℃线性温度系数。
</p>
<h4>向后兼容性</h4>
<ul>
<li>所有电阻的默认/起始值保持不变。</li>
<li>所有参考温度的默认/起始值设置为20℃。</li>
<li>所有线性温度系数的默认/起始值设置为0。</li>
<li>所有操作温度的默认/起始值设置为20℃。</li>
<li>所有额定温度的默认/起始值设置为20℃。</li>
</ul>
<h4>机器特定的thermalPorts</h4>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage\">鼠笼感应电机</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3个用于m=3个定子相的heatPorts</li>
<li><code>heatPortRotorWinding</code>: 转子笼的heatPort</li>
<li><code>heatPortStatorCore</code>: 定子铁芯损耗(尚未完全实现)</li>
<li><code>heatPortRotorCore</code>: 转子铁芯损耗(尚未连接/实现)</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SlipRing\">滑环感应电机</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3个用于m=3个定子相的heatPorts</li>
<li><code>heatPortRotorWinding[m]</code>: m=3个用于m=3个转子相的heatPorts</li>
<li><code>heatPortBrush</code>: 刷子损耗(尚未连接/实现)</li>
<li><code>heatPortStatorCore</code>: 定子铁芯损耗(尚未完全实现)</li>
<li><code>heatPortRotorCore</code>: 转子铁芯损耗(尚未完全实现)</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">永磁同步电机</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3个用于m=3个定子相的heatPorts</li>
<li><code>heatPortRotorWinding</code>: 有条件(<code>useDamperCage=true/false</code>)的阻尼笼heatPort</li>
<li><code>heatPortPermanentMagnet</code>: 永磁体损耗(尚未连接/实现)</li>
<li><code>heatPortStatorCore</code>: 定子铁芯损耗(尚未完全实现)</li>
<li><code>heatPortRotorCore</code>: 转子铁芯损耗(尚未连接/实现)</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">电励磁同步电机</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3个用于m=3个定子相的heatPorts</li>
<li><code>heatPortRotorWinding</code>: 有条件(<code>useDamperCage=true/false</code>)的阻尼笼heatPort</li>
<li><code>heatPortExcitation</code>: 电励磁</li>
<li><code>heatPortBrush</code>: 刷子损耗</li>
<li><code>heatPortStatorCore</code>: 定子铁芯损耗(尚未完全实现)</li>
<li><code>heatPortRotorCore</code>: 转子铁芯损耗(尚未连接/实现)</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">磁阻转子同步电机</a></h5>
<ul>
<li><code>heatPortStatorWinding[m]</code>: m=3个用于m=3个定子相的heatPorts</li>
<li><code>heatPortRotorWinding</code>: 有条件(<code>useDamperCage=true/false</code>)的阻尼笼heatPort</li>
<li><code>heatPortStatorCore</code>: 定子铁芯损耗(尚未完全实现)</li>
<li><code>heatPortRotorCore</code>: 转子铁芯损耗(尚未连接/实现)</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet\">永磁直流电机</a></h5>
<ul>
<li><code>heatPortArmature</code>: 电枢损耗</li>
<li><code>heatPortPermanentMagnet</code>: 永磁体损耗(尚未连接/实现)</li>
<li><code>heatPortBrush</code>: 刷子损耗</li>
<li><code>heatPortCore</code>: 电枢铁芯损耗</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_ElectricalExcited\">直流电机电(并联)励磁</a></h5>
<ul>
<li><code>heatPortArmature</code>: 电枢损耗</li>
<li><code>heatPortExcitation</code>: 电(并联)励磁</li>
<li><code>heatPortBrush</code>: 刷子损耗</li>
<li><code>heatPortCore</code>: 电枢铁芯损耗</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_SeriesExcited\">串联励磁直流电机</a></h5>
<ul>
<li><code>heatPortArmature</code>: 电枢损耗</li>
<li><code>heatPortSeriesExcitation</code>: 串联励磁</li>
<li><code>heatPortBrush</code>: 刷子损耗</li>
<li><code>heatPortCore</code>: 电枢铁芯损耗</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><!--<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_Compound\">-->串并励磁直流电机(尚未实现)<!--</a>--></h5>
<ul>
<li><code>heatPortArmature</code>: 电枢损耗</li>
<li><code>heatPortShuntExcitation</code>: 电(并联)励磁</li>
<li><code>heatPortSeriesExcitation</code>: 串联励磁</li>
<li><code>heatPortBrush</code>: 刷子损耗</li>
<li><code>heatPortCore</code>: 电枢铁芯损耗</li>
<li><code>heatPortStrayLoad</code>: 漏损</li>
<li><code>heatPortFriction</code>: 摩擦损耗</li>
</ul>
<h5><a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.Transformers\">变压器</a></h5>
<ul>
<li><code>heatPort1[m]</code>: m=3个用于m=3个初级相的heatPorts</li>
<li><code>heatPort2[m]</code>: m=3个用于m=3个次级相的heatPorts</li>
<li><code>heatPortCore</code>: 铁心损耗(尚未连接/实现)</li>
</ul>
</html>", 
        revisions="<html>
  <ul>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       该子库的第一个稳定版本发布：<br>
       所有机器的条件热端口</li>
  </ul>
</html>"));
end Thermal;