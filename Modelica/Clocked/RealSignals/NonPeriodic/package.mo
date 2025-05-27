within Modelica.Clocked.RealSignals;
package NonPeriodic "对周期性和非周期性时钟信号进行操作的模块库"
extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
这个软件包包含可以用于周期性和非周期性时钟的模块。
这些模块通常利用上一个时间间隔的持续时间来计算输出信号。
例如，<a href=\"modelica://Modelica.Clocked.RealSignals.NonPeriodic.PI\">PI</a>
模块的系数是从连续时间PI块的系数和上一个时间间隔的持续时间计算得出的。
</p>
</html>"));
end NonPeriodic;