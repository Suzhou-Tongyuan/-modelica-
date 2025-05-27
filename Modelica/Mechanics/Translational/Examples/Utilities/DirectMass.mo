within Modelica.Mechanics.Translational.Examples.Utilities;
model DirectMass "直接质量块模型的直接输入/输出块"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Mass m(min=0)=1 "质量";
  Modelica.Mechanics.Translational.Components.Mass mass(
    m=m, 
    s(start=0, fixed=true), 
    v(start=0, fixed=true)) 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Translational.Sources.Force forceSource 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.RealInput fDrive(unit="N") 
    "作用于法兰的加速力 (= -flange.f)" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition 
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealOutput s(unit="m") 
    "由于力 f，质量移动到位置 s" 
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="m/s") 
    "由于力 f，质量以速度 v 移动" 
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput a(unit="m/s2") 
    "由于力 f，质量以加速度 a 移动" 
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealInput f(unit="N") "驱动质量的力" 
                              annotation (Placement(transformation(
          extent={{140,-100},{100,-60}})));
equation
  connect(forceToPosition.f, f) annotation (Line(points={{23,-8},{60, 
          -8},{60,-80},{120,-80}}, color={0,0,127}));
  connect(forceToPosition.p, s) annotation (Line(points={{23,8},{60,8}, 
          {60,80},{110,80}}, color={0,0,127}));
  connect(forceToPosition.pder, v) annotation (Line(points={{23,5},{
          80,5},{80,30},{110,30}}, color={0,0,127}));
  connect(forceToPosition.pder2, a) annotation (Line(points={{23,2},{
          80,2},{80,-30},{110,-30}}, color={0,0,127}));
  connect(fDrive, forceSource.f) 
    annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
  connect(forceSource.flange, mass.flange_a) 
    annotation (Line(points={{-30,0},{-20,0}}, color={0,127,0}));
  connect(mass.flange_b, forceToPosition.flange) 
    annotation (Line(points={{0,0},{18,0}}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
        graphics={Text(
                extent={{-84,-58},{24,-90}}, 
                textColor={135,135,135}, 
                textString="to FMU"),Text(
                extent={{8,96},{92,66}}, 
                horizontalAlignment=TextAlignment.Right, 
          textString="s"),                            Text(
                extent={{10,46},{94,16}}, 
                horizontalAlignment=TextAlignment.Right, 
          textString="v"),   Text(
                extent={{10,-10},{94,-40}}, 
                horizontalAlignment=TextAlignment.Right, 
                textString="a"),Text(
                extent={{-150,-110},{150,-140}}, 
          textString="m=%m"),      Bitmap(extent={{-96,-42},{64,54}}, 
            fileName="modelica://Modelica/Resources/Images/Mechanics/Translational/DirectMass.png"), 
          Text( extent={{10,-60},{94,-90}}, 
                horizontalAlignment=TextAlignment.Right, 
          textString="f")}), Documentation(info="<html>
<p>
一个带有纯信号接口的平动组件，可用于 FMU (<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>) 交换。
输入力 <code>fDrive</code> 施加在滑动质量块的一侧，而输入力 <code>f</code> 施加在另一侧。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.Utilities.InverseMass\">InverseMass</a>。
</p>
</html>"));
end DirectMass;