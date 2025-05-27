within Modelica.Mechanics.MultiBody.Joints.Internal;
model InitAngle 
 "内部模型，用于为Joints.FreeMotionScalarInit初始化角度"
  extends Modelica.Blocks.Icons.Block;

  import Modelica.Mechanics.MultiBody.Frames;

  parameter Modelica.Mechanics.MultiBody.Types.RotationSequence sequence_start={1,2,3} 
   "角度旋转的顺序";

  Interfaces.Frame_a frame_a 
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b 
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  Frames.Orientation R_rel 
   "从frame_a到frame_b旋转的相对方向对象";
  Frames.Orientation R_rel_inv 
   "从frame_b到frame_a旋转的相对方向对象";

  Blocks.Interfaces.RealOutput angle[3](each final quantity="Angle", each final unit="rad") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=-90, 
        origin={0,-110})));
equation
  Connections.branch(frame_a.R, frame_b.R);
  R_rel = Frames.axesRotations(sequence_start, 
                               {angle[1], angle[2], angle[3]}, 
                               {der(angle[1]), der(angle[2]), der(angle[3])});
  if Connections.rooted(frame_a.R) then
     R_rel_inv = Frames.nullRotation();
     frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
  else
     R_rel_inv = Frames.inverseRotation(R_rel);
     frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
  end if;

  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);

  annotation (Icon(graphics={Text(
         extent={{-84,-58},{86,-86}}, 
         textString="angle")}), Documentation(info="<html>
<p>
计算给定旋转序列<strong>sequence_start</strong>下从frame_a到frame_b的相对方向的三个旋转角度<strong>angle</strong>。
</p>
</html>"));
end InitAngle;