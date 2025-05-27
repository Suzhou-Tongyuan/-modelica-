within Modelica.Electrical.QuasiStatic.Polyphase.Functions;
function quasiRMS 
  "复数输入（电流或电压）的整体准有效值"
  extends Modelica.Icons.Function;
  import Modelica.ComplexMath.abs;
  input Complex u[:];
  output Real y;
  import Modelica.Constants.pi;
protected
  Integer m=size(u, 1) "相数";
algorithm
  // y := sum({abs(u[k]) for k in 1:m})/m;
  // 由于 https://trac.openmodelica.org/OpenModelica/ticket/4496，使用替代实现
  y :=sum({sqrt(u[k].re^2 + u[k].im^2) for k in 1:m})/m;
  annotation (Inline=true, Documentation(info="<html>
  此函数确定多相系统的连续准 <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">有效值</a>，由 m 个准静态时域相量表示。
</html>"));
end quasiRMS;