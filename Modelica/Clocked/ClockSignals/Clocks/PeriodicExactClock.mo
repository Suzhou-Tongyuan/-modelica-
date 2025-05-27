within Modelica.Clocked.ClockSignals.Clocks;
block PeriodicExactClock 
  "生成一个周期性时钟信号，其周期由一个整数定义，并且具有分辨率"
  import Modelica.Clocked.Types.Resolution;

  parameter Integer factor(min=0) 
    "与分辨率有关的采样系数" annotation(Evaluate=true);
  parameter Clocked.Types.Resolution resolution=Resolution.ms "时钟分辨率" 
    annotation (Evaluate=true, __Dymola_editText=false);
  extends Clocked.ClockSignals.Interfaces.PartialPeriodicClock;
protected
  constant Integer conversionTable[8]={365*24*60*60, 24*60*60, 60*60, 60, 1, 1000, 1000*1000, 1000*1000*1000} 
    "将分辨率转换为整数时钟分辨率的表格";
  parameter Integer resolutionFactor = conversionTable[Integer(resolution)] annotation(Evaluate=true);
  Clock c annotation(HideResult=true);
equation
  // 下面使用 subSample 的分支对应于更简单的 Clock(factor*resolutionFactor, 1)、
  // 但在某些奇怪的情况下效果更好。
  //
  // 具体来说，如果乘积超过 2^31（秒），即大约 68 年，简单的变体可能会失败。
  //
  // 根据标准，使用 subSample 可以可靠地工作到 2^31 年。
  //
  // else 分支不存在类似问题。
  if resolution < Resolution.s then
     c = subSample(Clock(factor), resolutionFactor);
  else
     c = Clock(factor, resolutionFactor);
  end if;

  if useSolver then
     y = Clock(c, solverMethod=solverMethod);
  else
     y = c;
  end if;

  annotation (
       defaultComponentName="periodicClock1", 
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}, initialScale=0.06), 
                    graphics={
        Rectangle(
          extent={{20,58},{40,46}}, 
          fillPattern=FillPattern.Solid, 
          rotation=90, 
          origin={52,60}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}), 
        Rectangle(
          extent={{20,58},{40,46}}, 
          fillPattern=FillPattern.Solid, 
          rotation=45, 
          origin={-50,-120}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}), 
        Text(
          extent={{-150,-110},{150,-150}}, 
          textColor={0,0,0}, 
          textString="%factor %resolution"), 
        Text(
          visible=useSolver, 
          extent={{-150,-160},{150,-200}}, 
          textColor={0,0,0}, 
          textString="%solverMethod")}), 
    Documentation(info="<html>
<p>
这个组件生成一个周期性时钟，
在仿真开始时开始计时。
<strong>factor</strong> 由枚举类型 <a href=\"modelica://Modelica.Clocked.Types.Resolution\">Resolution</a> 定义的分辨率和整数参数 <strong>factor</strong> 的乘积确定。
在内部，周期被表示为一个有理数。
所有使用有理数定义的时钟在时间上都是精确同步的。
</p>

<p>
例如:
</p>

<blockquote><pre>
import Modelica.Clocked.ClockSignals.Clocks;
import Modelica.Clocked.Types;
Clocks.PeriodicExactClock periodicClock(factor=10,
                                        resolution=Types.Resolution.ms);
// Clock ticks every 1/100 seconds
</pre></blockquote>

<p>
有关时钟的介绍请参见
<a href=\"modelica://Modelica.Clocked.UsersGuide.Clocks\">UsersGuide.Clocks</a>.
</p>

<p>
如果时钟与时钟驱动的连续时间分区相关联，
则必须定义一个 <strong>integrator</strong>，
用于从前一个时钟周期集成到当前时钟周期。
这是通过设置参数 <strong>useSolver</strong> = <strong>true</strong> 并
定义积分方法为 String 类型的 <strong>solver</strong> 参数来实现的，
这两个参数位于 <strong>Advanced</strong> 选项卡中。
示例可参见
<a href=\"modelica://Modelica.Clocked.Examples.Systems.ControlledMixingUnit\">Examples.Systems.ControlledMixingUnit</a>.
</p>
</html>"));
end PeriodicExactClock;