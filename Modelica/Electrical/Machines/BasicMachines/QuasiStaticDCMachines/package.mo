within Modelica.Electrical.Machines.BasicMachines;
package QuasiStaticDCMachines "准静态直流电机模型"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
<p>
该包含准静态直流电机的模型；
这些模型与
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.DCMachines\">直流电机的瞬态模型</a>
完全兼容；
唯一的区别是忽略了电气暂态。
</p>
<h4>注意</h4>
<p>
准静态直流电机模型基本上与准静态感应电机模型不同：
准静态直流电机模型忽略了电气暂态，即设置<code>der(i)=0</code>，
而准静态感应电机模型基于时间相量理论，
请参阅<a href=\"modelica://Modelica.Electrical.QuasiStatic\">QuasiStatic Library</a>，
在那里，例如，<code>L*der(i)</code> 被 <code>j*omega*L*(I_re+j*I_im)</code> 替换。
</p>
</html>", 
      revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  echnical Consulting & Electrical Engineering D-93049<br>
   RegensburgGermany<br>
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v2.3.0 2010/02/16 Anton Haumer<br>
       第一次实现</li>
  </ul>
</html>"));
end QuasiStaticDCMachines;