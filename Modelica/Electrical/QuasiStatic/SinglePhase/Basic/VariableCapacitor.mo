within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model VariableCapacitor "单相可变电容"
  extends Interfaces.OnePort;
  import Modelica.ComplexMath.j;
  Modelica.Blocks.Interfaces.RealInput C(unit="F") "可变电容" 
    annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
equation
  i = j*omega*C*v;
  annotation (defaultComponentName="capacitor", 
    Icon(graphics={
        Line(points={{-90,0},{-6,0}}, color={85,170,255}), 
        Line(points={{6,0},{90,0}}, color={85,170,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-6,28},{-6,-28}}, 
          color={85,170,255}), 
        Line(
          points={{6,28},{6,-28}}, 
          color={85,170,255})}), 
    Documentation(info="<html>

<p>
线性电容器通过 <code><u>i</u> = j*&omega;*C*<u>v</u></code> 将电压 <code><u>v</u></code> 与电流 <code><u>i</u></code> 连接。
电容 <code>C</code> 作为输入信号给出。
</p>

<h4>注意</h4>
<p>
在准静态操作下可变电容器的抽象假设为：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Basic/dc_dt.png\"
     alt=\"dc_dt.png\">。
</div>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Resistor\">电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Conductor\">导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Capacitor\">电容器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Inductor\">电感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Impedance\">阻抗</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Admittance\">导纳</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableResistor\">可变电阻</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableConductor\">可变导体</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableInductor\">可变电感器</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableImpedance\">可变阻抗</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic.VariableAdmittance\">可变导纳</a>
</p>
</html>"));
end VariableCapacitor;