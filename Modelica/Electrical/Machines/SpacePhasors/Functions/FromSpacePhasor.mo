within Modelica.Electrical.Machines.SpacePhasors.Functions;
function FromSpacePhasor 
  "从空间相量和零序分量转换为多相值"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;
  input Real x[2] "空间相量";
  input Real x0 "零序分量";
  input Integer m "相数";
  output Real y[m] "多相输出";
protected
  parameter SI.Angle phi[m]= 
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
  parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])} 
      for k in 1:m};

algorithm
  y := fill(x0, m) + InverseTransformation*x;

  annotation (Inline=true, Documentation(info="<html>
将空间相量和零序值转换为多相值(电压或电流)。
</html>"));
end FromSpacePhasor;