within Modelica.Thermal.HeatTransfer.Celsius;
model FromKelvin "从开尔文到摄氏度的转换"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Kelvin(unit="K") 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Celsius(unit="degC") 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Celsius = Modelica.Units.Conversions.to_degC(Kelvin);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,60},{-40,0}}, 
          textColor={64,64,64}, 
          textString="K"), 
        Text(
          extent={{40,60},{100,0}}, 
          textColor={64,64,64}, 
          textString="degC")}), 
    Documentation(info="<html><p>
该组件将输入信号从K转换为s℃， 并将其作为输出信号。
</p>
</html>"));
end FromKelvin;