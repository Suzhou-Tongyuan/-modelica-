within Modelica.Mechanics;
package Translational "用于建立一维平动机械系统模型的库"
  extends Modelica.Icons.Package;

  annotation (Icon(
    coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, {100,100}}), 
    graphics={
      Line(origin={14,53}, points={{-84,-73},{66,-73}}), 
      Rectangle(
        origin={14,53}, 
        lineColor={64,64,64}, 
        fillColor={192,192,192}, 
        fillPattern=FillPattern.Sphere, 
        extent={{-81,-65},{-8,-22}}), 
      Line(
        origin={14,53}, 
        points={{-8,-43},{-1,-43},{6,-64},{17,-23},{29,-65},{40,-23},{50,-44}, {61,-44}}), 
      Line(origin={14,53}, points={{-59,-73},{-84,-93}}), 
      Line(origin={14,53}, points={{-11,-73},{-36,-93}}), 
      Line(origin={14,53}, points={{-34,-73},{-59,-93}}), 
      Line(origin={14,53}, points={{14,-73},{-11,-93}}), 
      Line(origin={14,53}, points={{39,-73},{14,-93}}), 
      Line(origin={14,53}, points={{63,-73},{38,-93}})
    }), 
    Documentation(info="<html><p>
此包中包含用于对<em>一维平动机械</em>系统建模的组件。
</p>
<p>
在组件左右侧的填充和非填充绿色方块表示机械一维平动接口。
在这些方块之间绘制一条线表示相应的一维平动接口刚性的连接在一起。
该库的组件通常可以以任意方式连接在一起。
例如，可以直接连接两个弹簧或两个具有惯性的滑块。
</p>
<p>
唯一的连接限制是，库中的库仑摩擦元件(例如带阻止和摩擦的质量元件)只能在两个元件之间插入一个合规元件(例如弹簧)时连接在一起。
原因是，如果这两个元件同时卡住，摩擦力将无法唯一定义(即没有唯一解)，而某些仿真系统可能无法处理这种情况，因为这会在仿真过程中导致奇异性。
只有通过将两个连接的摩擦元件合并成一个组件，并解决卡住状态下摩擦力的不确定性，才能以\"清晰的方式\"解决这个问题。
</p>
<p>
如果在模型MassWithStopAndFriction中使用硬性止挡，则会出现另一个限制情况即通过smax或smin限制了质量块的运动。
<span style=\"color: rgb(255, 0, 0);\"><strong> 这需要状态Stop.s和Stop.v </strong></span>。
如果在指数简化过程中消除这些状态 则模型将无法正常工作。
为了避免这种情况，任何带惯性的一维平动组件都应该通过弹簧连接到Stop元素，必须避免其他滑块、阻尼器或液压腔。
</p>
<p>
在每个组件的图标中，显示一个灰色箭头。
此箭头表示解析组件的矢量的坐标系。
它指向正的平动方向（数学意义上）。
在组件的一维平动接口中，一个坐标系被刚性连接到一维平动接口上。
它被称为一维平动接口坐标系，并且平行于组件坐标系。
因此，例如，\"左\"一维平动接口（flange_a）的正切力是指向一维平动接口的，而\"右\"一维平动接口（flange_b）的正切力是指向一维平动接口外部的。
一维平动接口由一个包含以下变量的Modelica连接器描述：
</p>
<pre><code >Modelica.Units.SI.Position s    \"一维平动接口的绝对位置\";
flow Modelica.Units.SI.Force f  \"一维平动接口中的局部力\";
</code></pre><p>
此库是以完全面向对象的方式设计，以便可以用所有有意义的组合来连接组件（例如，直接连接两个弹簧或两个带惯性的轴）。
因此，大多数模型都导致一个由3阶指数的微分代数方程组成的系统（=需要对约束方程进行两次微分，以得到状态空间表示方程）， 
Modelica翻译器或模拟器必须处理这种系统表示。
据我们目前的了解，这要求Modelica翻译器能够对微分方程符号化（否则将会导致一些问题出现，例如，无法提供一致的初始条件；
即使存在一致的初始条件，大多数数值DAE积分器最多也只能处理2阶指数的DAE）。
</p>
<p>
在Modelica标准库的3.2版本中，所有的<strong>耗散</strong>元件的Translational库都添加了一个可选的<strong>heatPort</strong>连接器，
通过这个连接器以热能的形式传输耗散的能量。此连接器通过参数\"useHeatPort\"启用。
如果启用了heatPort连接器，则必须连接它，如果未启用，则不得连接。
无论是否启用了heatPort，耗散功率都可以从新变量\"<strong>lossPower</strong>\"中获取（如果热量从heatPort流出，则该变量为正）。
例如，请参阅<a href=\"modelica://Modelica.Mechanics.Translational.Examples.HeatLosses\" target=\"\">Examples.HeatLosses</a>。
</p>
<p>
版权所有©1998-2020，Modelica协会及其贡献者
</p>

</html>",revisions="<html>
<ul>
<li><em>Version 1.2.0 2010-07-22</em>
by Anton Haumer and Martin Otter<br>
为所有耗散元件引入了heatPort，并改进了图标中的文本。
<br></li>

<li><em>Version 1.1.0 2007-11-16</em>
by Anton Haumer<br>
为Modelica 3.0兼容性重新设计<br>
根据Mechanics.Rotational库添加了新组件。
<br></li>

<li><em>Version 1.01 (July 18, 2001)</em>
by Peter Beater<br>
在\"Stop\"中添加了Assert语句，修复了示例中的小错误。
<br></li>

<li><em>Version 1.0 (January 5, 2000)</em>
by Peter Beater<br>
根据Martin Otter的Modelica库Mechanics.Rotational和Peter Beater的现有Dymola库onedof.lib实现了一个第一版本。
</li>
</ul>
</html>"));
end Translational;