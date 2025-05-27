within Modelica.Thermal.HeatTransfer.Fahrenheit;
model FromKelvin "从开尔文到华氏度的转换"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Kelvin(unit="K") 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Fahrenheit(unit="degF") 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Fahrenheit = Modelica.Units.Conversions.to_degF(Kelvin);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{40,60},{100,0}}, 
          textColor={64,64,64}, 
          textString="degF"), 
        Text(
          extent={{-100,60},{-40,0}}, 
          textColor={64,64,64}, 
          textString="K")}), 
    Documentation(info="<html><p>
该组件将所有输入信号从K转换为°F，并将其作为输出信号提供。
</p>
</html>"));
end FromKelvin;