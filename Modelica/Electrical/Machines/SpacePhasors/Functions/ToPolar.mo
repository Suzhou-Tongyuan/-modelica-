within Modelica.Electrical.Machines.SpacePhasors.Functions;
function ToPolar "将空间相量转换为极坐标"
  extends Modelica.Icons.Function;
  input Real x[2] "空间相量的实部和虚部";
  output Real absolute "空间相量的幅值";
  output SI.Angle angle "空间相量的角度";
protected
  constant Real small=Modelica.Constants.small;
algorithm
  absolute := sqrt(x[1]^2 + x[2]^2);
  angle := if absolute <= small then 0 else Modelica.Math.atan2(x[2], x[1]);
  /*
  if absolute <= small then
    angle := 0;
  else
    if x[2] >= 0 then
      angle :=  Modelica.Math.acos(x[1]/absolute);
    else
      angle := -Modelica.Math.acos(x[1]/absolute);
    end if;
  end if;
*/
  annotation (Inline=true, Documentation(info="<html>
将空间相量从直角坐标转换为极坐标，对{0,0}提供角度=0。
</html>"));
end ToPolar;