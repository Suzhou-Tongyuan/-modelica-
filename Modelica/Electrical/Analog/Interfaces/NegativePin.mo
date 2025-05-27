within Modelica.Electrical.Analog.Interfaces;
connector NegativePin "电气组件的负极引脚"

  SI.ElectricPotential v "Potential at the pin" annotation(
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
  annotation(defaultComponentName = "pin_n", 
    Documentation(info = "<html>
<p>PositivePin和NegativePin几乎是相同的。唯一的区别是图标不同，以便更容易识别元件的引脚。通常，PositivePin用于元件的正极，而NegativePin用于元件的负极。
</p>

</html>", 
    revisions = "<html>
<dl>
<dt><em>1998</em></dt>
<dd>由Christoph Clauss初版创建
</dd>
</dl>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Rectangle(
    extent = {{-100, 100}, {100, -100}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid)}), 
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Rectangle(
    extent = {{-40, 40}, {40, -40}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-40, 110}, {160, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end NegativePin;