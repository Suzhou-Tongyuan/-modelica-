within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model TwoPin "两引脚"
import Modelica.Constants.eps;
extends Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPinElementary;

SI.ComplexVoltage v "复电压";
SI.Voltage abs_v=Modelica.ComplexMath.abs(v) "复电压的幅值";
SI.Angle arg_v=Modelica.ComplexMath.arg(v) "复电压的参数";
SI.ComplexCurrent i "复电流";
SI.Current abs_i=Modelica.ComplexMath.abs(i) "复电流的幅值";
SI.Angle arg_i=Modelica.ComplexMath.arg(i) "复电流的参数";
SI.ActivePower P=Modelica.ComplexMath.real(v* 
Modelica.ComplexMath.conj(i)) "有功功率";
SI.ReactivePower Q=Modelica.ComplexMath.imag(v* 
Modelica.ComplexMath.conj(i)) "无功功率";
SI.ApparentPower S=Modelica.ComplexMath.abs(v* 
Modelica.ComplexMath.conj(i)) "复视在功率的幅值";
Real pf=cos(Modelica.ComplexMath.arg(Complex(P, Q))) "功率因数";
SI.AngularVelocity omega "参考框架的角速度";

equation
v = pin_p.v - pin_n.v;
i = pin_p.i;
annotation (Documentation(info="<html>

<p>
该部分模型使用<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">正向</a>
和<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">负向引脚</a>，
并定义了复电压差和复电流（进入正向引脚）。
此外，准静态系统的角速度被明确定义为变量。
此模型主要用于用户模型的图形表示。
</p>
<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPinElementary\">TwoPinElementary</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPin;