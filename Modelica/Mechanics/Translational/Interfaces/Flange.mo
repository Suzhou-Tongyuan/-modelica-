within Modelica.Mechanics.Translational.Interfaces;
connector Flange "一维平动接口"

  SI.Position s "一维平动接口的绝对位置";
  flow SI.Force f "一维平动接口上施加的局部力";
  annotation (
    Documentation(info="<html>
<p>
这是用于一维平动机械系统的连接器。
它没有图标定义，只能通过继承flange连接器来定义不同的图标。
</p>
<p>
该连接器中定义了以下变量：
</p>

<blockquote><pre>
s: Absolute position of the flange in [m]. A positive translation
   means that the flange is translated along the flange axis.
f: Cut-force in direction of the flange axis in [N].
</pre></blockquote>
</html>"));
end Flange;