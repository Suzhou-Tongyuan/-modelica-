within Modelica.Electrical.Machines.Losses.DCMachines;
model Brush "考虑碳刷电压降的模型"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Machines.Losses.BrushParameters brushParameters 
    "碳刷损失参数";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT(
      useHeatPort=false);
equation
  if (brushParameters.V <= 0) then
    v = 0;
  else
    v = smooth(0, if (i > +brushParameters.ILinear) then +brushParameters.V 
       else if (i < -brushParameters.ILinear) then -brushParameters.V 
       else brushParameters.V*i/brushParameters.ILinear);
  end if;
  lossPower = v*i;
  annotation (Icon(graphics={
        Line(points={{-100,-100},{-92,-80},{-80,-60},{-60,-40},{-40,-28}, 
              {-20,-22},{0,-20},{20,-22},{40,-28},{60,-40},{80,-60},{92,-80}, 
              {100,-100}}, color={0,0,255}), 
        Polygon(
          points={{-20,-22},{-40,-28},{-40,20},{40,20},{40,-28},{20,-22}, 
              {0,-20},{-20,-22}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-40,0}}, color={0,0,255}), 
        Line(points={{40,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,80},{150,40}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
<p>
考虑碳刷电压降和损失的模型。对于介于<code>-ILinear</code>和<code>ILinear</code>之间的电流，
电压降呈线性行为，如图1所示。对于大于或等于<code>ILinear</code>的正电流，电压降等于<code>V</code>。
对于小于或等于<code>-ILinear</code>的负电流，电压降等于<code>-V</code>。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"1\">
  <tr><td> <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/brush.png\"
                alt=\"brush.png\"> </td> </tr>
  <tr><td> <strong>图1:</strong>碳刷电压降模型</td> </tr>
</table>
<h4>注</h4>
<p>
电压降<code>v</code>是所有串联碳刷的总电压降。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.Machines.Losses.BrushParameters\">BrushParameters</a>
</p>
<p>
如果希望忽略刷子损耗，请设置<code>brushParameters.V=0</code>(这是默认值)。
</p>
</html>"));
end Brush;