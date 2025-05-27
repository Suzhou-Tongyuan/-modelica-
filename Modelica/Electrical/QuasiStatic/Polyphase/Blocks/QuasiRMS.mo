within Modelica.Electrical.QuasiStatic.Polyphase.Blocks;
block QuasiRMS
  extends Modelica.Blocks.Interfaces.SO;
  parameter Integer m(min=2) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.ComplexBlocks.Interfaces.ComplexInput u[m] 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  y = QuasiStatic.Polyphase.Functions.quasiRMS(u);

  annotation (defaultComponentName="rms", Documentation(info="<html>
<p>
该模块确定多相系统的连续准静态 <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> 值，表示等效的 RMS 矢量或相量。
</p>
<blockquote><pre>
y = sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end QuasiRMS;