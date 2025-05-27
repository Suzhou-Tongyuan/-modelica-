within Modelica.Mechanics.Translational.Interfaces;
connector Flange_b 
  "一维平动接口（右侧，一维平动接口轴向指向切割平面外）"
  extends Flange;

  annotation (
    defaultComponentName="flange_b", 
    Documentation(info="<html><p>
这是用于一维平动机械系统的连接器，表示机械一维平动接口。
在一维平动接口的局部平面上定义了一个单位矢量n，称为一维平动接口轴向，指向局部平面内部，即从左到右。
局部平面中的所有矢量都相对于此单位矢量进行分解。
例如，力f表示一个矢量，其方向与n方向相同，其大小等于f。
当此一维平动接口连接到其他一维平动一维平动接口时，这意味着所连接一维平动接口的轴向矢量是相同的。</p>
<p>
通过此连接器传输以下变量：
</p>
<pre><code >s: Absolute position of the flange in [m]. A positive translation
means that the flange is translated along the flange axis.
f: Cut-force in direction of the flange axis in [N].
</code></pre><p>
<br>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
          extent={{-100,-100},{100,100}}, 
          lineColor={0,127,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={Rectangle(
          extent={{-40,-40},{40,40}}, 
          lineColor={0,127,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), Text(
          extent={{-40,110},{160,50}}, 
          textColor={0,127,0}, 
          textString="%name")}));
end Flange_b;