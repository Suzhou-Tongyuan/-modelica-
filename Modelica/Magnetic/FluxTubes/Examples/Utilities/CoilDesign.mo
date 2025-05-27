within Modelica.Magnetic.FluxTubes.Examples.Utilities;
record CoilDesign 
  "计算绕组参数（导线直径、匝数等），并使用可选参数重新计算；适用于特定的设计任务"
  extends Modelica.Icons.Record;

  parameter SI.Resistivity rho_20=0.0178e-6 
    "导体材料在 20 摄氏度时的电阻率（默认值：铜）";
  parameter SI.LinearTemperatureCoefficient alpha_20=0.0039 
    "20 摄氏度时导体材料电阻率的温度系数（默认值：铜）";
  parameter SI.Temperature T_op=293.15 "绕组工作温度";

  final parameter SI.Resistivity rho=rho_20*(1 + alpha_20*(T_op - (20 - 
      Modelica.Constants.T_zero))) "Resistivity at operating temperature";

  parameter SI.Length h_w "绕组横截面高度";
  parameter SI.Length b_w "绕组横截面宽度";

  final parameter SI.Area A_w=h_w*b_w "绕组横截面积";

  parameter SI.Length l_avg "一圈的平均长度";

  parameter SI.Voltage V_op 
    "工作电压（额定电压/最低电压/最高电压，取决于设计目标）";

  parameter SI.CurrentDensity J_desired=4e6 
    "工作温度和电压下的预期电流密度。";

  parameter Real c_condFillChosen=0.6 
    "选择的导体填充系数 = 无绝缘的导体总面积/绕组总面积";

  final parameter Real N_calculated=V_op/(rho*l_avg*J_desired) 
    "计算转数";

  final parameter SI.Diameter d_wireCalculated=sqrt(4*A_w* 
      c_condFillChosen/(pi*N_calculated)) 
    "计算线径（不含绝缘层）";

  final parameter SI.Area A_wireCalculated=pi*d_wireCalculated^2/4 
    "计算导线横截面积";

  final parameter SI.Resistance R_calculated=rho*N_calculated*l_avg/ 
      A_wireCalculated 
    "工作温度和电压下的绕组电阻，与计算匝数和线径有关";

  final parameter SI.Power P_calculated=V_op^2/R_calculated 
    "工作温度和电压下的绕组欧姆损耗与计算匝数和线径的关系";

  parameter SI.Diameter d_wireChosen=d_wireCalculated 
    "所选可用线径（无绝缘材料）" 
    annotation (Dialog(group="Chosen feasible parameters (optional)"));

  parameter Real N_chosen=N_calculated "选择的圈数" 
    annotation (Dialog(group="Chosen feasible parameters (optional)"));

  final parameter SI.Area A_wireChosen=pi*d_wireChosen^2/4 
    "根据所选金属丝直径得出的金属丝横截面积";

  final parameter SI.Resistance R_actual=rho*N_chosen*l_avg/A_wireChosen 
    "工作温度和电压下的绕组电阻与所选匝数和线径有关";

  final parameter SI.Power P_actual=V_op^2/R_actual 
    "绕组在工作温度和电压下的欧姆损耗与所选匝数和线径有关";

  final parameter SI.CurrentDensity J_actual=V_op*4/(R_actual*pi* 
      d_wireChosen^2) 
    "工作温度和电压下的电流密度与所选匝数和线径有关";

  final parameter Real c_condFillActual=N_chosen*pi*d_wireChosen^2/(4*A_w) 
    "导体填充因数由选择的匝数和导线直径得出";

  annotation (Documentation(info="<html>
<p>
该模型示例显示了在给定绕组横截面积的情况下，根据所需的工作条件（电压、温度、电流密度、导体填充系数）确定绕组尺寸（导线直径、匝数）。可根据给定的参数和特定设计项目的要求对其进行修改.
</p>

<p>
计算得出的绕组电阻和匝数可作为待建模设备电气子系统的输入参数。
的输入参数。工作电压 V_op 可分别为特定设计项目指定的最低、额定和最高电压。结合工作温度 T_op 的设置，可在最坏情况下对设备进行分析（例如，分别为最小所需磁动力、最大允许欧姆损耗、最小和最大力）。.
</p>

<p>
在制造绕组时，必须将计算得出的线径 d_wireCalculated 四舍五入为可用线径。为了分析四舍五入的影响，可以将所选线径 d_wireChosen 和匝数 N_chosen 作为可选输入。计算得出的绕组参数可与其他方法得出的参数进行比较.
</p>
</html>"));

end CoilDesign;