within Modelica.Electrical.Polyphase.Interfaces;
connector Plug "具有m个引脚的电气多相插头"
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  Modelica.Electrical.Analog.Interfaces.Pin pin[m] "插头的引脚";

  annotation (Documentation(info="<html>
<p>
连接器PositivePlug和NegativePlug几乎相同。
唯一的区别在于，图标不同，以便更容易识别组件的插头。
通常情况下，连接器 PositivePlug用于电气组件的正极，连接器NegativePlug用于负极。<br>
连接器Plug是一个复合连接器，包含m个引脚(Modelica.Electrical.Analog.Interfaces.Pin)。
</p>
</html>"), 
       Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Text(
          extent={{-100,-99},{100,-179}}, 
          textColor={0,0,255}, 
          textString="%name")}));
end Plug;