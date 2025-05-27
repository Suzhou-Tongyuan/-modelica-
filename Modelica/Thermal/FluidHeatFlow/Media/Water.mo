within Modelica.Thermal.FluidHeatFlow.Media;
record Water "介质：30 degC和 1 bar水的特性"
extends FluidHeatFlow.Media.Medium(
    rho=995.6, 
    cp=4177, 
    cv=4177, 
    lambda=0.615, 
    nu=0.8E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html><p>
介质：30 °C和 1 bar水的特性
</p>
</html>"));
end Water;