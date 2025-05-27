within Modelica.Mechanics.MultiBody.Examples.Elementary;
model PointGravityWithPointMasses2 
  "点重力场中刚性连接的质点"
  extends Modelica.Icons.Example;
  model PointMass = Modelica.Mechanics.MultiBody.Parts.PointMass (
    m=1, sphereColor={255,0,0}) "这个示例中的点质量被用于所有地方" 
    annotation (
      Documentation(info="<html><p>
在这个示例中，点质量被用于所有地方(质量为1千克，颜色为蓝色)。
</p>
</html>"  ));

  PointMass pointMass1(
    r_0(start={3,0,0}, each fixed=true), 
    v_0(start={0,0,-1}, each fixed=true)) 
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  PointMass pointMass2 annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  PointMass pointMass3(
    r_0(start={2,1,0}, fixed={true,false,false}), 
    v_0(start={0,0,-1}, fixed={true,false,false})) 
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  PointMass pointMass4(
    r_0(start={2,-1,0}, fixed={false,false,true}), 
    v_0(start={0,0,-1}, fixed={false,false,true})) 
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  PointMass pointMass5(
    r_0(start={2,0,1}, fixed={false,false,true}), 
    v_0(start={0,0,-1}, fixed={false,false,true})) 
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  PointMass pointMass6 annotation (Placement(transformation(extent={{0,-100},{20,-80}})));

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={1,0,0}) 
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(r={-1,0,0}) 
    annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation2(r={0,1,0}) 
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation3(r={0,-1,0}) 
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation4(r={0,0,1}) 
    annotation (Placement(transformation(
        origin={10,60}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation5(r={0,0,-1}) 
    annotation (Placement(transformation(
        origin={10,-60}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  inner World world(
    gravitySphereDiameter=0.1, 
    gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity, 
    mu=5) 
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Joints.FreeMotion freeMotion annotation (Placement(transformation(extent={{
            -40,60},{-20,80}})));
  SystemWithStandardBodies referenceSystem annotation (Placement(transformation(
          extent={{60,-60},{80,-40}})));

  model SystemWithStandardBodies 
    "为了比较，使用Bodies代替PointMasses的等效模型"

    model PointMass = Modelica.Mechanics.MultiBody.Parts.Body (
      final m=1, 
      final r_CM={0,0,0}, 
      final I_11=0, 
      final I_22=0, 
      final I_33=0, 
      final I_21=0, 
      final I_31=0, 
      final I_32=0) 
      "在比较模型中，所有位置都使用惯性张量为零的刚体" 
      annotation (Documentation(info="<html>
<p>
在比较模型中，所有位置都使用惯性张量为零的刚体(质量=1 kg，颜色为红色)。
</p>
</html>"));

    PointMass pointMass1(
      r_0(start={3,0,0}, each fixed=true), 
      v_0(start={0,0,-1}, each fixed=true), 
      angles_fixed=true, 
      w_0_fixed=true) 
      annotation (Placement(transformation(extent={{40,-20},{
                60,0}})));
    PointMass pointMass2 
      annotation(Placement(transformation(extent={{-60,-20},{
                -80,0}})));
    PointMass pointMass3 
      annotation(Placement(transformation(extent={{40,10},{60, 
                30}})));
    PointMass pointMass4 
      annotation(Placement(transformation(extent={{-50,-50},{
                -70,-30}})));
    PointMass pointMass5 
      annotation(Placement(transformation(extent={{0,60},{20, 
                80}})));
    PointMass pointMass6 
      annotation(Placement(transformation(extent={{2,-102},{
                22,-82}})));

    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(r={1,0,0}) 
      annotation(Placement(transformation(extent={{0,-20},{20,0}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(r={-1,0,0}) 
      annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation2(r={0,1,0}) 
      annotation (Placement(transformation(extent={{0,10},{20,30}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation3(r={0,-1,0}) 
      annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation4(r={0,0,1}) 
      annotation (Placement(transformation(
            origin={-10,50}, 
            extent={{-10,-10},{10,10}}, 
            rotation=90)));
    Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation5(r={0,0,-1}) 
      annotation (Placement(transformation(
            origin={-10,-70}, 
            extent={{10,-10},{-10,10}}, 
            rotation=90)));

  equation
    connect(fixedTranslation1.frame_a, fixedTranslation.frame_a) 
      annotation(Line(
          points={{-20,-10},{0,-10}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation1.frame_a, fixedTranslation2.frame_a) 
      annotation(Line(
          points={{-20,-10},{-10,-10},{-10,20},{0,20}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation3.frame_a, fixedTranslation.frame_a) 
      annotation(Line(
          points={{-20,-40},{-10,-40},{-10,-10},{0,-10}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation1.frame_a, fixedTranslation4.frame_a) 
      annotation(Line(
          points={{-20,-10},{-10,-10},{-10,40}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation5.frame_a, fixedTranslation.frame_a) 
      annotation(Line(
          points={{-10,-60},{-10,-10},{0,-10}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation2.frame_b, pointMass3.frame_a) 
      annotation(Line(
          points={{20,20},{40,20}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation3.frame_b, pointMass4.frame_a) 
      annotation(Line(
          points={{-40,-40},{-50,-40}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(pointMass5.frame_a, fixedTranslation4.frame_b) 
      annotation(Line(
          points={{0,70},{-10,70},{-10,60}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation5.frame_b, pointMass6.frame_a) 
      annotation(Line(
          points={{-10,-80},{-10,-92},{2,-92}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation.frame_b, pointMass1.frame_a) 
      annotation(Line(
          points={{20,-10},{40,-10}}, 
          color={95,95,95}, 
          thickness=0.5));
    connect(fixedTranslation1.frame_b, pointMass2.frame_a) 
      annotation(Line(
          points={{-40,-10},{-60,-10}}, 
          color={95,95,95}, 
          thickness=0.5));
    annotation (Documentation(info="<html>
<p>
为了比较\"PointMass\"示例中6个质点刚性连接在一起的结果，在这个比较模型中，设置了一个等效系统，
唯一的区别是质点被替换为惯性为零的刚体。
</p>
</html>"  ));
  end SystemWithStandardBodies;

equation
  connect(fixedTranslation1.frame_a, fixedTranslation.frame_a) 
    annotation(Line(
      points={{0,0},{20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation1.frame_a, fixedTranslation2.frame_a) 
    annotation(Line(
      points={{0,0},{10,0},{10,30},{20,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation3.frame_a, fixedTranslation.frame_a) 
    annotation(Line(
      points={{0,-30},{10,-30},{10,0},{20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation1.frame_a, fixedTranslation4.frame_a) 
    annotation(Line(
      points={{0,0},{10,0},{10,50}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation5.frame_a, fixedTranslation.frame_a) 
    annotation(Line(
      points={{10,-50},{10,0},{20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation2.frame_b, pointMass3.frame_a) 
    annotation (Line(
      points={{40,30},{70,30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation3.frame_b, pointMass4.frame_a) 
    annotation (Line(
      points={{-20,-30},{-40,-30}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(pointMass5.frame_a, fixedTranslation4.frame_b) 
    annotation (Line(
      points={{10,90},{10,70}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation5.frame_b, pointMass6.frame_a) 
    annotation (Line(
      points={{10,-70},{10,-90}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation.frame_b, pointMass1.frame_a) 
    annotation (Line(
      points={{40,0},{70,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation1.frame_b, pointMass2.frame_a) 
    annotation (Line(
      points={{-20,0},{-50,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, freeMotion.frame_a) annotation (Line(
      points={{-60,70},{-40,70}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(freeMotion.frame_b, fixedTranslation1.frame_a) annotation (Line(
      points={{-20,70},{-10,70},{-10,20},{10,20},{10,0},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));

  annotation (
    experiment(
      StopTime=3.0, 
      Tolerance=1e-006), 
    Documentation(info="<html><p>
这个模型演示了在点重力场中使用模型Parts.PointMass的情况。
6个点质量被刚性地连接在一起。
对这样的模型进行平移会导致错误，因为点质量没有定义方向对象。
该示例演示了在这种情况下(当方向对象不是由连接到点质量的对象定义时)，必须使用\"MultiBody.Joints.FreeMotion\"关节来定义该结构的自由度。
</p>
<p>
为了证明这种方法的正确性，在模型\"referenceSystem\"中，再次提供了相同的系统，但这次是用一个惯性张量被设置为零的通用体(Parts.Body)建模的。
在这种情况下，不需要FreeMotion对象，因为每个物体提供了其绝对平移和旋转位置以及速度作为潜在状态变量。
</p>
<p>
这两个系统应该以完全相同的方式移动。使用PointMasses对象的系统以\"红色\"可视化点质量，而\"referenceSystem\"则以\"蓝色\"显示其物体。
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravityWithPointMasses2.png\">
</p>
</html>"));
end PointGravityWithPointMasses2;