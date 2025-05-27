within Modelica.Mechanics.Translational.Sources;
model ConstantSpeed "恒定速度，不依赖于力"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter SI.Velocity v_fixed 
    "固定速度（如果为负，则力作用为负载）";
  SI.Velocity v 
    "一维平动接口相对于支撑的速度（= der(s))";
equation
  v = der(s);
  v = v_fixed;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
          Line(points={{-60,60},{-60,-10}}, color={192,192,192}), 
          Line(points={{-75,0},{75,0}}, color={192,192,192}), 
                                  Line(points={{10,-15},{10,70}}, color={0,0,127}), 
      Text(extent={{-120,-50},{120,-20}}, 
          textString="%v_fixed")}),         Documentation(info="<html>
<p>
一维平动接口的<strong>固定</strong>速度模型，不依赖于力。
</p>
</html>"));
end ConstantSpeed;