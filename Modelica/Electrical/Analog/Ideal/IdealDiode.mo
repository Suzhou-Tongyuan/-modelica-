within Modelica.Electrical.Analog.Ideal;
model IdealDiode "理想二极管"
  extends Modelica.Electrical.Analog.Interfaces.IdealSemiconductor;
equation
  off = s < 0;
  annotation(defaultComponentName = "diode", 
    Documentation(info = "<html>
<p>这是一个理想二极管，具体查看
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.IdealSemiconductor\">IdealSemiconductor</a><br>
当voltage&gt;Vknee二极管导通<br>
反之则截止.
</p>
</html>", 
    revisions = "<html>
<ul>
<li><em>2016年2月7日</em>
       作者：Anton Haumer<br>从部分IdealSemiconductor扩展而来<br>
       </li>
<li><em>2009年3月11日</em>
       作者：Christoph Clauss<br>添加了条件热口<br>
       </li>
<li><em>2004年5月7日</em>
       作者：Christoph Clauss 和 Anton Haumer<br>添加了Vknee<br>
       </li>
<li><em>几年前</em>
       作者：Christoph Clauss<br>实现<br>
       </li>
</ul>

</html>"));
end IdealDiode;