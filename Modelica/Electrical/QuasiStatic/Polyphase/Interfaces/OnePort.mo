within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model OnePort "两个接口、参考连接和电压、电流声明"
  parameter Integer m(min=1) = 3 "相位数" annotation(Evaluate=true);
  SI.ComplexVoltage v[m] "复电压";
  SI.Voltage abs_v[m]=Modelica.ComplexMath.abs(v) 
    "复电压的幅值";
  SI.Angle arg_v[m]=Modelica.ComplexMath.arg(v) 
    "复电压的幅角";
  SI.ComplexCurrent i[m] "复电流";
  SI.Current abs_i[m]=Modelica.ComplexMath.abs(i) 
    "复电流的幅值";
  SI.Angle arg_i[m]=Modelica.ComplexMath.arg(i) 
    "复电流的幅角";
  SI.ActivePower P[m]={Modelica.ComplexMath.real(v[k]* 
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "有功功率";
  SI.ActivePower P_total=sum(P) "总有功功率";
  SI.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]* 
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "无功功率";
  SI.ReactivePower Q_total=sum(Q) "总无功功率";
  SI.ApparentPower S[m]={Modelica.ComplexMath.abs(v[k]* 
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} 
    "复视在功率的幅值";
  SI.ApparentPower S_total=sqrt(P_total^2 + Q_total^2) 
    "总复视在功率的幅值";
  Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 1
      :m} "功率因数";
  /*
  Real pf_total = cos(Modelica.ComplexMath.arg(Complex(P_total,Q_total)))
    "总功率因数";
  */
  SI.AngularVelocity omega 
    "参考系的角速度";

  PositivePlug plug_p(final m=m) 
    "正准静态多相插头" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  NegativePlug plug_n(final m=m) 
    "负准静态多相插头" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
equation
  Connections.branch(plug_p.reference, plug_n.reference);
  plug_p.reference.gamma = plug_n.reference.gamma;
  omega = der(plug_p.reference.gamma);
  v = plug_p.pin.v - plug_n.pin.v;
  i = plug_p.pin.i;
  plug_p.pin.i + plug_n.pin.i = fill(Complex(0), m);
  annotation (Documentation(info="<html>
<p>
这个部分模型使用了一个<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">正</a>
和一个<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">负插头</a>，并定义了复电压差和复电流（进入正插头）。
一个<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p\">正</a>和
一个<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n\">负适配器</a> 用于轻松访问两个插头的单个引脚。此外，准静态系统的角速度显式地定义为变量。此模型主要用于用户模型的文本表示。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlug\">TwoPlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end OnePort;