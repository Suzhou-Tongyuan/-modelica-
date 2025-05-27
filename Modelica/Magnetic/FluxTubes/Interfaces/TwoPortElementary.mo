within Modelica.Magnetic.FluxTubes.Interfaces;
partial model TwoPortElementary "接口组件与两个磁性端口文本编程"

  FluxTubes.Interfaces.PositiveMagneticPort port_p "正磁口" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "负磁口" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  annotation (Documentation(info="<html>
<p>
具有两个磁口的磁通管组件的局部模型:
正极端口连接器port_p，负极端口
连接器port_n.
</p>
</html>"));
end TwoPortElementary;