within Modelica.Electrical.Analog.Interfaces;
partial model TwoPin "两个电气引脚组件"
  SI.Voltage v "Voltage drop of the two pins (= p.v - n.v)";

  PositivePin p "Positive electrical pin" 
    annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  NegativePin n "Negative electrical pin" 
    annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
equation
  v = p.v - n.v;
  annotation(
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>初版创建<br>
       </li>
</ul>
</html>", 
    info = "<html>
<p>tanwoPin是一个部分模型，它具有两个引脚和一个内部变量。该模型被用来测量两个引脚之间的电压。模型内部电流未定义。模型旨在用于那些通过图形组合其他组件，而不是方程式来构建的模型。
</p>

</html>"));
end TwoPin;