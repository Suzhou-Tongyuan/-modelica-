within Modelica.Mechanics.Translational.Sources;
model Move 
  "根据位置、速度和加速度信号强制移动一维平动接口"
  extends 
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  Modelica.Blocks.Interfaces.RealInput u[3] 
    "一维平动接口的位置、速度和加速度作为输入信号" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  function position
    extends Modelica.Icons.Function;
    input Real q_qd_qdd[3] 
      "位置、速度、加速度的所需值";
    input Real dummy 
      "只是为了有一个输入信号，应该对其进行微分以避免可能在 Modelica 工具中出现的问题（未使用）";
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
      "只是为了有一个输入信号，应该对其进行微分以避免可能在 Modelica 工具中出现的问题（未使用）";
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
      "只是为了有一个输入信号，应该对其进行微分以避免可能在 Modelica 工具中出现的问题（未使用）";
    input Real dummy_der;
    input Real dummy_der2;
    output Real qdd;
    annotation();
  algorithm
    qdd := q_qd_qdd[3];
  end position_der2;
equation
  s = position(u, time);

  annotation (
    Documentation(info="<html><p>
一维平动接口 <strong>flange_b</strong> 被 <strong>强制</strong> 相对于支撑连接器以预定义的运动移动，根据以下输入信号：
</p>
<pre><code >u[1]: position of flange
u[2]: velocity of flange
u[3]: acceleration of flange
</code></pre><p>
用户必须确保输入信号是相互一致的， 即，u[2] 是 u[1] 的导数， u[3] 是 u[2] 的导数。然而， 也有意为之的应用程序不满足这些条件。例如， 如果仅计算机械系统的位置相关项， 则可以提供 position = position(t) 并将速度 和加速度设为零。
</p>
<p>
输入信号可以来自 Modelica.Blocks.Sources 块库中的信号生成器块之一。
</p>
<p>
<br>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Line(points={{-30,-32},{30,-32}}, color={0,127,0}), 
        Line(points={{0,-32},{0,-100}}, color={0,127,0}), 
        Rectangle(
          extent={{-100,20},{100,-20}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{0,52},{0,32}}, color={0,127,0}), 
        Line(points={{-29,32},{30,32}}, color={0,127,0}), 
      Text(
        extent={{150,60},{-150,100}}, 
        textString="%name", 
        textColor={0,0,255}), 
      Text(extent={{-140,-60},{-40,-30}}, 
        textColor={128,128,128}, 
        horizontalAlignment=TextAlignment.Right, 
        textString="s,v,a")}));
end Move;