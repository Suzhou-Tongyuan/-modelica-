within Modelica.Electrical.Analog.Basic;
model VariableCapacitor 
  "理想线性可变电容"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  Modelica.Blocks.Interfaces.RealInput C(unit="F") annotation (Placement(
        transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  parameter SI.Capacitance Cmin=Modelica.Constants.eps 
    "可变电容的下限";
  SI.ElectricCharge Q;
  parameter SI.Voltage IC=0 "初始值";
  parameter Boolean UIC=false "判断初始值 Ic 是否应该被使用";
initial equation
  if UIC then
    v = IC;
  end if;
equation
  assert(C >= 0, "Capacitance C (= " + String(C) + ") has to be >= 0!");
  // protect solver from index change
  Q = noEvent(max(C, Cmin))*v;
  i = der(Q);
  annotation (defaultComponentName="capacitor", 
    Documentation(info="<html>
<p>线性导体通过下面式子的分支电压<em>v</em>与分支电流<em>i</em>连接起来
<br><em><strong>i = dQ/dt</strong></em>，<em><strong>Q = C * v</strong></em>.
<br>电容<em>C</em>被作为输入信号：
如果初始值IC大于等于0，否则会引发断言。为了避免使用变量索引系统，如果0小于等于C 且C小于 Cmin，则C=Cmin，其中Cmin是一个参数，其默认值为Modelica.Constants.eps。</p>

<p><br>除了Cmin参数外，电容器模型还有两个参数IC和UIC它们是相关的。通过IC参数，用户可以指定电容器两端电压的初始值，该值定义为从正极p到负极n的电压(v=p.v-n.v)</p>

<p><br>因此，电容器在模拟开始时被充电。另一个参数UIC是布尔类型。如果UIC为真，模拟工具在初始计算时使用IC值，通过添加方程v=IC。如果UIC为假，IC 值可以被用于(但不是必须的！)计算初始值，以便简化初始计算的数值算法。</p>
<p><br>如果UIC为假，IC值可以被用于(但不是必须的！)计算初始值，以便简化初始计算的数值算法。<p><br>
</html>", 
        revisions="<html>
<ul>


<li><em> 2004/6/7   </em>
      Christoph Clauss<br>修改说明文档<br>
     </li>
     
     
<li><em> 2004/4/30   </em>
     Anton Haumer<br> 创建<br>
     </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}),graphics={
        Line(points={{-90,0},{-6,0}}, color={0,0,255}), 
        Line(points={{6,0},{90,0}}, color={0,0,255}), 
        Line(points={{-6,28},{-6,-28}}, color={0,0,255}), 
        Line(points={{6,28},{6,-28}}, color={0,0,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end VariableCapacitor;