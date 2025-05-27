within Modelica.Mechanics.MultiBody.Examples.Loops.Utilities;
partial block Engine1bBase 
  "单缸发动机的基础模型(包含气体力)"
  extends Engine1Base;

  GasForce2 gasForce(d=0.1, L=0.35) 
    annotation (Placement(transformation(
      origin={90,80}, 
      extent={{10,-10},{-10,10}}, 
      rotation=90)));
  annotation();
end Engine1bBase;