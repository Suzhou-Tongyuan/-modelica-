within Modelica.Magnetic.FluxTubes.UsersGuide;
package Hysteresis "磁滞"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>

<h4>引言</h4>

<p>
通过 Shapes.HysteresisAndMagnets 软件包中提供的元素，可以在电磁网络仿真过程中考虑铁磁磁滞和动态磁滞。铁磁磁滞是磁芯材料的材料属性，与频率无关。当铁磁材料暴露在交变磁场中时，由于涡流的作用，静态铁磁磁滞与频率相关的磁滞相叠加。图 1 示例性地显示了带有铁芯的简单电感器在三种不同激励频率下的模拟磁滞特性。因此，0 Hz 磁滞环代表铁芯材料的静态铁磁磁滞。频率越高，磁滞环越宽，这是因为磁芯材料中产生了涡流。.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Inductor with ferromagnetic core and hysteresis effects; (a) diagram of the network model; (b) simulated hysteresis characteristics of the core for different excitation frequencies of 0, 10 and 100 Hz (the example model can be found at: <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.InductorWithHysteresis\">Examples.Hysteresis.InductorWithHysteresis</a>)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/InductorWithHysteresis_DiagramAndSim.png\">
   </td>
  </tr>
</table>

<p>
描述铁磁材料静态迟滞行为的几种模型是已知的。在这个库中实现了其中的两个。简单但快速的<a href=\"modelica://Modelica . Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen磁滞模型</a>和更精确但更复杂的<a href=\"modelica:// modelica.magnetic .fluxtubes.usersguide.hysteresis.statichysteresis.Preisach\">Preisach滞后模型</a>。点击链接查看两个模型的简短描述.
</p>

<h4>磁滞和磁体包的磁通管元素</h4>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
 <tr>
  <th>名称/图标</th><th>说明</th>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenSoft\">GenericHystTellinenSoft</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenS.png\">
  </td>
  <td>
  用于模拟具有铁磁和动态磁滞(涡流)的软磁材料的磁通管元件。
  铁磁滞回行为是由<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis. Tellinen\">Tellinen滞后模型</a>。极限滞回线的形状用4个参数的简单双曲正切函数描述。因此，迟滞形状变化有限，但模型的参数化非常简单，模型具有较快的鲁棒性.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenHard\">GenericHystTellinenHard</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenH.png\">
  </td>
  <td>
  用于模拟硬磁材料铁磁(静)滞回的磁通管元件。
  铁磁滞回行为是由<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis. Tellinen\">Tellinen滞后模型</a>。极限滞回线的形状用4个参数的简单双曲正切函数描述.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenEverett\">GenericHystTellinenEverett</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenE.png\">
  </td>
  <td>
  用于模拟具有铁磁和动态磁滞(涡流)的软磁材料的磁通管元件。
  铁磁滞回行为是由 <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis. Tellinen\">Tellinen滞后模型</a>。
  极限铁磁磁滞回线的形状由Everett函数的解析描述指定，该函数也用于参数化<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystPreisachEverett\">GenericHystPreisachEverett</a>。
  预定义参数集的库可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>中找到.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenTable\">GenericHystTellinenTable</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenT.png\">
  </td>
  <td>
  用于模拟具有铁磁和动态磁滞(涡流)的磁性材料的磁通管元件。
  铁磁滞回行为是由<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis. Tellinen\">Tellinen滞后模型</a>。
  极限铁磁磁滞回线的上升支路和下降支路由表格数据指定。因此，几乎任何迟滞形状都是可能的。
  带有预定义表的库可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisTableData\">FluxTubes.Material.HysteresisTableData</a>找到.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystPreisachEverett\">GenericHystPreisachEverett</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystPreisachE.png\">
  </td>
  <td>
  用于模拟具有铁磁和动态磁滞(涡流)的磁性材料的磁通管元件。铁磁磁滞特性由<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Preisach\">Preisach滞后模型</a>。极限铁磁磁滞回线的形状由埃弗雷特函数的解析描述来确定。
预定义参数集的库可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>中找到.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericHystTellinenPermanentMagnet\">GenericHystTellinenPermanentMagnet</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericHystTellinenPM.png\">
  </td>
  <td>
  用于永磁体硬磁滞回建模的磁通管元件。模型类似于<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystTellinenHard\">GenericHystTellinenHard</a>，但有一个初始磁化预设为-100%和一个适应的图标，以更好的可读性的图表.
  </td>
 </tr>

 <tr>
  <td><a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets.GenericLinearPermanentMagnet\">GenericLinearPermanentMagnet</a><br><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/GenericLinearPM.png\">
  </td>
  <td>
  线性永磁体的简单模型。常见永磁材料的典型特性可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">FluxTubes.Material.HardMagnetic</a>找到.
  </td>
 </tr>

</table>

</html>"));
end Hysteresis;