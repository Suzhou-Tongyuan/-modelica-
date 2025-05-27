within Modelica.Thermal.FluidHeatFlow.Media;
record Water_90degC "介质：90 degC和 1 bar水的特性"
extends FluidHeatFlow.Media.Medium(
    rho=965.3, 
    cp=4205, 
    cv=4205, 
    lambda=0.676, 
    nu=0.347E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html><p>
介质：90 °C和 1 bar水的特性
</p>
</html>"));
end Water_90degC;