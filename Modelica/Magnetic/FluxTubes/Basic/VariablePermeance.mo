within Modelica.Magnetic.FluxTubes.Basic;
model VariablePermeance "可变磁导"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;
  Modelica.Blocks.Interfaces.RealInput G_m(quantity="Permeance", unit="H") "磁导" 
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));

equation
  G_m * V_m = Phi;

  annotation (defaultComponentName="permeance",      Documentation(info="<html>
<p>
该模型的磁导率由实信号输入控制.
</p>
</html>"));
end VariablePermeance;