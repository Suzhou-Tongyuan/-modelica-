within Modelica.Mechanics.Translational.Interfaces;
partial model PartialForce 
  "部分模型：施加在接口上的力(加速接口)"
  extends PartialElementaryOneFlangeAndSupport2;
  SI.Force f 
    "作用在夹持器上的加速力 (= flange.f)";
equation
  f = flange.f;
  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
    -100}, {100, 100}}), graphics = {Rectangle(
    extent = {{-96, 100}, {96, -92}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), Line(points = {{0, -60}, {0, -100}}, color = {0, 127, 0}), 
    Text(
    extent = {{-150, 140}, {150, 100}}, 
    textColor = {0, 0, 255}, 
    textString = "%name"), Line(points = {{-78, 80}, {51, 80}}, color = {95, 127, 95}), 
    Polygon(
    points = {{81, 80}, {51, 90}, {51, 70}, {81, 80}}, 
    fillColor = {95, 127, 95}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {95, 127, 95}), Line(points = {{-52, -60}, {77, -60}}, color = {95, 127, 95}), 
    Polygon(
    points = {{-82, -60}, {-51, -50}, {-51, -70}, {-82, -60}}, 
    fillColor = {95, 127, 95}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {95, 127, 95})}), Documentation(info = "<html><p>
施加在接口上的加速力的部分模型。
</p>
<p>
如果 <em>useSupport=true</em>，则支撑连接器会被有条件地启用并需要连接。<br> 如果 <em>useSupport=false</em>，则支撑连接器会被有条件地禁用，相反，该组件将在内部固定到地面上。
</p>
</html>"));
end PartialForce;