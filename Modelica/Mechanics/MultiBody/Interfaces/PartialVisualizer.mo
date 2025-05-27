within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialVisualizer 
  "用于可视化器的基础模型(包括左侧frame_a+外部world+确保组件已被连接的断言)"

  Interfaces.Frame_a frame_a "解析可视化数据的坐标系" annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  assert(cardinality(frame_a) > 0, 
    "可视化器对象的连接器frame_a未被连接");
  annotation (Documentation(info="<html>
<p>
此部分模型提供一个frame_a连接器，访问world对象，并使用断言检查frame_a连接器是否已被连接。
它被所有可视化对象继承使用。
</p>
</html>"));
end PartialVisualizer;