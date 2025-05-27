within Modelica.Electrical.Machines.Losses;
record BrushParameters "电刷损耗的参数记录"
  extends Modelica.Icons.Record;
  parameter SI.Voltage V=0 
    "对电流>ILinear的总电刷电压降";
  parameter SI.Current ILinear(start=0.01) 
    "表示电刷电压降的线性电压区域的电流";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
用于<a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.Brush\">三相电刷</a>和<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">直流电刷</a>损耗的参数记录。
</p>
</html>"));
end BrushParameters;