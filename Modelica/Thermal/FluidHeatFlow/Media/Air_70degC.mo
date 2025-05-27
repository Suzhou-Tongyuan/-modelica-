within Modelica.Thermal.FluidHeatFlow.Media;
record Air_70degC "介质：温度为 70 degC、压力为 1 bar时的空气特性"
extends FluidHeatFlow.Media.Medium(
    rho=1.015, 
    cp=1010, 
    cv=723, 
    lambda=0.0293, 
    nu=20.3E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html><p>
介质：温度为 70 °C、压力为 1 bar时的空气特性
</p>
</html>"));
end Air_70degC;