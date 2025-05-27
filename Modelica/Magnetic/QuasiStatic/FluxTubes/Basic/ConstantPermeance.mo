within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model ConstantPermeance "恒定磁导率"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Reluctance;

  parameter SI.Permeance G_m=1 "磁导率";

equation
  G_m * V_m = Phi;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{70,0},{90,0}}, color={255,170,85}), 
      Text(
        extent={{-150,50},{150,90}}, 
        textString="%name", 
        textColor={0,0,255})}), Documentation(info="<html>
<p>
该恒定磁导率用于测试目的和简单的磁网络模型。磁导率不是根据磁通管的几何形状和磁导率计算出来的，而是作为参数提供的.
</p>
</html>", 
      revisions="<html>
</html>"));
end ConstantPermeance;