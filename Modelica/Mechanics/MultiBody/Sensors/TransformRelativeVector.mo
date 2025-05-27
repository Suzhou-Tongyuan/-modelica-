within Modelica.Mechanics.MultiBody.Sensors;
model TransformRelativeVector "将相对矢量转换到另一个参考系中"
  extends Internal.PartialRelativeSensor;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve if 
   (frame_r_in  == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) or 
   (frame_r_out == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    "在其中可选地解析r_in或r_out的坐标系" 
    annotation (Placement(transformation(extent={{84,64},{116,96}})));

  Blocks.Interfaces.RealInput r_in[3] 
    "在frame_r_in定义的参考系中解析的输入矢量" 
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, 
        rotation=-90, 
        origin={0,120})));
  Blocks.Interfaces.RealOutput r_out[3] 
    "在frame_r_out定义的参考系中解析的输入矢量r_in" 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=-90, 
        origin={0,-110})));

  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_in= 
  Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a 
    "解析矢量r_in的参考系(world,frame_a,frame_b,或frame_resolve)";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB frame_r_out= 
                  frame_r_in 
    "应将矢量r_in解析并提供为r_out的参考系(world,frame_a,frame_b,或frame_resolve)";

protected
  Modelica.Mechanics.MultiBody.Sensors.Internal.BasicTransformRelativeVector basicTransformVector(frame_r_in=frame_r_in, frame_r_out=frame_r_out) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (frame_r_in == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve or 
         frame_r_out == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve) 
    annotation (Placement(transformation(extent={{48,10},{68,30}})));

equation
  connect(basicTransformVector.frame_a, frame_a) annotation (Line(
      points={{-10,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(basicTransformVector.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(basicTransformVector.frame_resolve, frame_resolve) annotation (Line(
      points={{10,8},{20,8},{20,8},{32,8},{32,80},{100,80}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicTransformVector.frame_resolve) 
    annotation (Line(
      points={{48,20},{32,20},{32,8},{10,8}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(basicTransformVector.r_out, r_out) annotation (Line(
      points={{0,-11},{0,-110}}, color={0,0,127}));
  connect(basicTransformVector.r_in, r_in) annotation (Line(
      points={{0,12},{0,120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{0,-70},{0,-100}}, 
          color={0,0,127}), 
        Line(
          points={{0,100},{0,70}}, 
          color={0,0,127}), 
        Text(
          extent={{-104,124},{-18,96}}, 
          textString="r_in"), 
        Text(
          extent={{-124,-76},{2,-104}}, 
          textString="r_out"), 
        Text(
          extent={{70,126},{200,100}}, 
          textColor={95,95,95}, 
          textString="resolve")}), 
    Documentation(info="<html>
<p>
假设输入矢量\"Real r_in[3]\"是frame_a和frame_b之间的相对运动量，它被定义为在由参数\"frame_r_in\"定义的参考系中解析。
该模型将矢量r_in解析到由参数\"frame_r_out\"定义的坐标系中，并将转换后的输出矢量返回为\"Real r_out[3]\"；</p>

</html>"));
end TransformRelativeVector;