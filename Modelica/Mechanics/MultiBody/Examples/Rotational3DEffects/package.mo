within Modelica.Mechanics.MultiBody.Examples;
package Rotational3DEffects "单缸发动机基础模型演示一维旋转元件的使用，包含所有三维效应"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<p>
这个包通过考虑所有三维效应，演示了Mechanics.Rotational库中元件的使用。
使用这种建模方式的原因是为了大幅加快模拟速度。如果构件具有旋转对称性，这是可能实现的。
一个典型的应用领域是传动系统，用于驱动多体系统中各部件的连接关节。
</p>
</html>"));
end Rotational3DEffects;