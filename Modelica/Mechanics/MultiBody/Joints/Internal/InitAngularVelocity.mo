within Modelica.Mechanics.MultiBody.Joints.Internal;
model InitAngularVelocity 
 "内部模型，用于为Joints.FreeMotionScalarInit初始化w_rel_b"
  extends Modelica.Blocks.Icons.Block;

  import Modelica.Mechanics.MultiBody.Frames;

  input Frames.Orientation R_a annotation(Dialog);
  input Frames.Orientation R_b annotation(Dialog);

  Modelica.Blocks.Interfaces.RealOutput w_rel_b[3](each final quantity="AngularVelocity", each final unit="rad/s") annotation (Placement(transformation(extent={{100,-10}, 
            {120,10}})));
equation
 Frames.angularVelocity2(R_b) = Frames.resolve2(R_b,Frames.angularVelocity1(R_a)) + w_rel_b;

  annotation (Icon(graphics={Text(
         extent={{-86,16},{84,-12}}, 
         textString="w_rel_b")}), Documentation(info="<html>
<p>
计算相对于方向对象R_a的方向对象R_b的相对角速度w_rel_b，在方向对象R_b中解析，即</p>
<blockquote><pre>
w_b_b=w_a_b+w_rel_b,
</pre></blockquote>
<p>
其中</p>
<blockquote><pre>
w_b_b ...... absolute angular velocity of frame_b resolved in frame_b,
w_a_b ...... absolute angular velocity of frame_a resolved in frame_b,
w_rel_b .... relative angular velocity resolved in frame_b.
</pre></blockquote>
</html>"));
end InitAngularVelocity;