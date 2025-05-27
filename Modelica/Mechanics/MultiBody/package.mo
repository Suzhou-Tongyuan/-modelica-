within Modelica.Mechanics;
package MultiBody "用于建立三维机械系统模型的库"
  extends Modelica.Icons.Package;

  import Cv = Modelica.Units.Conversions;
  import C = Modelica.Constants;

  annotation(
    Documentation(info = "<html><p>
<strong>多体</strong>库是一个<strong>免费</strong>的Modelica包，
提供三维机械组件，用于方便地构建<strong>机械系统</strong>模型，如机器人、机构和车辆等。
使用该库生成的典型动画如下所示：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/MultiBody.png\">
</div>

<p>
想要深入了解，请特别关注：
</p>
<ul>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide\">MultiBody.UsersGuide</a>
     探讨了使用该库最重要的方面。</li>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples\">MultiBody.Examples</a>
     包含展示如何使用该库的示例。</li>
</ul>

<p>
版权所有©1998-2020，Modelica协会及其贡献者
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, 
    {100, 100}}), graphics = {
    Polygon(
    points = {{-58, 76}, {6, 76}, {-26, 50}, {-58, 76}}, 
    lineColor = {95, 95, 95}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(
    points = {{-26, 50}, {28, -50}}), 
    Ellipse(
    extent = {{-4, -14}, {60, -78}}, 
    lineColor = {135, 135, 135}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {255, 255, 255})}));
  model World 
    "世界坐标系+重力场+默认动画定义"

    import Modelica.Mechanics.MultiBody.Types.GravityTypes;
    import Modelica.Mechanics.MultiBody.Types;
    import Modelica.Constants.pi;

    Interfaces.Frame_b frame_b 
      "固定在世界坐标系原点的坐标系" 
      annotation(Placement(transformation(extent = {{84, -16}, {116, 16}})));

    parameter Boolean enableAnimation = true 
      "= true，如果要启用所有组件的动画";
    parameter Boolean animateWorld = true 
      "= true，如果要可视化世界坐标系" annotation(Dialog(enable = enableAnimation));
    parameter Boolean animateGravity = true 
      "= true，如果要可视化重力场(加速度矢量或场中心)" annotation(Dialog(enable = enableAnimation));
    parameter Boolean animateGround = false 
      "= true，如果要可视化地面平面" annotation(Dialog(enable = enableAnimation));
    parameter Types.AxisLabel label1 = "x" "图标中水平轴的标签";
    parameter Types.AxisLabel label2 = "y" "图标中垂直轴的标签";
    parameter Types.GravityTypes gravityType = GravityTypes.UniformGravity 
      "重力场类型" annotation(Evaluate = true);
    parameter SI.Acceleration g = Modelica.Constants.g_n "恒定重力加速度" 
      annotation(Dialog(enable = gravityType == Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity));
    parameter Types.Axis n = {0, -1, 0} 
      "重力方向在世界坐标系中的方向(重力 = g*n/length(n))" 
      annotation(Evaluate = true, Dialog(enable = gravityType == Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity));
    parameter Real mu(
      unit = "m3/s2", 
      min = 0) = 3.986004418e14 
      "重力场常数(默认值 = 地球的重力场常数)" 
      annotation(Dialog(enable = gravityType == Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity));
    parameter Boolean driveTrainMechanics3D = true 
      "= true，如果要考虑Parts.Mounting1D/Rotor1D/BevelGear1D的三维机械效应";

    parameter SI.Distance axisLength = nominalLength / 2 
      "世界轴箭头的长度" 
      annotation(Dialog(tab = "动画", group = "如果 animateWorld = true", enable = enableAnimation and animateWorld));
    parameter SI.Distance axisDiameter = axisLength / defaultFrameDiameterFraction 
      "世界轴箭头的直径" 
      annotation(Dialog(tab = "动画", group = "如果 animateWorld = true", enable = enableAnimation and animateWorld));
    parameter Boolean axisShowLabels = true "= true，如果要显示标签" 
      annotation(Dialog(tab = "动画", group = "如果 animateWorld = true", enable = enableAnimation and animateWorld));
    input Types.Color axisColor_x = Modelica.Mechanics.MultiBody.Types.Defaults.FrameColor 
      "x箭头的颜色" 
      annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animateWorld = true", enable = enableAnimation and animateWorld));
    input Types.Color axisColor_y = axisColor_x 
      annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animateWorld = true", enable = enableAnimation and animateWorld));
    input Types.Color axisColor_z = axisColor_x "z箭头的颜色" 
      annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animateWorld = true", enable = enableAnimation and animateWorld));

    parameter SI.Position gravityArrowTail[3] = {0, 0, 0} 
      "从世界坐标系原点到箭头尾部的位置矢量，在世界坐标系中解析" 
      annotation(Dialog(tab = "动画", group = 
      "如果animateGravity = true且gravityType = UniformGravity", 
      enable = enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
    parameter SI.Length gravityArrowLength = axisLength / 2 "重力箭头的长度" 
      annotation(Dialog(tab = "动画", group = 
      "如果animateGravity = true且gravityType = UniformGravity", 
      enable = enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
    parameter SI.Diameter gravityArrowDiameter = gravityArrowLength / 
      defaultWidthFraction "重力箭头的直径" annotation(Dialog(tab = 
      "动画", group = 
      "如果animateGravity = true且gravityType = UniformGravity", 
      enable = enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
    input Types.Color gravityArrowColor = {0, 230, 0} "重力箭头的颜色" 
      annotation(Dialog(colorSelector = true, tab = "动画", group = 
      "如果animateGravity = true且gravityType = UniformGravity", 
      enable = enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
    parameter SI.Diameter gravitySphereDiameter = 12742000 
      "代表重力中心的球体直径（默认值 = 地球的平均直径）" 
      annotation(Dialog(tab = "动画", group = 
      "如果animateGravity = true且gravityType = PointGravity", 
      enable = enableAnimation and animateGravity and gravityType == GravityTypes.PointGravity));
    input Types.Color gravitySphereColor = {0, 230, 0} "重力球体的颜色" 
      annotation(Dialog(colorSelector = true, tab = "动画", group = 
      "如果animateGravity = true且gravityType = PointGravity", 
      enable = enableAnimation and animateGravity and gravityType == GravityTypes.PointGravity));

    parameter MultiBody.Types.Axis groundAxis_u = if abs(n[1]) >= 0.99 then {0, 1, 0} else {1, 0, 0} 
      "地面平面第1轴（称为u）的向量，解析在世界坐标系中（应垂直于重力方向）" 
      annotation(Dialog(
      tab = "动画", group = "如果animateGround = true且gravityType = UniformGravity", 
      enable = enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity));
    parameter SI.Length groundLength_u = 2 "沿地面平面的长度" 
      annotation(Dialog(
      tab = "动画", group = "如果animateGround = true且gravityType = UniformGravity", 
      enable = enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity));
    parameter SI.Length groundLength_v = groundLength_u "垂直于地面平面的长度" 
      annotation(Dialog(
      tab = "动画", group = "如果animateGround = true且gravityType = UniformGravity", 
      enable = enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity));
    input Types.Color groundColor = {200, 200, 200} 
      "地面平面的颜色" 
      annotation(Dialog(
      colorSelector = true, 
      tab = "动画", group = "如果animateGround = true且gravityType = UniformGravity", 
      enable = enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity));

    parameter SI.Length nominalLength = 1 "多体系统的标称长度" 
      annotation(Dialog(tab = "默认"));
    parameter SI.Length defaultAxisLength = nominalLength / 5 
      "坐标系轴的默认长度（但不包括世界坐标系）" 
      annotation(Dialog(tab = "默认"));
    parameter SI.Length defaultJointLength = nominalLength / 10 
      "表示连接件的形状的固定长度的默认值" 
      annotation(Dialog(tab = "默认"));
    parameter SI.Length defaultJointWidth = nominalLength / 20 
      "表示连接件的形状的固定宽度的默认值" 
      annotation(Dialog(tab = "默认"));
    parameter SI.Length defaultForceLength = nominalLength / 10 
      "表示力（例如阻尼器）的形状的固定长度的默认值" 
      annotation(Dialog(tab = "默认"));
    parameter SI.Length defaultForceWidth = nominalLength / 20 
      "表示力（例如弹簧、衬套）的形状的固定宽度的默认值" 
      annotation(Dialog(tab = "默认"));
    parameter SI.Length defaultBodyDiameter = nominalLength / 9 
      "表示物体质心的球体直径的默认值" 
      annotation(Dialog(tab = "默认"));
    parameter Real defaultWidthFraction = 20 
      "形状宽度与形状长度的比例的默认值（例如Parts.FixedTranslation）" 
      annotation(Dialog(tab = "默认"));
    parameter SI.Length defaultArrowDiameter = nominalLength / 40 
      "箭头直径的默认值（例如力、力矩、传感器的）" 
      annotation(Dialog(tab = "默认"));
    parameter Real defaultFrameDiameterFraction = 40 
      "坐标系箭头直径与轴长度的比例的默认值" 
      annotation(Dialog(tab = "默认"));
    parameter Real defaultSpecularCoefficient(min = 0) = 0.7 
      "环境光反射的默认值（= 0：光完全被吸收）" 
      annotation(Dialog(tab = "默认"));
    parameter Real defaultN_to_m(unit = "N/m", min = 0) = 1000 
      "力箭头的默认缩放值（长度 = 力/defaultN_to_m）" 
      annotation(Dialog(tab = "默认"));
    parameter Real defaultNm_to_m(unit = "N.m/m", min = 0) = 1000 
      "力矩箭头的默认缩放值（长度 = 力矩/defaultNm_to_m）" 
      annotation(Dialog(tab = "默认"));

    replaceable function gravityAcceleration = 
      Modelica.Mechanics.MultiBody.Forces.Internal.standardGravityAcceleration(
      gravityType = gravityType, g = g * Modelica.Math.Vectors.normalizeWithAssert(n), mu = mu) 
      constrainedby Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration 
      "用于计算重力加速度的函数，在世界坐标系中解析" 
      annotation(choicesAllMatching = true, Dialog(enable = gravityType == 
      Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity), 
      Documentation(info = "<html>
<p>用于定义重力场的可替换函数。
默认值是函数
<a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Internal.standardGravityAcceleration\">standardGravityAcceleration</a>
，它提供了一些简单的重力场(无重力、恒定平行重力场、点重力场)。
通过重新声明此函数，可以定义任何类型的重力场，请参见示例
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.UserDefinedGravityField\">Examples.Elementary.UserDefinedGravityField</a>。
</p>
</html>"  ));

























    /* 世界对象只能使用Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape模型，但不能使用
    Modelica.Mechanics.MultiBody.Visualizers包中的其他模型，因为其他模型访问
    "外部Modelica.Mechanics.MultiBody.World world"对象的数据，即存在
    互相依赖的类。因此，无法使用更高级别的可视化
    对象。
    */
  protected
    parameter Integer ndim = if enableAnimation and animateWorld then 1 else 0;
    parameter Integer ndim2 = if enableAnimation and animateWorld and 
      axisShowLabels then 1 else 0;

    // 定义轴的参数
    parameter SI.Length headLength = min(axisLength, axisDiameter * Types.Defaults.
      FrameHeadLengthFraction);
    parameter SI.Length headWidth = axisDiameter * Types.Defaults.
      FrameHeadWidthFraction;
    parameter SI.Length lineLength = max(0, axisLength - headLength);
    parameter SI.Length lineWidth = axisDiameter;

    // 定义轴标签的参数
    parameter SI.Length scaledLabel = Modelica.Mechanics.MultiBody.Types.Defaults.FrameLabelHeightFraction * 
      axisDiameter;
    parameter SI.Length labelStart = 1.05 * axisLength;

    // x轴
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape x_arrowLine(
      shapeType = "cylinder", 
      length = lineLength, 
      width = lineWidth, 
      height = lineWidth, 
      lengthDirection = {1, 0, 0}, 
      widthDirection = {0, 1, 0}, 
      color = axisColor_x, 
      specularCoefficient = 0) if enableAnimation and animateWorld;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape x_arrowHead(
      shapeType = "cone", 
      length = headLength, 
      width = headWidth, 
      height = headWidth, 
      lengthDirection = {1, 0, 0}, 
      widthDirection = {0, 1, 0}, 
      color = axisColor_x, 
      r = {lineLength, 0, 0}, 
      specularCoefficient = 0) if enableAnimation and animateWorld;
    Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines x_label(
      lines = scaledLabel * {[0, 0; 1, 1], [0, 1; 1, 0]}, 
      diameter = axisDiameter, 
      color = axisColor_x, 
      r_lines = {labelStart, 0, 0}, 
      n_x = {1, 0, 0}, 
      n_y = {0, 1, 0}, 
      specularCoefficient = 0) if enableAnimation and animateWorld and axisShowLabels;

    // y轴
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape y_arrowLine(
      shapeType = "cylinder", 
      length = lineLength, 
      width = lineWidth, 
      height = lineWidth, 
      lengthDirection = {0, 1, 0}, 
      widthDirection = {1, 0, 0}, 
      color = axisColor_y, 
      specularCoefficient = 0) if enableAnimation and animateWorld;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape y_arrowHead(
      shapeType = "cone", 
      length = headLength, 
      width = headWidth, 
      height = headWidth, 
      lengthDirection = {0, 1, 0}, 
      widthDirection = {1, 0, 0}, 
      color = axisColor_y, 
      r = {0, lineLength, 0}, 
      specularCoefficient = 0) if enableAnimation and animateWorld;
    Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines y_label(
      lines = scaledLabel * {[0, 0; 1, 1.5], [0, 1.5; 0.5, 0.75]}, 
      diameter = axisDiameter, 
      color = axisColor_y, 
      r_lines = {0, labelStart, 0}, 
      n_x = {0, 1, 0}, 
      n_y = {-1, 0, 0}, 
      specularCoefficient = 0) if enableAnimation and animateWorld and axisShowLabels;

    // z轴
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape z_arrowLine(
      shapeType = "cylinder", 
      length = lineLength, 
      width = lineWidth, 
      height = lineWidth, 
      lengthDirection = {0, 0, 1}, 
      widthDirection = {0, 1, 0}, 
      color = axisColor_z, 
      specularCoefficient = 0) if enableAnimation and animateWorld;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape z_arrowHead(
      shapeType = "cone", 
      length = headLength, 
      width = headWidth, 
      height = headWidth, 
      lengthDirection = {0, 0, 1}, 
      widthDirection = {0, 1, 0}, 
      color = axisColor_z, 
      r = {0, 0, lineLength}, 
      specularCoefficient = 0) if enableAnimation and animateWorld;
    Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines z_label(
      lines = scaledLabel * {[0, 0; 1, 0], [0, 1; 1, 1], [0, 1; 1, 0]}, 
      diameter = axisDiameter, 
      color = axisColor_z, 
      r_lines = {0, 0, labelStart}, 
      n_x = {0, 0, 1}, 
      n_y = {0, 1, 0}, 
      specularCoefficient = 0) if enableAnimation and animateWorld and axisShowLabels;

    // 均匀重力场可视化
    parameter SI.Length gravityHeadLength = min(gravityArrowLength, 
      gravityArrowDiameter * Types.Defaults.ArrowHeadLengthFraction);
    parameter SI.Length gravityHeadWidth = gravityArrowDiameter * Types.Defaults.ArrowHeadWidthFraction;
    parameter SI.Length gravityLineLength = max(0, gravityArrowLength - gravityHeadLength);
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravityArrowLine(
      shapeType = "cylinder", 
      length = gravityLineLength, 
      width = gravityArrowDiameter, 
      height = gravityArrowDiameter, 
      lengthDirection = n, 
      widthDirection = {0, 1, 0}, 
      color = gravityArrowColor, 
      r_shape = gravityArrowTail, 
      specularCoefficient = 0) if enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravityArrowHead(
      shapeType = "cone", 
      length = gravityHeadLength, 
      width = gravityHeadWidth, 
      height = gravityHeadWidth, 
      lengthDirection = n, 
      widthDirection = {0, 1, 0}, 
      color = gravityArrowColor, 
      r_shape = gravityArrowTail + Modelica.Math.Vectors.normalize(
      n) * gravityLineLength, 
      specularCoefficient = 0) if enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity;

    // 点重力可视化
    parameter Integer ndim_pointGravity = if enableAnimation and animateGravity 
      and gravityType == GravityTypes.UniformGravity then 1 else 0;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravitySphere(
      shapeType = "sphere", 
      r_shape = {-gravitySphereDiameter / 2, 0, 0}, 
      lengthDirection = {1, 0, 0}, 
      length = gravitySphereDiameter, 
      width = gravitySphereDiameter, 
      height = gravitySphereDiameter, 
      color = gravitySphereColor, 
      specularCoefficient = 0) if enableAnimation and animateGravity and gravityType == GravityTypes.PointGravity;

    /*
    function gravityAcceleration = gravityAccelerationTypes (
    gravityType=gravityType,
    g=g*Modelica.Math.Vectors.normalize(
    n),
    mu=mu);
    */
    // 大地平面可视化
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface surface(
      final multiColoredSurface = false, 
      final wireframe = false, 
      final color = groundColor, 
      final specularCoefficient = 0, 
      final transparency = 0, 
      final R = Modelica.Mechanics.MultiBody.Frames.absoluteRotation(
      Modelica.Mechanics.MultiBody.Frames.from_nxy(n, groundAxis_u), 
      Modelica.Mechanics.MultiBody.Frames.axesRotations({1, 2, 3}, {pi / 2, pi / 2, 0}, {0, 0, 0})), 
      final r_0 = zeros(3), 
      final nu = 2, 
      final nv = 2, 
    redeclare function surfaceCharacteristic = 
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.rectangle(
      lu = groundLength_u, lv = groundLength_v)) if 
      enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity;
  equation
    Connections.root(frame_b.R);

    assert(Modelica.Math.Vectors.length(n) > 1e-10, 
      "Parameter n of World object is wrong (length(n) > 0 required)");
    frame_b.r_0 = zeros(3);
    frame_b.R = Frames.nullRotation();
    annotation(
      defaultComponentName = "world", 
      defaultComponentPrefixes = "inner", 
      missingInnerMessage = "No \"world\" component is defined. A default world
component with the default gravity field will be used
(g=9.81 in negative y-axis). If this is not desired,
drag Modelica.Mechanics.MultiBody.World into the top level of your model."  , 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-100, -118}, {-100, 61}}, 
      thickness = 0.5), 
      Polygon(
      points = {{-100, 100}, {-120, 60}, {-80, 60}, {-100, 100}, {-100, 100}}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-119, -100}, {59, -100}}, 
      thickness = 0.5), 
      Polygon(
      points = {{99, -100}, {59, -80}, {59, -120}, {99, -100}}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-150, 145}, {150, 105}}, 
      textString = "%name", 
      textColor = {0, 0, 255}), 
      Text(
      extent = {{95, -113}, {144, -162}}, 
      textString = "%label1"), 
      Text(
      extent = {{-170, 127}, {-119, 77}}, 
      textString = "%label2"), 
      Line(points = {{-56, 78}, {-56, -26}}, color = {0, 0, 255}), 
      Polygon(
      points = {{-68, -26}, {-56, -66}, {-44, -26}, {-68, -26}}, 
      fillColor = {0, 0, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 255}), 
      Line(points = {{2, 78}, {2, -26}}, color = {0, 0, 255}), 
      Polygon(
      points = {{-10, -26}, {2, -66}, {14, -26}, {-10, -26}}, 
      fillColor = {0, 0, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 255}), 
      Line(points = {{66, 80}, {66, -26}}, color = {0, 0, 255}), 
      Polygon(
      points = {{54, -26}, {66, -66}, {78, -26}, {54, -26}}, 
      fillColor = {0, 0, 255}, 
      fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 255})}), 
      Documentation(info = "<html>
<p>
<strong>World</strong>模型表示固定在地面上的世界坐标系。该模型具有几个目的：
</p>
<ul>
<li> 它作为<strong>惯性系统</strong>，用于定义多体库中所有元素的方程。</li>
<li> 它是一个<strong>动画窗口</strong>的世界坐标系，在该窗口中可以可视化多体库中的所有元素。</li>
<li> 它用于定义多体模型所在的<strong>重力场</strong>。默认情况下是均匀的重力场，重力加速度矢量g在每个位置都相同。
此外，还可以选择点重力场或无重力场。此外，可以将函数gravityAcceleration重新声明为计算重力加速度的用户定义函数，参见示例<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.UserDefinedGravityField\">Examples.Elementary.UserDefinedGravityField</a>。</li>
<li> 它用于定义动画属性的<strong>默认设置</strong>(例如，默认情况下代表体的质心的球的直径，或者代表旋转关节的圆柱的直径)。</li>
<li> 它用于定义world模型的<strong>可视化展示</strong>(三个带标签的坐标轴)，定义的重力场以及垂直于重力方向的大地平面。<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/world.png\" alt=\"MultiBody.World\">
</li>
</ul>
<p>
由于需要从具有质量的所有物体获取重力场函数，
并且几乎每个组件都需要动画属性的默认设置，
因此在顶层的每个模型中都需要实例化一个World模型。
基本声明如下：
</p>

<blockquote><pre>
<strong>inner</strong> Modelica.Mechanics.MultiBody.World world
</pre></blockquote>

<p>
注意，它必须是一个内部声明，实例名称为<strong>world</strong>，
以便可以从模型中的所有对象访问此world对象。
当从模型浏览器中将\"World\"对象拖入图形组件界面时，
此声明将自动生成(这是通过World模型中的注释定义的)。
</p>
<p>
机械系统的所有矢量和张量都在相应组件的本地坐标系中解析。
通常情况下，如果所有相对关节坐标都消失，
则所有组件的本地坐标系都是平行的，以及与世界坐标系平行
(只要没有使用Parts.FixedRotation组件)。
在这个\"参考配置\"中，
因为所有坐标系都是相互平行的，因此可以选择在世界坐标系中解析所有矢量。这通常非常方便。
为了在这种情况下提供一些动画支持，
在World实例的图标中显示了世界坐标系的两个轴，
并且可以通过参数设置这些轴的标签。
</p>
</html>"  ));
  end World;
end MultiBody;