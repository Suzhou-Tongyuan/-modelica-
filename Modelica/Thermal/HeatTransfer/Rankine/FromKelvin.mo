within Modelica.Thermal.HeatTransfer.Rankine;
model FromKelvin "从开尔文到兰氏度的转换"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Kelvin(unit="K") 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Rankine(unit="degRk") 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Rankine = Modelica.Units.Conversions.to_degRk(Kelvin);
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
          textString="degRk")}), 
    Documentation(info="<html><p>
该组件将所有输入信号从K转换为°R，并将其作为输出信号。
</p>
</html>"));
end FromKelvin;