within Modelica.Mechanics.Rotational.Sources;
model ConstantSpeed "恒定转速，不依赖于扭矩"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  SI.AngularVelocity w 
    "一维转动接口相对于支撑组件的角速度（= der(phi)）";
  parameter SI.AngularVelocity w_fixed "固定转速";
equation
  w = der(phi);
  w = w_fixed;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
          Line(points={{-60,60},{-60,-10}}, color={192,192,192}), 
          Line(points={{-75,0},{75,0}}, color={192,192,192}), 
          Line(points={{10,-15},{10,70}}, color={0,0,127}), 
          Text(extent={{-120,-50},{120,-20}}, textString="%w_fixed")}), 
    Documentation(info="<html>
<p>
一维转动接口的<strong>固定</strong>角速度模型，不依赖于扭矩。
</p>
</html>"));
end ConstantSpeed;