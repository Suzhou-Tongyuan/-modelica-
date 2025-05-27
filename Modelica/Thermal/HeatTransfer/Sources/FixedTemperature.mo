within Modelica.Thermal.HeatTransfer.Sources;
model FixedTemperature "以开尔文为单位的固定温度边界条件"

  parameter SI.Temperature T "端口温度固定";
  Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90, 
            -10},{110,10}})));
equation
  port.T = T;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-110},{150,-140}}, 
          textString="T=%T"), 
        Rectangle(
          extent={{-100,100},{100,-100}}, 
          pattern=LinePattern.None, 
          fillColor={159,159,223}, 
          fillPattern=FillPattern.Backward), 
        Text(
          extent={{0,0},{-100,-100}}, 
          textString="K"), 
        Line(
          points={{-52,0},{56,0}}, 
          color={191,0,0}, 
          thickness=0.5), 
        Polygon(
          points={{50,-20},{50,20},{90,0},{50,-20}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p>
该模型在其端口处以开尔文（K）为单位定义了一个固定温度T，即，它将固定温度作为边界条件进行定义。
</p>
</html>"));
end FixedTemperature;