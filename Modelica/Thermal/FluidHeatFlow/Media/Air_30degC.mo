within Modelica.Thermal.FluidHeatFlow.Media;
record Air_30degC "介质：温度为 30 degC、压力为 1 bar时的空气特性"
extends FluidHeatFlow.Media.Medium(
    rho=1.149, 
    cp=1007, 
    cv=720, 
    lambda=0.0264, 
    nu=16.3E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html><p>
介质：温度为 30 °C、压力为 1 bar时的空气特性
</p>
</html>"));
end Air_30degC;