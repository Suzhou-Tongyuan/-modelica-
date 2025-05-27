within Modelica.Magnetic.FluxTubes.Basic;
model VariableReluctance "可变磁阻"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;
  Modelica.Blocks.Interfaces.RealInput R_m(quantity="Reluctance", unit="H-1") "磁阻" 
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));

equation
  V_m = Phi*R_m;

  annotation (defaultComponentName="reluctance",      Documentation(info="<html>
<p>
该模型的磁阻由实信号输入控制.
</p>
</html>"));
end VariableReluctance;