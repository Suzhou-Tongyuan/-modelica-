within Modelica.Magnetic.FluxTubes.Basic;
model Ground "零磁势"

  FluxTubes.Interfaces.PositiveMagneticPort port annotation (Placement(
        transformation(extent={{-10,110},{10,90}}, rotation=-0)));
equation
  port.V_m = 0;
  annotation (
    Documentation(info="<html>
<p>
磁地节点的磁势为零。每个磁网络模型必须至少包含一个磁地对象.
</p>
</html>"), 
    Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{-60,50},{60,50}}, color={255,127,0}), 
      Line(points={{-40,30},{40,30}}, color={255,127,0}), 
      Line(points={{-20,10},{20,10}}, color={255,127,0}), 
      Line(points={{0,90},{0,50}}, color={255,127,0}), 
      Text(
        extent={{-150,-50},{150,-10}}, 
        textColor={0,0,255}, 
        textString="%name")}));
end Ground;