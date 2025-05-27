within Modelica.Thermal.FluidHeatFlow.Media;
record Gylcol50_20degC "介质：在 20 degC和 1 bar条件下，乙二醇与水的比例为50:50"
extends FluidHeatFlow.Media.Medium(
    rho=1078, 
    cp=3300, 
    cv=3300, 
    lambda=0.405, 
    nu=3.98E-6);
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>介质：乙二醇：水 50:50（防冻剂 -40&deg;C）在 20&deg;C、1 bar条件下的特性</p>
</html>"));
end Gylcol50_20degC;