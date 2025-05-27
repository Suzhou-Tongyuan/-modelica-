within Modelica.Thermal.FluidHeatFlow.Media;
record Medium "包含介质属性的记录"
  extends Modelica.Icons.Record;
  parameter SI.Density rho = 1 "密度";
  parameter SI.SpecificHeatCapacity cp = 1 
    "恒压下的比热容";
  parameter SI.SpecificHeatCapacity cv = 1 
    "恒定体积下的比热容";
  parameter SI.ThermalConductivity lambda = 1 
    "导热系数";
  parameter SI.KinematicViscosity nu = 1 
    "运动黏度";
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html><p>
包含（恒定）介质属性的记录。
</p>
</html>"));
end Medium;