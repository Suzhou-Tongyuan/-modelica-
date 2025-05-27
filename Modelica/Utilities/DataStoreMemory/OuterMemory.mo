connector OuterMemory = Real "'outer memory' 作为连接器" annotation(__MWORKS(MemoryRef),defaultComponentName = "X", defaultComponentPrefixes = "outer", Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2}),graphics = {Rectangle(origin={0,0}, 
lineColor={0,0,127}, 
fillColor={255,255,255}, 
fillPattern=FillPattern.Solid, 
extent={{-100,100},{100,-100}}), Line(origin={0,70}, 
points={{-100,0},{100,0}}, 
color={0,0,127}, 
pattern=LinePattern.Dash, 
thickness=2), Line(origin={0,-70}, 
points={{-100,0},{100,0}}, 
color={0,0,127}, 
pattern=LinePattern.Dash, 
thickness=2), Text(origin={-3,-3}, 
lineColor={0,0,127}, 
extent={{-77,23},{77,-23}}, 
textString="%name", 
textStyle={TextStyle.None}, 
textColor={0,0,127})}), Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2})),Documentation(info="<html><p>
对指定的InnerMemory内存区域进行写操作或从指定InnerMemory内存区域进行都操作，该内存区域可以进行多次读操作，只能进行一次写操作.
</p>
</html>"));