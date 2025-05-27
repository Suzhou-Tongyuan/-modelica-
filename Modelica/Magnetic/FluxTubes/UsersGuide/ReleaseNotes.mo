within Modelica.Magnetic.FluxTubes.UsersGuide;
class ReleaseNotes "发布说明"
  extends Modelica.Icons.ReleaseNotes;
  annotation (Documentation(info="<html>

<h5>Version 3.2.2, 2014-12-05 (Johannes&nbsp;Ziske, Thomas&nbsp;B&ouml;drich)</h5>

<ul>
<li>添加软件包 <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">FluxTubes.UsersGuide.Hysteresis</a></li>
<li>添加软件包 <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis\">FluxTubes.Examples.Hysteresis</a></li>
<li>添加软件包 <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">FluxTubes.Shapes.HysteresisAndMagnets</a></li>
<li>添加软件包 <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a></li>
<li>添加软件包 <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a></li>
<li>更新 <a href=\"modelica://Modelica.Magnetic.FluxTubes.BaseClasses.FixedShape\">FluxTubes.BaseClasses.FixedShape</a> for differentiability</li>
<li>更新 <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">FluxTubes.UsersGuide.Literature</a></li>
</ul>

<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>

<ul>
<li>添加常数
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance\">permeance model</a></li>
<li>添加
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape.GenericFluxTube\">GenericFluxTube</a></li>
<li>添加参数 <code>useConductance</code> including alternative parameterization in
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">EddyCurrent</a></li>
<li>添加
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Idle\">Idle</a></li>
<li>添加
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Short\">Short</a></li>
<li>添加
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.Crossing\">Crossing</a></li>
</ul>

<h5>Version 1.5, 2013-01-04 (Martin&nbsp;Otter, Thomas&nbsp;B&ouml;drich, Johannes&nbsp;Ziske)</h5>
<ul>
<li>添加了缺失的初始条件</li>
<li>固定初始参数值</li>
</ul>

<h5>Version 1.4, 2011-08-01 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>用 MagneticPotential 代替 MagneticPotentialDifference 声明的 MagneticPort</li>
</ul>

<h5>Version 1.3, 2010-04-22 (Christian&nbsp;Kral)</h5>
<ul>
<li>为涡流模型添加了条件热端口</li>
</ul>

<h5>Version 1.2, 2009-08-11 (Christian&nbsp;Kral, Anton&nbsp;Haumer, Thomas&nbsp;B&ouml;drich, Martin&nbsp;Otter)</h5>
<ul>
<li>更新和改进，以便纳入
    Modelica模型标准库</li>
</ul>

<h5>Version 1.1, 2009-05-19 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>移除 Basic.ElectroMagneticConverter 中的耦合系数</li>
<li>添加了 Basic.EddyCurrent</li>
<li>移动线圈执行器示例，特别是 PermeanceModel，全面修订</li>
<li>在 Basic.LeakageWithCoefficient 中用耦合系数代替泄漏系数</li>
<li>实用程序.线圈设计：参数 U 更名为 V_op，线圈设计移至实用程序.</li>
<li>所有信号源中添加的磁通量的参考方向</li>
<li>为与 Modelica 3.0 兼容，用 K 取代 degC</li>
<li>为与 Modelica 3.0 兼容，删除了传感器中的重新声明</li>
<li>部分通量管元件移至接口，基本元件移至新软件包 Basic</li>
</ul>

<h5>Version 1,0, 2007-10-11 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>发布图书馆 1.0 版本</li>
</ul>

<h5>2005 (Thomas&nbsp;B&ouml;drich)</h5>
<ul>
<li>首次发布 Modelica 磁性库</li>
</ul>

</html>"));
end ReleaseNotes;