within Modelica.Thermal.FluidHeatFlow.Media;
record Water_10degC "介质：10 degC和 1 bar时水的特性"
extends FluidHeatFlow.Media.Medium(
    rho=999.7, 
    cp=4192, 
    cv=4192, 
    lambda=0.588, 
    nu=1.307E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html><p>
介质：10 °C和 1 bar时水的特性
</p>
</html>"));
end Water_10degC;