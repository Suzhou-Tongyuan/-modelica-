within Modelica.Electrical.Machines.Utilities;
block SinCosEvaluation "正弦余弦解算器信号评估"
  extends Modelica.Blocks.Icons.Block;
  Blocks.Interfaces.RealInput u[4] "来自正弦余弦解算器的信号" 
    annotation (Placement(transformation(extent={{-140,20},{-100,-20}})));
  Blocks.Math.Feedback feedbackCos 
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Blocks.Math.Feedback feedbackSin 
    annotation (Placement(transformation(extent={{-70,-30},{-50,-50}})));
  SpacePhasors.Blocks.Rotator rotator 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Blocks.Continuous.Integrator integrator(final k=1e6) 
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Blocks.Continuous.Der der1 
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Blocks.Interfaces.RealOutput phi(unit="rad") "角度" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Blocks.Interfaces.RealOutput w(unit="rad/s") "角速度" 
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  connect(u[1], feedbackCos.u1) annotation (Line(points={{-120,15},{-80,15}, 
          {-80,40},{-68,40}}, color={0,0,127}));
  connect(u[2], feedbackCos.u2) 
    annotation (Line(points={{-120,5},{-60,5},{-60,32}}, color={0,0,127}));
  connect(u[3], feedbackSin.u1) annotation (Line(points={{-120,-5},{-80,-5}, 
          {-80,-40},{-68,-40}}, color={0,0,127}));
  connect(u[4], feedbackSin.u2) annotation (Line(points={{-120,-15},{-60, 
          -15},{-60,-32}}, color={0,0,127}));
  connect(feedbackCos.y, rotator.u[1]) annotation (Line(points={{-51,40},{
          -40,40},{-40,0},{-22,0}}, color={0,0,127}));
  connect(feedbackSin.y, rotator.u[2]) annotation (Line(points={{-51,-40},{
          -40,-40},{-40,0},{-22,0}}, color={0,0,127}));
  connect(rotator.y[2], integrator.u) 
    annotation (Line(points={{1,0},{8,0}}, color={0,0,127}));
  connect(integrator.y, rotator.angle) annotation (Line(points={{31,0},{40, 
          0},{40,-20},{-10,-20},{-10,-12}}, color={0,0,127}));
  connect(integrator.y, der1.u) annotation (Line(points={{31,0},{40,0},{40, 
          -60},{58,-60}}, color={0,0,127}));
  connect(integrator.y, phi) 
    annotation (Line(points={{31,0},{110,0}}, color={0,0,127}));
  connect(der1.y, w) 
    annotation (Line(points={{81,-60},{110,-60}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(points={{-80,80},{-76.2,79.8},{-70.6,76.6},{-64.9,69.7},{-59.3, 
              59.4},{-52.9,44.1},{-44.83,21.2},{-27.9,-30.8},{-20.7,-50.2},{-14.3, 
              -64.2},{-8.7,-73.1},{-3,-78.4},{2.6,-80},{8.2,-77.6},{13.9,-71.5}, 
              {19.5,-61.9},{25.9,-47.2},{34,-24.8},{42,0}}, smooth=Smooth.Bezier), 
        Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4, 
              74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3, 
              59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7, 
              -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5}, 
              {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, smooth = Smooth.Bezier)}), 
      Documentation(info="<html>
<p>
正弦余弦解算器提供四个轨道：
</p>
<ul>
<li>余弦</li>
<li>负正弦</li>
<li>正弦</li>
<li>负余弦</li>
</ul>
<p>
所有四个轨道具有相同的幅值和相同的偏移&gt;幅值。偏移用于检测轨道的丢失。为了消除偏移，从(正弦)中减去(负正弦)，从(余弦)中减去(负余弦)，得到了一个余弦和一个正弦信号，其幅度加倍但没有偏移。
</p>
<p>
将余弦和正弦解释为空间矢量的实部和虚部，可以计算矢量的角度(即，将直角坐标转换为极坐标)。
如果信号受到一些噪声的影响，则这种方法并不十分健壮。
因此，矢量会被一个控制器旋转一个角度。控制器旨在使虚部等于零。结果的角度是连续的，即角度的导数是2*&pi;*frequency。
如果需要，角度可以被封装到]-&pi;, +&pi;]区间。
</p>
<p>
如果在2&pi;/p的旋转中，正弦余弦解算器提供轨道的一个周期，结果是相对于一个极对的角度，并且可以直接用于场定向控制。
</p>
</html>"));
end SinCosEvaluation;