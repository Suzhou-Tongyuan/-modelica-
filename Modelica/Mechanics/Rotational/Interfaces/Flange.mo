within Modelica.Mechanics.Rotational.Interfaces;
connector Flange "一维转动接口"

  SI.Angle phi "一维转动接口的绝对旋转角度";
  flow SI.Torque tau "一维转动接口上的局部扭矩";
  annotation (
    Documentation(info="<html>
<p>
这是一个用于一维旋转机械系统的连接器。它没有图标定义，仅通过从一维转动接口连接器继承来定义不同的图标。
</p>
<p>
此连接器中定义了以下变量：
</p>

<blockquote><pre>
phi: Absolute rotation angle of the flange in [rad].
tau: Cut-torque in the flange in [Nm].
</pre></blockquote>
</html>"));
end Flange;