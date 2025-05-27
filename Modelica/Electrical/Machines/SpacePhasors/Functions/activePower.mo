within Modelica.Electrical.Machines.SpacePhasors.Functions;
function activePower 
  "计算电压和电流输入的有功功率"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;
  input SI.Voltage v[m] "相电压";
  input SI.Current i[m] "相电流";
  output SI.Power p "有功功率";
protected
  constant Integer m=3 "相数";
  SI.Voltage v_[2] "电压空间相量";
  SI.Current i_[2] "电流空间相量";
algorithm
  v_ := zeros(2);
  i_ := zeros(2);
  for k in 1:m loop
    v_ := v_ + 2/m*{+cos((k - 1)/m*2*pi),+sin(+(k - 1)/m*2*pi)}*v[k];
    i_ := i_ + 2/m*{+cos((k - 1)/m*2*pi),+sin(+(k - 1)/m*2*pi)}*i[k];
  end for;
  p := m/2*(+v_[1]*i_[1] + v_[2]*i_[2]);
  annotation (Inline=true, Documentation(info="<html>
将三相电压和电流转换为空间相量，并计算有功功率。
</html>"));
end activePower;