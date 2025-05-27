within Modelica.Electrical.Machines.SpacePhasors.Functions;
function ToSpacePhasor 
  "从多相输入转换为空间相量和零序分量"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;
  input Real x[:] "多相(电压或电流)输入";
  output Real y[2] "空间相量";
  output Real y0 "零序分量(电压或电流)";
protected
  parameter Integer m=size(x, 1) "相数" annotation(Evaluate=true);
  parameter SI.Angle phi[m]= 
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
  parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])} 
      for k in 1:m};
algorithm
  y := TransformationMatrix*x;
  y0 := 1/m*sum(x);
  annotation (Inline=true, Documentation(info="<html>
将多相值(电压或电流)转换为空间相量和零序值。
</html>"));
end ToSpacePhasor;