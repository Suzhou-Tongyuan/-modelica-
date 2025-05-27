within Modelica.Thermal.HeatTransfer.Celsius;
model PrescribedTemperature 
  "以摄氏度为单位的可变温度边界条件"
  extends HeatTransfer.Icons.PrescribedTemperature;
  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput T(unit="degC") annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
equation
  port.T = Modelica.Units.Conversions.from_degC(T);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-100,-40},{-40,-100}}, 
          textColor={64,64,64}, 
          textString="degC")}), 
    Documentation(info="<html><p>
该模型代表一种可变温度边界条件，其温度值（以[°C]为单位）由输入信号给定。其效果是：该模型的实例将充当一个无限热源，能够吸收或产生维持设定温度所需的任意能量。
</p>
</html>"));
end PrescribedTemperature;