within Modelica.Magnetic.FluxTubes.Basic;
model ConstantReluctance "恒定磁阻"
  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;

  parameter SI.Reluctance R_m=1 "磁阻";

equation
  V_m = Phi*R_m;

  annotation (defaultComponentName="reluctance", Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-40},{150,-80}}, 
          textString="R_m=%R_m", 
          textColor={0,0,0})}), Documentation(info="<html>
<p>
这种恒定磁阻是为测试目的和简单的磁网络模型提供的。磁阻不是根据磁通管的几何形状和磁导率计算的，而是作为参数提供的.
</p>
</html>"));
end ConstantReluctance;