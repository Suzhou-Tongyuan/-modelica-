within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model TwoPortElementary "两个磁性端口用于图形化建模"

  FluxTubes.Interfaces.PositiveMagneticPort port_p "正准静磁口" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "负准静态磁口" annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  SI.ComplexMagneticPotentialDifference V_m 
  "两个端口的磁电位差";
  SI.MagneticPotentialDifference abs_V_m = Modelica.ComplexMath.abs(V_m) 
  "复磁位差的大小";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m) 
  "复磁位差的论证";
  SI.ComplexMagneticFlux Phi(re(start=0),im(start=0)) 
  "从port_p到port_n的磁通量";
  SI.MagneticFlux abs_Phi= 
      Modelica.ComplexMath.abs(Phi) "复磁通量的大小";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi) 
  "复磁通量的参数";
  SI.AngularVelocity omega;
equation
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  omega = der(port_p.reference.gamma);

  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;

  annotation (Documentation(info="<html>
<p>
具有两个磁口的磁通管组件的局部模型:
正极端口连接器<code>port_p</code>，负极端口
连接器<code>port_n</code>。总磁位差
<code>V_m</code>和流入正端口的通量，
<code>Phi</code>也在这个模型中定义.
</p></html>"));
end TwoPortElementary;