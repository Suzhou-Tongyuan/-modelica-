within Modelica.Thermal.HeatTransfer.Sources;
model PrescribedTemperature 
  "以开尔文为单位的可变温度边界条件"

  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90, 
            -10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput T(unit="K") annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));
equation
  port.T = T;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}}, 
          pattern=LinePattern.None, 
          fillColor={159,159,223}, 
          fillPattern=FillPattern.Backward), 
        Line(
          points={{-102,0},{64,0}}, 
          color={191,0,0}, 
          thickness=0.5), 
        Text(
          extent={{0,0},{-100,-100}}, 
          textString="K"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(
          points={{50,-20},{50,20},{90,0},{50,-20}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p>
该模型代表一种可变温度边界条件。模型以开尔文（K）为单位的温度值作为输入信号T。其效果在于：该模型的实例将充当一个无限容体，能够吸收或释放维持指定温度所需的任意能量。
</p>
</html>"));
end PrescribedTemperature;