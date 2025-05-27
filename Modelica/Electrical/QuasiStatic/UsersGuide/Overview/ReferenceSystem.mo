within Modelica.Electrical.QuasiStatic.UsersGuide.Overview;
class ReferenceSystem "参考系统"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
参考角度 <code>gamma</code>：
</p>
<ul>
  <li>通过 <code>omega = der(gamma)</code> 的方式定义电路的电压和电流的角频率 <code>omega</code>。</li>
  <li>不是全局量，因为它通过连接器传播。因此，可以在一个模型中对不同频率的独立电路进行建模。</li>
  <li>在多相连接器中仅存在一次；多相组件仅有一个公共的参考角度。</li>
  <li>可以是常数或变量，但在一个连续电路中必须保持一致。</li>
  <li>由源定义。</li>
</ul>
<p>
在设计新组件时，必须考虑 Modelica 3.4 规范的 <a href=\"https://specification.modelica.org/v3.4/Ch9.html#overconstrained-equation-operators-for-connection-graphs\">第9.4.1节（连接图的超约束方程运算符）</a> 指南。
</p>

<h4>参见</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">
          简介</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">
          交流电路</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Power\">
          功率</a>

</html>"));
end ReferenceSystem;