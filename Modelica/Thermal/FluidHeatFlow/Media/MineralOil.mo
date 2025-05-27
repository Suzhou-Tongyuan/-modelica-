within Modelica.Thermal.FluidHeatFlow.Media;
record MineralOil "介质：60 degC和 1 bar时矿物油的特性"
extends FluidHeatFlow.Media.Medium(
    rho=868, 
    cp=2010, 
    cv=2010, 
    lambda=0.14, 
    nu=81.8E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html><p>
介质：60 °C和 1 bar时矿物油的特性
</p>
</html>"));
end MineralOil;