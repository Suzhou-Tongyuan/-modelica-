within Modelica.Mechanics.MultiBody.Parts;
model Mounting1D 
  "将一维支撑扭矩传递到三维系统(假设world.driveTrainMechanics3D = true)"
  parameter SI.Angle phi0=0 "固定壳体的偏移角度";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0} 
    "旋转轴=支撑扭矩轴(在frame_a中解决)" 
     annotation (Evaluate=true);
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b 
    "(右侧)固定在壳体中的一维接口" annotation (Placement(transformation(
          extent={{110,10},{90,-10}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D 
    "壳体固定的参考系(如果world.driveTrainMechanics3D=false，则移除连接器)" 
    annotation (Placement(transformation(
        origin={0,-100}, 
        extent={{-20,-20},{20,20}}, 
        rotation=90)));
protected
  outer Modelica.Mechanics.MultiBody.World world;

  encapsulated model Housing
    import Modelica;
    input Modelica.Units.SI.Torque t[3];
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation (
        Placement(transformation(extent={{-116,-16},{-84,16}})));
  equation
    frame_a.f = zeros(3);
    frame_a.t = t;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
              -100},{100,100}}), graphics={Rectangle(
                extent={{-100,100},{100,-100}}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Text(
                extent={{-150,110},{150,150}}, 
                textColor={0,0,255}, 
                textString="%name")}));
  end Housing;
  Housing housing(t=-n*flange_b.tau) if world.driveTrainMechanics3D 
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));

equation
  flange_b.phi = phi0;
  connect(housing.frame_a, frame_a) annotation (Line(
      points={{20,-50},{0,-50},{0,-100}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Rectangle(
          extent={{-80,-60},{80,-100}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,60},{150,20}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(points={{80,-60},{40,-100}}), 
        Line(points={{40,-60},{0,-100}}), 
        Line(points={{0,-60},{-40,-100}}), 
        Line(points={{-40,-60},{-80,-100}}), 
        Line(points={{0,-60},{0,0}}), 
        Line(points={{0,0},{90,0}})}), Documentation(info="<html>
<p>
此组件用于从一维旋转机械系统(例如，Modelica.Mechanics.Rotational中的组件)获取支撑扭矩，并将其传播到载体体。
</p>
<p>
<code>flange_b</code>处的一维支撑扭矩在考虑到旋转轴参数<code>n</code>的情况下转换为三维空间，该参数必须在<code>frame_a</code>的局部坐标系中给出。
</p>
<p>
与<strong>Mounting1D</strong>元素连接的一维旋转机械系统的所有组件都需要沿参数矢量<code>n</code>具有相同的旋转轴。
这意味着，例如，轴承齿轮的<code>flange_a</code>和<code>flange_b</code>的旋转轴不同，不能通过连接到<strong>Mounting1D</strong>组件正确描述。
在这种情况下，应使用多个<strong>Mounting1D</strong>组件的组合或组件<strong>BevelGear1D</strong>。
</p>
<p>
<strong>参考资料</strong><br><span style=\"font-variant:small-caps\">Schweiger</span>,Christian;<span style=\"font-variant:small-caps\">Otter</span>,Martin:<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling3DMechanicalEffectsof1-dim.Powertrains</a>.In:<em>Proceedingsofthe3rdInternationalModelicaConference</em>.Link&ouml;ping:TheModelicaAssociationandLink&ouml;pingUniversity,November3-4,2003,pp.149-158</p>
</html>"));

end Mounting1D;