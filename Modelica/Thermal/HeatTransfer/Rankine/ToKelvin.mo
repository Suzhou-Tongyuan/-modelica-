within Modelica.Thermal.HeatTransfer.Rankine;
model ToKelvin "从兰氏度到开尔文的转换"
  extends HeatTransfer.Icons.Conversion;
  Modelica.Blocks.Interfaces.RealInput Rankine(unit="degRk") 
   annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Kelvin(unit="K") 
   annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Kelvin = Modelica.Units.Conversions.from_degRk(Rankine);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,60},{-40,0}}, 
          textColor={64,64,64}, 
          textString="degRk"), 
        Text(
          extent={{40,60},{100,0}}, 
          textColor={64,64,64}, 
          textString="K")}), 
    Documentation(info="<html><p>
该组件将所有输入信号°R转换为K ，并将其作为输出信号。
</p>
</html>"));
end ToKelvin;