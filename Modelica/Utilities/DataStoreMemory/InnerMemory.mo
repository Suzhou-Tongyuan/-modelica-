connector InnerMemory = OuterMemory "'inner memory' 作为连接器"  annotation(__MWORKS(Memory), defaultComponentName = "X", defaultComponentPrefixes = "inner",Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2}),graphics = {Rectangle(origin={0,0}, 
lineColor={0,0,127}, 
fillColor={255,255,255}, 
fillPattern=FillPattern.Solid, 
extent={{-100,100},{100,-100}}), Line(origin={0,70}, 
points={{-100,0},{100,0}}, 
color={0,0,127}, 
thickness=2), Line(origin={0,-70}, 
points={{-100,0},{100,0}}, 
color={0,0,127}, 
thickness=2), Text(origin={-3,-3}, 
lineColor={0,0,127}, 
extent={{-77,23},{77,-23}}, 
textString="%name", 
textStyle={TextStyle.None}, 
textColor={0,0,127})}),Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2})),Documentation(info="<html><p>
定义OuterMemory使用的内存区域，当前子系统中所有具有相同数据存储名称的OuterMemory将能够对该模型进行读写.
</p>
</html>"));