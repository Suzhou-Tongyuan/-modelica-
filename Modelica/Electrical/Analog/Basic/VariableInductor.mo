within Modelica.Electrical.Analog.Basic;
model VariableInductor 
  "理想线性可变电感"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  Modelica.Blocks.Interfaces.RealInput L(unit="H") annotation (Placement(
        transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
  SI.MagneticFlux Psi;
  parameter SI.Inductance Lmin=Modelica.Constants.eps 
    "可变电感的下限值";
  parameter SI.Current IC=0 "初始值";
  parameter Boolean UIC=false "决定是否使用初始值IC";
initial equation
  if UIC then
    i = IC;
  end if;
equation
  assert(L >= 0, "Inductance L_ (= " + String(L) + ") has to be >= 0!");
  // protect solver from index change
  Psi = noEvent(max(L, Lmin))*i;
  v = der(Psi);
  annotation (defaultComponentName="inductor", 
    Documentation(info="<html>
<p>线性导体通过下面式子的分支电压<em>v</em>与分支电流<em>i</em>连接起来
<br><em><strong>v = d Psi/dt </strong></em>和<em><strong>Psi = L * i </strong></em>.
<br>电感<em>L</em>是作为输入信号：
<p>L需要满足L≥0。为了避免使用变量索引系统，如果 0≤L< Lmin，则设置L=Lmin，其中Lmin是一个参数，其默认值为Modelica.Constants.eps。</p>

<p><br>除了Lmin参数外，电感器模型还有两个相关的参数:IC和UIC。通过IC参数，用户可以指定流过电感器的初始电流值。</p>

<p><br>因此，在模拟开始时，电感器有一个初始电流。另一个参数 UIC 是布尔类型。如果 UIC 为真，模拟工具会在初始计算中使用 IC 值，通过添加方程i=IC来实现。如果UIC为假，IC值可以用于(但不是必须)计算初始值，以便简化初始计算的数值算法。</p>
</html>", 
        revisions="<html>
<ul>
<li><em> 2009/8/7   </em>
     Anton Haumer<br> 添加电阻温度系数<br>
     </li>


<li><em> 2004/6/7   </em>
      Christoph Clauss<br>创建<br>
     </li>
     

</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}),graphics={
        Line(points={{-90,0},{-60,0}}, color={0,0,255}), 
        Line(points={{60,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier)}));
end VariableInductor;