within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
partial model TwoPort "用于文本编程的初级部分二端口"
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortExtended;

equation
  // 局部通量平衡
  port_p.Phi + port_n.Phi = Complex(0, 0);
  annotation (
    Documentation(info="<html>
<p>
偏二端口初等模型在偏二端口模型的基础上进行了扩展，增加了一个考虑流量变量平衡的方程<code>port_p.Phi + port_n.Phi = Complex(0,0)</code>。另外，定义了两个磁口的磁位差变量<code>V_m</code>和进入正极的磁通<code>Phi</code>.
</p>
</html>"));
end TwoPort;