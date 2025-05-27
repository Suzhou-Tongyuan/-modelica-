within Modelica.Electrical.Batteries.ParameterRecords.TransientData;
record RCData "RC元件的参数"
  extends Modelica.Electrical.Batteries.Icons.TransientCellRecord(CellType="RC元件");
  parameter SI.Resistance R "RC元件的电阻";
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 "在T_ref温度下的电阻温度系数";
  parameter SI.Capacitance C "RC元件的电容(=T/R)";
  annotation(defaultComponentPrefixes="parameter", defaultComponentName="rcData", 
  Documentation(info="<html>
<p>电池模型中RC元件的参数</p>
<h4>注意</h4>
<p>电容C可以通过时间常数T计算得出，即C=T/R。</p>
</html>"));
end RCData;