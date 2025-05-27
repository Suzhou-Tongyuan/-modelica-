within Modelica.Mechanics.MultiBody.Frames.Quaternions;
type Orientation 
  "定义使用四元数从坐标系21旋转到坐标系2的方向类型 {p1,p2,p3,p0}"

  extends Internal.QuaternionBase;

  encapsulated function equalityConstraint 
    "返回约束残差，以表达两个坐标系具有相同的四元数方向"

    import Modelica;
    import Modelica.Mechanics.MultiBody.Frames.Quaternions;
    extends Modelica.Icons.Function;
    input Quaternions.Orientation Q1 
      "将坐标系0旋转到坐标系1的四元数方向对象";
    input Quaternions.Orientation Q2 
      "将坐标系0旋转到坐标系2的四元数方向对象";
    output Real residue[3] 
      "如果Q1和Q2相同(相对变换的前三个元素为{0,0,0}表示空旋转，由atan2保护，使镜像解无效";
  algorithm
    residue := { Modelica.Math.atan2({ Q1[4],  Q1[3], -Q1[2], -Q1[1]}*Q2, Q1*Q2), 
                 Modelica.Math.atan2({-Q1[3],  Q1[4],  Q1[1], -Q1[2]}*Q2, Q1*Q2), 
                 Modelica.Math.atan2({ Q1[2], -Q1[1],  Q1[4], -Q1[3]}*Q2, Q1*Q2)};
    annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
residue = Orientation.<strong>equalityConstraint</strong>(Q1, Q2);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回具有3个元素的Real残差矢量。
如果四元数对象Q1和Q2相同，则此矢量的元素为零，
即它们描述相同的方向。
残差矢量由Q1和Q2之间的相对四元数对象确定，
以便以仅相同的方向对象导致零残差矢量。
</p>
</html>"));
  end equalityConstraint;

  annotation (Documentation(info="<html>
<p>
此类型描述了使用四元数(也称为<strong>Euler参数</strong>)将坐标系1旋转到坐标系2的<strong>旋转</strong>，根据以下定义：
</p>
<blockquote><pre>
Quaternions.Orientation Q;
Real  n[3];
Real  phi(unit=\"rad\");
Q = [ n*sin(phi/2)
        cos(phi/2) ]
</pre></blockquote>
<p>
其中“n”是将坐标系1旋转到坐标系2的<strong>旋转轴</strong>，而“phi”是此旋转的<strong>旋转角度</strong>。
矢量“n”可以在坐标系1或坐标系2中解析
(结果相同，因为“n”相对于坐标系1的坐标与其相对于坐标系2的坐标相同)。
</p>
<p>
为了不与Modelica“参数”混淆，更倾向于使用术语“四元数”而不是历史上更合理的“Euler参数”。
</p>
</html>"));
end Orientation;