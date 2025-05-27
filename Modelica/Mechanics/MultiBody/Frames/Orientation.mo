within Modelica.Mechanics.MultiBody.Frames;
record Orientation 
  "定义从坐标系1旋转到坐标系2的方向对象"

  extends Modelica.Icons.Record;
  Real T[3, 3] "从世界坐标系到本地坐标系的转换矩阵";
  SI.AngularVelocity w[3] 
    "本地坐标系的绝对角速度，在本地坐标系下解析";

  encapsulated function equalityConstraint 
    "返回表达两个坐标系具有相同方向的约束残差"

    import Modelica;
    import Modelica.Mechanics.MultiBody.Frames;
    extends Modelica.Icons.Function;
    input Frames.Orientation R1 
      "将坐标系0旋转到坐标系1的方向对象";
    input Frames.Orientation R2 
      "将坐标系0旋转到坐标系2的方向对象";
    output Real residue[3] 
      "将坐标系1旋转到坐标系2的绕x、y和z轴的旋转角度(对于小的旋转应为零)";
  algorithm
    residue := {
       Modelica.Math.atan2(cross(R1.T[1, :], R1.T[2, :])*R2.T[2, :],R1.T[1,:]*R2.T[1,:]), 
       Modelica.Math.atan2(-cross(R1.T[1, :],R1.T[2, :])*R2.T[1, :],R1.T[2,:]*R2.T[2,:]), 
       Modelica.Math.atan2(R1.T[2, :]*R2.T[1, :],R1.T[3,:]*R2.T[3,:])};
    annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
residue = Orientation.<strong>equalityConstraint</strong>(R1, R2);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用<code>Orientation.<strong>equalityConstrain</strong>(R1,R2)</code>返回一个具有3个元素的Real残差矢量。
如果方向对象R1和R2相同(描述相同方向)，则此矢量的元素等于零。
残差矢量是通过计算R1和R2之间的相对方向对象，并使用该矩阵的外对角线元素来制定残差的方式来确定，
只有相同的方向对象导致零残差矢量。
</p>
</html>"  ));
  end equalityConstraint;

  annotation (Documentation(info="<html>
<p>
这个对象描述了从<strong>frame 1</strong>(坐标系1)到<strong>frame 2</strong>(坐标系2)的<strong>旋转</strong>。
这种类型的实例不应该直接访问，而应该使用Modelica.Mechanics.MultiBody.Frames包中提供的访问函数。
因此，不一定需要知道这个对象的内部表示，如下面的段落所述。
</p>
<p>
\"Orientation\"被定义为一个记录，由两个元素组成：\"Real T[3,3]\"，将frame 1旋转到frame 2的变换矩阵，以及\"Real w[3]\"，frame 2相对于frame 1的角速度，在frame 2中解析。元素\"T\"有以下解释：
</p>

<blockquote><pre>
Orientation R;
<strong>R.T</strong> = [<strong>e</strong><sub>x</sub>, <strong>e</strong><sub>y</sub>, <strong>e</strong><sub>z</sub>];
    e.g., <strong>R.T</strong> = [1,0,0; 0,1,0; 0,0,1]
</pre></blockquote>

<p>
其中<strong>e</strong><sub>x</sub>，<strong>e</strong><sub>y</sub>，<strong>e</strong><sub>z</sub>是表示frame 1的x轴、y轴和z轴的单位向量，在frame 2中解析。因此，如果<strong>v</strong><sub>1</sub>是frame 1中解析的向量<strong>v</strong>，而<strong>v</strong><sub>2</sub>是在frame 2中解析的向量<strong>v</strong>，则以下关系成立：
</p>

<blockquote><pre>
<strong>v</strong><sub>2</sub> = <strong>R.T</strong> * <strong>v</strong><sub>1</sub>
</pre></blockquote>

<p>
<strong>逆</strong>方向<strong>R_inv.T</strong> = <strong>R.T</strong><sup>T</sup>描述了从frame 2到frame 1的旋转。
</p>
<p>
由于方向对象由9个变量描述，因此这些变量之间存在6个约束。这些约束在函数<strong>Frames.orientationConstraint</strong>中定义。
</p>
<p>
R.w是frame 2相对于frame 1的角速度，在frame 2中解析。形式上，R.w定义为：<br>
<strong>skew</strong>(R.w) = R.T*<strong>der</strong>(transpose(R.T))
</p>

<blockquote><pre>
                           |   0   -w[3]  w[2] |
<strong>skew</strong>(w) = |  w[3]   0   -w[1] |
                           | -w[2]  w[1]     0 |
</pre></blockquote>
</html>"));
end Orientation;