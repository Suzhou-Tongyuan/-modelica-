within Modelica.Mechanics.Rotational.Sources;
model Move 
  "根据角度、速度和角加速度信号强制转动一维转动接口的模型"
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

  SI.Angle phi 
    "一维转动接口相对支撑组件的旋转角度";
  Modelica.Blocks.Interfaces.RealInput u[3] 
    "作为输入信号的一维转动接口相对支撑组件的角度、角速度和角加速度" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  function position
    extends Modelica.Icons.Function;
    input Real q_qd_qdd[3] 
      "位置、速度、加速度的所需值";
    input Real dummy 
      "只是为了有一个输入信号，应该对其进行微分以避免在Modelica工具中可能出现的问题（未使用）";
    output Real q;
  algorithm
    q := q_qd_qdd[1];
    annotation (derivative(noDerivative=q_qd_qdd) = position_der, InlineAfterIndexReduction=true);
  end position;

  function position_der
    extends Modelica.Icons.Function;
    input Real q_qd_qdd[3] 
      "位置、速度、加速度的所需值";
    input Real dummy 
      "只是为了有一个输入信号，应该对其进行微分以避免在Modelica工具中可能出现的问题（未使用）";
    input Real dummy_der;
    output Real qd;
  algorithm
    qd := q_qd_qdd[2];
    annotation (derivative(
        noDerivative=q_qd_qdd, 
        order=2) = position_der2, InlineAfterIndexReduction=true);
  end position_der;

  function position_der2
    extends Modelica.Icons.Function;
    input Real q_qd_qdd[3] 
      "位置、速度、加速度的所需值";
    input Real dummy 
      "只是为了有一个输入信号，应该对其进行微分以避免在Modelica工具中可能出现的问题（未使用）";
    input Real dummy_der;
    input Real dummy_der2;
    output Real qdd;
    annotation();
  algorithm
    qdd := q_qd_qdd[3];
  end position_der2;

equation
  phi = flange.phi - phi_support;
  phi = position(u, time);
  annotation (
    Documentation(info="<html>
<p>
一维转动接口 <strong>flange</strong> 根据输入信号相对于一维转动接口支撑组件进行预定义的运动：
</p>
<blockquote><pre>
u[1]: angle of flange
u[2]: angular velocity of flange
u[3]: angular acceleration of flange
</pre></blockquote>
<p>
用户必须保证输入信号之间的一致性，
即 u[2] 是 u[1] 的导数，并且
u[3] 是 u[2] 的导数。然而，
也有应用场景是故意不满足这些条件的。例如，
如果仅需要计算机械系统的位置相关项，可以提供一个角度 = 角度(t)，并将角速度和角加速度设置为零。
</p>
<p>
输入信号可以从Modelica.Blocks.Sources块库中的信号发生器块之一提供。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Rectangle(lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-100.0,-20.0},{100.0,20.0}}), 
    Line(points={{-30.0,-32.0},{30.0,-32.0}}), 
    Line(points={{0.0,52.0},{0.0,32.0}}), 
    Line(points={{-29.0,32.0},{30.0,32.0}}), 
    Line(points={{0.0,-32.0},{0.0,-100.0}}), 
    Text(textColor={0,0,255}, 
      extent={{-150.0,60.0},{150.0,100.0}}, 
      textString="%name"), 
    Text(extent={{-140,-60},{-40,-30}}, 
          textColor={128,128,128}, 
          horizontalAlignment=TextAlignment.Right, 
          textString="phi,w,a")}));
end Move;