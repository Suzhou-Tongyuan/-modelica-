within Modelica.Mechanics.Rotational.Components;
model AngleToTorqueAdaptor 
  "用于具有扭矩输出和角度、速度以及可选加速度作为输入的旋转一维转动接口的信号适配器（特别适用于FMU）"
  parameter Boolean use_w=true 
    "= true，启用输入连接器 w（角速度）" annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  parameter Boolean use_a=true 
    "= true，启用输入连接器 a（角加速度）" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
      Placement(transformation(extent={{56,-10},{76,10}}), 
        iconTransformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealInput phi(unit="rad") 
    "驱动一维转动接口的角度" annotation (Placement(transformation(extent= 
           {{-80,60},{-40,100}}), iconTransformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Interfaces.RealInput w(unit="rad/s") if use_w or use_a 
    "驱动一维转动接口的速度（需要w=der(phi)）" annotation (
      Placement(transformation(extent={{-80,10},{-40,50}}), 
        iconTransformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2") if use_a 
    "驱动一维转动接口的角加速度（需要a = der(w)）" 
    annotation (Placement(transformation(extent={{-80,-50},{-40,-10}}), 
        iconTransformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m") 
    "根据phi、w、a驱动一维转动接口所需的扭矩" annotation (
      Placement(transformation(extent={{-40,-90},{-60,-70}}), 
        iconTransformation(extent={{-20,-90},{-40,-70}})));

protected
  Modelica.Mechanics.Rotational.Sources.Move move if use_a 
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3 if use_a 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor 
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));

  Modelica.Blocks.Routing.Multiplex2 multiplex2 if use_w and not use_a 
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Move_phi move_phi if not use_w and not use_a 
    annotation (Placement(transformation(extent={{10,70},{30,90}})));
  Move_w move_w if use_w and not use_a 
    annotation (Placement(transformation(extent={{10,40},{30,60}})));

  model Move_phi "根据角度信号强制移动一维转动接口"
    extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

    Modelica.Blocks.Interfaces.RealInput phi(
      final quantity="Angle", 
      final unit="rad", 
      displayUnit="deg") "一维转动接口相对支撑的旋转角度" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  equation
    phi = flange.phi - phi_support;
    annotation (Documentation(info="<html>
<p>
一维转动接口<strong>flange</strong>被强制相对一维转动接口支撑以预定义的运动方式移动， 根据输入信号u 
</p>
<blockquote><pre>
 u[1]: 一维转动接口的角度 
 u[2]: 一维转动接口的角速度
</pre></blockquote>
<p>
用户必须确保输入信号之间是一致的， 即u[2]是u[1]的导数。
</p>
<p>
 输入信号可以来自模型库 Modelica.Blocks.Sources 中的信号生成器块之一。
</p>
</html>"), 
       Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{-80,-60},{-80,-100}}, 
                  textString="phi"),Rectangle(
                  extent={{-100,20},{100,-20}}, 
                  lineColor={64,64,64}, 
                  fillPattern=FillPattern.HorizontalCylinder, 
                  fillColor={192,192,192}),Line(points={{-30,-32},{30,-32}}),Line(points={{0,52},{0,32}}),Line(
            points={{-29,32},{30,32}}),Line(points={{0,-32}, 
            {0,-100}}),Line(points={{30,-42},{20,-52}}),Line(points={{30,-32},{10,-52}}), 
            Line(points={{20,-32},{0,-52}}),Line(points={{10, 
            -32},{-10,-52}}),Line(points={{0,-32},{-20,-52}}),Line(points={{-10,-32},{-30,-52}}), 
            Line(points={{-20,-32},{-30,-42}}),Text(
                  extent={{-150,100},{150,60}}, 
                  textString="%name", 
                  textColor={0,0,255})}));
  end Move_phi;

public
model Move_w 
    "根据角度和速度信号强制移动一维转动接口"
    extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

    SI.Angle phi 
      "一维转动接口相对支撑的旋转角度";
    Modelica.Blocks.Interfaces.RealInput u[2] 
      "作为输入信号的一维转动接口相对支撑的角度和角速度" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  protected
    function position
      extends Modelica.Icons.Function;
      input Real q_qd[2] "位置和速度所需值";
      input Real dummy 
        "仅为了有一个输入信号，应对其进行微分以避免在Modelica工具中可能出现的问题（未使用）";
      output Real q;
    algorithm
      q := q_qd[1];
      annotation (derivative(noDerivative=q_qd) = position_der, 
          InlineAfterIndexReduction=true);
    end position;

    function position_der
      extends Modelica.Icons.Function;
      input Real q_qd[2] "位置与速度所需的值";
      input Real dummy 
        "只是为了有一个输入信号，该信号应该被微分以避免在Modelica工具中可能出现的问题（实际并未使用）";
      input Real dummy_der;
      output Real qd;
      annotation();
    algorithm
      qd := q_qd[2];
    end position_der;
  equation
    phi = flange.phi - phi_support;
    phi = position(u, time);
    annotation (Documentation(info="<html>
<p>  

一维转动接口<strong>flange</strong>被<strong>强制</strong>按照预定义的运动相对于一维转动接口的支撑组件进行移动，  

其运动根据以下输入信号确定：  

</p>  

<blockquote><pre>
u[1]: angle of flange
u[2]: angular velocity of flange
</pre></blockquote>

<p>  

用户必须保证输入信号之间的一致性，  

即u[2]是u[1]的导数。  

</p>  

<p>  

输入信号可以从Modelica.Blocks.Sources库中的信号发生器块之一提供。  

</p>  

</html>"  ), 
       Icon(coordinateSystem(
          preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{-80,-60},{-80,-100}}, 
                  textString="phi,w"),Rectangle(
                  extent={{-100,20},{100,-20}}, 
                  lineColor={64,64,64}, 
                  fillPattern=FillPattern.HorizontalCylinder, 
                  fillColor={192,192,192}),Line(points={{-30,-32},{30,-32}}),Line(points={{0,52},{0,32}}),Line(
            points={{-29,32},{30,32}}),Line(points={{0,-32}, 
            {0,-100}}),Line(points={{30,-42},{20,-52}}),Line(points={{30,-32},{10,-52}}), 
            Line(points={{20,-32},{0,-52}}),Line(points={{10, 
            -32},{-10,-52}}),Line(points={{0,-32},{-20,-52}}),Line(points={{-10,-32},{-30,-52}}), 
            Line(points={{-20,-32},{-30,-42}}),Text(
                  extent={{-150,100},{150,60}}, 
                  textString="%name", 
                  textColor={0,0,255})}));
  end Move_w;
equation
  connect(multiplex3.y, move.u) annotation (Line(
      points={{1,0},{8,0}}, 
      color={0,0,127}));
  connect(phi, multiplex3.u1[1]) annotation (Line(
      points={{-60,80},{-32,80},{-32,7},{-22,7}}, 
      color={0,0,127}));
  connect(w, multiplex3.u2[1]) annotation (Line(
      points={{-60,30},{-36,30},{-36,0},{-22,0}}, 
      color={0,0,127}));
  connect(a, multiplex3.u3[1]) annotation (Line(
      points={{-60,-30},{-32,-30},{-32,-7},{-22,-7}}, 
      color={0,0,127}));
  connect(flange, torqueSensor.flange_b) annotation (Line(
      points={{66,0},{56,0}}));
  connect(move.flange, torqueSensor.flange_a) annotation (Line(
      points={{30,0},{36,0}}));
  connect(torqueSensor.tau, tau) annotation (Line(
      points={{38,-11},{38,-80},{-50,-80}}, 
      color={0,0,127}));
  connect(multiplex2.y, move_w.u) annotation (Line(
      points={{1,50},{8,50}}, 
      color={0,0,127}));
  connect(phi, multiplex2.u1[1]) annotation (Line(
      points={{-60,80},{-46,80},{-46,80},{-32,80},{-32,56},{-22,56}}, 
      color={0,0,127}));
  connect(w, multiplex2.u2[1]) annotation (Line(
      points={{-60,30},{-28,30},{-28,44},{-22,44}}, 
      color={0,0,127}));
  connect(move_w.flange, torqueSensor.flange_a) annotation (Line(
      points={{30,50},{36,50},{36,0}}));
  connect(phi, move_phi.phi) annotation (Line(
      points={{-60,80},{8,80}}, 
      color={0,0,127}));
  connect(move_phi.flange, torqueSensor.flange_a) annotation (Line(
      points={{30,80},{36,80},{36,0}}));
  annotation (defaultComponentName="angleToTorqueAdaptor", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
      graphics={
        Rectangle(
          extent={{-20,100},{20,-100}}, 
          lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          radius=10), 
        Rectangle(
          extent={{-20,100},{20,-100}}, 
          lineColor={95,95,95}, 
          radius=10, 
          lineThickness=0.5), 
        Text(
          extent={{-20,92},{20,70}}, 
          fillPattern=FillPattern.Solid, 
          textString="phi"), 
        Text(
          visible=use_w or use_a, 
          extent={{-20,62},{20,40}}, 
          fillPattern=FillPattern.Solid, 
          textString="w"), 
        Text(
          visible=use_a, 
          extent={{-20,32},{20,10}}, 
          fillPattern=FillPattern.Solid, 
          textString="a"), 
        Text(
          extent={{-20,-68},{20,-90}}, 
          fillPattern=FillPattern.Solid, 
          textString="tau"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
 一维转动接口连接器与一维转动接口信号表示之间的适配器。 
 此组件用于为模型Rotational提供纯信号接口，并将此模型以输入/输出块的形式导出，
 特别是作为FMU（<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>）
 此适配器的使用示例可以在 <a href=\"modelica://Modelica.Mechanics.Rotational.Examples.GenerationOfFMUs\">Rotational.Examples.GenerationOfFMUs</a>
 中找到。 此适配器将角度、角速度和角加速度作为输入信号，并将扭矩作为输出信号。
 请注意，输入信号之间必须保持一致性 （w=der(phi)，a=der(w)）。
</p>
</html>"));
end AngleToTorqueAdaptor;