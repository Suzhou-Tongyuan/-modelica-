within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
type Orientation 
  "使用一个变换矩阵描述从一个坐标系1到另一个坐标系2的旋转的方向类型"

  extends Internal.TransformationMatrix;

  encapsulated function equalityConstraint 
    "返回表达两个坐标系具有相同方向的约束残差"

    import Modelica;
    import Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
    extends Modelica.Icons.Function;
    input TransformationMatrices.Orientation T1 
      "将坐标系0旋转到坐标系1的方向对象";
    input TransformationMatrices.Orientation T2 
      "将坐标系0旋转到坐标系2的方向对象";
    output Real residue[3] 
      "坐标系1绕x轴、y轴和z轴旋转以将坐标系1旋转到坐标系2的旋转角度(应为零)";
  algorithm
    residue := {
      cross(T1[1, :], T1[2, :]) * T2[2, :], 
      -cross(T1[1, :], T1[2, :]) * T2[1, :], 
      T1[2, :]*T2[1, :]};
    annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
residue = Orientation.<strong>equalityConstraint</strong>(T1, T2);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回具有3个元素的实数残差矢量。
如果变换矩阵T1和T2相同，即它们描述相同的方向，则此矢量具有零元素。
残差矢量是通过计算 T1 和 T2 之间的相对变换矩阵并使用该矩阵的外对角线元素来确定的，
以便只有相同的方向对象导致零残差矢量。
</p>
</html>"  ));
  end equalityConstraint;
  annotation (Documentation(info="<html>
<p>
此类型描述了从<strong>坐标系1</strong>旋转到<strong>坐标系2</strong>的<strong>旋转</strong>。
类型<strong>Orientation</strong>的实例<strong>R</strong>的解释如下：
</p>
<blockquote><pre>
<strong>T</strong> = [<strong>e</strong><sub>x</sub>, <strong>e</strong><sub>y</sub>, <strong>e</strong><sub>z</sub>];
    e.g., <strong>T</strong> = [1,0,0; 0,1,0; 0,0,1]
</pre></blockquote>
<p>
其中<strong>e</strong><sub>x</sub>，<strong>e</strong><sub>y</sub>，<strong>e</strong><sub>z</sub>
是坐标系1中x轴、y轴和z轴的单位矢量，在坐标系2中分解。
因此，如果<strong>v</strong><sub>1</sub>是在坐标系1中解析的矢量<strong>v</strong>，<strong>v</strong><sub>2</sub>是在坐标系2中解析的矢量<strong>v</strong>，则以下关系成立：
</p>
<blockquote><pre>
<strong>v</strong><sub>2</sub> = <strong>T</strong> * <strong>v</strong><sub>1</sub>
</pre></blockquote>
<p>
<strong>逆</strong>方向
<strong>T_inv</strong> = <strong>T</strong><sup>T</sup>描述了从坐标系2到坐标系1的旋转。
</p>
<p>
由于方向由9个变量描述，因此这些变量之间有6个约束。这些约束在函数 <strong>TransformationMatrices.orientationConstraint</strong>中定义。
</p>
<p>
请注意，在 MultiBody 库中，旋转对象从不直接访问，而是通过提供的访问函数在TransformationMatrices包中。
因此，其他实现通过相应地调整此包可以来定义Rotation。
</p>
</html>"));
end Orientation;