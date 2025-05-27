within Modelica.Electrical.Batteries.Utilities;
block PulseSeries "脉冲序列"
  import Modelica.Math.BooleanVectors.oneTrue;
  parameter Real amplitude1= 1 "第一脉冲序列的幅度";
  parameter Integer n1(min=0)=1 "第一序列脉冲的数量";
  parameter SI.Time T1 "第一序列脉冲的持续时间";
  parameter SI.Time Tp1 "第一序列脉冲之间的暂停时间";
  parameter Real amplitude2=-amplitude1 "第二脉冲序列的幅度";
  parameter Integer n2(min=0)=1 "第二序列脉冲的数量";
  parameter SI.Time T2=T1 "第二序列脉冲的持续时间";
  parameter SI.Time Tp2=Tp1 "第二序列脉冲之间的暂停时间";
  parameter SI.Time Tp "两个序列之间的暂停时间";
  extends Modelica.Blocks.Interfaces.SignalSource;
protected
  parameter SI.Time Tstart1[n1]={startTime + (k-1)*(T1 + Tp1) for k in 1:n1};
  parameter SI.Time Tstart2[n1]={startTime + n1*(T1 + Tp1) + Tp + (k-1)*(T2 + Tp2) for k in 1:n2};
  Boolean on1, on2;
equation
  on1 = oneTrue({time >= Tstart1[k] and time < Tstart1[k] + T1 for k in 1:n1});
  on2 = oneTrue({time >= Tstart2[k] and time < Tstart2[k] + T2 for k in 1:n1});
  y= offset + (if on1 then amplitude1 elseif on2 then amplitude2 else 0);
  annotation (Icon(graphics={
        Line(
          points={{-100,0},{-80,0}}, 
          color={0,0,0}, 
          pattern=LinePattern.Dash), 
        Line(points={{-10,0},{-10,-60},{10,-60},{10,0},{20,0}}, color={0,0,0}), 
        Line(points={{-50,0},{-50,60},{-40,60},{-40,0},{-20,0}}, color={0,0,0}), 
        Line(
          points={{-20,0},{-10,0}}, 
          color={0,0,0}, 
          pattern=LinePattern.Dash), 
        Line(points={{-80,0},{-80,60},{-70,60},{-70,0},{-50,0}}, color={0,0,0}), 
        Line(points={{20,0},{20,-60},{40,-60},{40,0},{50,0}}, color={0,0,0}), 
        Line(points={{50,0},{50,-60},{70,-60},{70,0},{80,0}}, color={0,0,0}), 
        Line(
          points={{80,0},{100,0}}, 
          color={0,0,0}, 
          pattern=LinePattern.Dash)}), Documentation(info="<html>
<p>
从<code>time=startTime</code>开始，首先发出一系列由<code>n1</code>个幅度为<code>amplitude1</code>、持续时间为<code>T1</code>、每个脉冲之间暂停时间为<code>Tp1</code>的脉冲。<br>
然后，在暂停时间<code>Tp</code>后，发出由<code>n2</code>个幅度为<code>amplitude2</code>、持续时间为<code>T2</code>、每个脉冲之间暂停时间为<code>Tp2</code>的脉冲序列。
</p>
</html>"));
end PulseSeries;