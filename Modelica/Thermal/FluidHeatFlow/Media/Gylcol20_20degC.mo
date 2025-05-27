within Modelica.Thermal.FluidHeatFlow.Media;
record Gylcol20_20degC "介质：在 20 degC和 1 bar条件下，乙二醇与水的比例为20:80"
extends FluidHeatFlow.Media.Medium(
    rho=1028, 
    cp=3910, 
    cv=3910, 
    lambda=0.523, 
    nu=1.69E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html><p>
介质：在 20 °C和 1 bar条件下，乙二醇与水的比例为 20:80。
</p>
</html>"));
end Gylcol20_20degC;