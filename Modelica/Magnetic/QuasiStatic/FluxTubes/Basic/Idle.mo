within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model Idle "空转支路"
  extends Interfaces.TwoPort;
equation
  Phi = Complex(0);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-100,0},{-40,0}}, color={255,170,85}), 
        Line(points={{40,0},{100,0}}, color={255,170,85}), 
      Text(
        extent={{-150,50},{150,90}}, 
        textString="%name", 
        textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
这是一个简单的空闲运行分支。通过这个分量的磁通量等于零.
</p></html>", 
      revisions="<html>
</html>"));
end Idle;