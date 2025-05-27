within Modelica.Electrical.Polyphase.Functions;
function factorY2D "计算因子Y到D(三角形的电压)"
  extends Modelica.Icons.Function; // 使用函数图标
  import Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems; // 导入对称基本系统数量函数
  import Modelica.Constants.pi; // 导入圆周率常数
  input Integer m=3 "相数"; // 输入参数为相数，默认为3
  input Integer kPolygon=1 "三角形的备选项"; // 输入参数为多边形的备选项，默认为1
  output Real y "Y 到 D 的因子"; // 输出参数为因子Y到D
protected
  parameter Integer mBasic=integer(m/numberOfSymmetricBaseSystems(m)); // 基本系统相数
algorithm
  if mBasic==2 then
    y := sqrt(2); // 当基本系统相数为2时
  else
    if kPolygon<1 or kPolygon>(mBasic - 1)/2 then
      y := 2*sin(pi/mBasic); // 如果kPolygon不在范围1≤kPolygon≤(mBasic-1)/2中，则按kPolygon=1计算
    else
      y := 2*sin(kPolygon*pi/mBasic); // 否则按照kPolygon计算
    end if;
  end if;
  annotation (Documentation(info="<html>
<p>
从线到中性的电压计算线到线电压。
</p>
<h4>注意</h4>
<p>
对于m>3相数，可以选择多个线到线电压的变体。
如果输入的kPolygon不在范围1≤kPolygon≤(mBasic-1)/2中，则该函数将计算kPolygon=1的情况。
</p>
</html>"));
end factorY2D;