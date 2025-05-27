within Modelica.Electrical.Polyphase.Blocks;
block QuasiRMS
  extends Modelica.Blocks.Interfaces.SO; // 扩展了单输入单输出模块接口

  parameter Integer m(min=2) = 3 "相数" annotation(Evaluate=true); // 相数参数

  Modelica.Blocks.Interfaces.RealInput u[m] 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}))); // 输入端口

equation
  y = Polyphase.Functions.quasiRMS(u); // 计算输入信号的准均方根值

  annotation (defaultComponentName="rms", Documentation(info="<html>
<p>
该模块确定多相系统的连续准<a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">均方根</a>值，表示等效的均方根矢量或相量。如果输入波形偏离正弦曲线，传感器的输出将不会完全是平均均方根值。
</p>
<blockquote><pre>
y=sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end QuasiRMS;