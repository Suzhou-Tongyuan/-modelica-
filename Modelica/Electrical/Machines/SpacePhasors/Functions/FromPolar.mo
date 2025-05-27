within Modelica.Electrical.Machines.SpacePhasors.Functions;
function FromPolar "将空间相量从极坐标转换"
  extends Modelica.Icons.Function;
  input Real absolute "空间相量的幅值";
  input SI.Angle angle "空间相量的角度";
  output Real x[2] "空间相量的实部和虚部";
protected
  constant Real small=Modelica.Constants.small;
algorithm
  x := absolute*{cos(angle),sin(angle)};
  annotation (Inline=true, Documentation(info="<html>
将空间相量从极坐标转换为直角坐标。
</html>"));
end FromPolar;