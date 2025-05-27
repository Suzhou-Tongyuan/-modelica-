within Modelica.Electrical.Machines.Losses.DCMachines;
function brushVoltageDrop "碳刷电压降"
  extends Modelica.Icons.Function;
  input Machines.Losses.BrushParameters brushParameters "碳刷损失参数";
  input SI.Current i "实际电流";
  output SI.Voltage v "电压降";
algorithm
  if (brushParameters.V <= 0) then
    v := 0;
  else
    v := if (i > +brushParameters.ILinear) then +brushParameters.V else 
      if (i < -brushParameters.ILinear) then -brushParameters.V else 
      brushParameters.V*i/brushParameters.ILinear;
  end if;
  annotation (Documentation(info="<html>
<p>
根据碳刷损耗<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">Brush</a>计算碳刷电压降，
例如，用于初始方程。
</p>
</html>"));
end brushVoltageDrop;