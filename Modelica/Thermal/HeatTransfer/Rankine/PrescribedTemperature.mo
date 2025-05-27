within Modelica.Thermal.HeatTransfer.Rankine;
model PrescribedTemperature 
  "以兰氏度为单位的可变温边界条件"
  extends HeatTransfer.Icons.PrescribedTemperature;
  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput T(unit="degRk") 
     annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  port.T = Modelica.Units.Conversions.from_degRk(T);
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
          textString="degRk")}), 
    Documentation(info="<html>
<p>
该模型表示一个变温边界条件
温度值 [degRk] （朗肯度）由输入信号
给模型。其效果是，该模型的实例就像一个
一个无限的水库，能够吸收或产生所需的能量
将温度保持在指定值所需的能量。
</p>
</html>"));
end PrescribedTemperature;