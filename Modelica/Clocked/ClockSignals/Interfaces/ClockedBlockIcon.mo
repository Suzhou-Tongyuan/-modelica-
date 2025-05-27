within Modelica.Clocked.ClockSignals.Interfaces;
partial block ClockedBlockIcon 
  "至少一个输入或输出为时钟变量的程序模块的基本图形布局"
  annotation (
    Icon(graphics={
          Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}));
end ClockedBlockIcon;