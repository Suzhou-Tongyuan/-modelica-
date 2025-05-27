within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialForce 
  "用于力元件的基础模型(在子类中提供frame_b.f和frame_b.t)"
  extends PartialTwoFrames;
  SI.Position r_rel_b[3] 
    "从frame_a原点到frame_b原点的位置矢量，在frame_b中解析";
equation
  // 计算frame_a和frame_b之间相对位置矢量
  r_rel_b = Frames.resolve2(frame_b.R, frame_b.r_0 - frame_a.r_0);

  // frame_a和frame_b之间力和力矩平衡
  zeros(3) = frame_a.f + Frames.resolveRelative(frame_b.f, frame_b.R, frame_a.R);
  zeros(3) = frame_a.t + Frames.resolveRelative(frame_b.t + cross(r_rel_b, frame_b.f), frame_b.R, frame_a.R);
  annotation(Documentation(info = "<html>
<p>
所有<strong>三维力</strong>和<strong>力矩元素</strong>都应该基于这个超类。
这个模型定义了frame_a和frame_b，计算了两个坐标系之间的相对平移和旋转，并根据frame_b上的局部力和局部力矩平衡公式计算出frame_a上的局部力和局部力矩。
因此，在子类中，只需要定义frame_b处的局部力和局部力矩与以下相对量的关系：
</p>
<blockquote><pre>
r_rel_b[3]: Position vector from origin of frame_a to origin
            of frame_b, resolved in frame_b
R_rel     : Relative orientation object to rotate from frame_a to frame_b
</pre></blockquote>
<p>
假设要在连接到frame_b的物体上施加力f = {100,0,0}，则定义应为：
</p>
<blockquote><pre>
<strong>model</strong> Constant_x_Force
   extends Modelica.Mechanics.MultiBody.Interfaces.PartialForce;
<strong>equation</strong>
   frame_b.f = {-100, 0, 0};
   frame_b.t = zeros(3);
<strong>end</strong> Constant_x_Force;
</pre></blockquote>
<p>
请注意，frame_b.f和frame_b.t是流变量，因此frame_b.f和frame_b.t的负值作用于与该力元件相连的部件上。
</p>
</html>"));
end PartialForce;