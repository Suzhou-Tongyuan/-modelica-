within Modelica.Electrical.Analog.Interfaces;
connector PositivePin "电气元件的正极引脚"
  SI.ElectricPotential v "Potential at The pin" annotation(
    unassignedMessage = "An electrical potential cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
  flow SI.Current i "Current flowing into the pin" annotation(
    unassignedMessage = "An electrical current cannot be uniquely calculated.
The reason could be that
- a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
  to define the zero potential of the electrical circuit, or
- a connector of an electrical component is not connected.");
  annotation(defaultComponentName = "pin_p", 
    Documentation(info = "<html>
<p>正引脚(PositivePin)和负引脚(NegativePin)几乎相同。唯一的区别是图标不同，以便用户能更容易识别组件的引脚。通常，正引脚用于电气组件的正极，而负引脚用于电气组件的负极。
</p>
</html>", revisions = "<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>初版创建<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Rectangle(
    extent = {{-100, 100}, {100, -100}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid)}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Rectangle(
    extent = {{-40, 40}, {40, -40}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-160, 110}, {40, 50}}, 
    textColor = {0, 0, 255}, 
    textString = "%name")}));
end PositivePin;