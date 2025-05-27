within Modelica.Electrical.Machines.SpacePhasors.Functions;
function quasiRMS "计算输入的准有效值"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input Real x[3];
  output Real y;
protected
  Integer m=size(x, 1) "相数";
  SI.Angle phi[m]= 
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
  Real h[2]=TransformationMatrix*x;
algorithm
  y := sqrt(h[1]^2 + h[2]^2)/sqrt(2);
  annotation (Inline=true, Documentation(info="<html>
  将m相值(电压或电流)转换为空间相量，并计算空间相量的长度除以sqrt(2)。
</html>"));
end quasiRMS;