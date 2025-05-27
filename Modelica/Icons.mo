within Modelica;
package Icons "图标库"
  partial class Information "通用信息包的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      lineColor = {75, 138, 73}, 
      fillColor = {75, 138, 73}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      Polygon(origin = {-4.167, -15.0}, 
      fillColor = {255, 255, 255}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, 
      smooth = Smooth.Bezier), 
      Ellipse(origin = {7.5, 56.5}, 
      fillColor = {255, 255, 255}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-12.5, -12.5}, {12.5, 12.5}})}), 
      Documentation(info = "<html>
<p>此图标表示只包含文档的类，用于一般描述，例如包的概念和特性。</p>
</html>"  ));
  end Information;
  extends Icons.Package;

  partial class Contact "联系方式的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Rectangle(
      extent = {{-100, 70}, {100, -72}}, 
      fillColor = {235, 235, 235}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-100, -72}, {100, -72}, {0, 20}, {-100, -72}}, 
      fillColor = {215, 215, 215}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{22, 0}, {100, 70}, {100, -72}, {22, 0}}, 
      fillColor = {235, 235, 235}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{-100, 70}, {100, 70}, {0, -20}, {-100, 70}}, 
      fillColor = {241, 241, 241}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>此图标将用于库开发人员的联系信息。</p>
</html>"  ));
  end Contact;

  partial class ReleaseNotes "文档中发布说明的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Polygon(
      points = {{-80, -100}, {-80, 100}, {0, 100}, {0, 20}, {80, 20}, {80, -100}, {-80, 
      -100}}, 
      fillColor = {245, 245, 245}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{0, 100}, {80, 20}, {0, 20}, {0, 100}}, 
      fillColor = {215, 215, 215}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{2, -12}, {50, -12}}), 
      Ellipse(
      extent = {{-56, 2}, {-28, -26}}, 
      fillColor = {215, 215, 215}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{2, -60}, {50, -60}}), 
      Ellipse(
      extent = {{-56, -46}, {-28, -74}}, 
      fillColor = {215, 215, 215}, 
      fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>此图标表示发行说明和库的修订历史。</p>
</html>"));

  end ReleaseNotes;

  partial class References "参考文献的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Polygon(
      points = {{-100, -80}, {-100, 60}, {-80, 54}, {-80, 80}, {-40, 58}, {-40, 100}, {
      -10, 60}, {90, 60}, {100, 40}, {100, -100}, {-20, -100}, {-100, -80}}, 
      lineColor = {0, 0, 255}, 
      pattern = LinePattern.None, 
      fillColor = {245, 245, 245}, 
      fillPattern = FillPattern.Solid), 
      Polygon(points = {{-20, -100}, {-10, -80}, {90, -80}, {100, -100}, {-20, -100}}), 
      Line(points = {{90, -80}, {90, 60}, {100, 40}, {100, -100}}), 
      Line(points = {{90, 60}, {-10, 60}, {-10, -80}}), 
      Line(points = {{-10, 60}, {-40, 100}, {-40, -40}, {-10, -80}, {-10, 60}}), 
      Line(points = {{-20, -88}, {-80, -60}, {-80, 80}, {-40, 58}}), 
      Line(points = {{-20, -100}, {-100, -80}, {-100, 60}, {-80, 54}}), 
      Line(points = {{10, 30}, {72, 30}}), 
      Line(points = {{10, -10}, {70, -10}}), 
      Line(points = {{10, -50}, {70, -50}})}), Documentation(info = 
      "<html>
<p>此图标表示包含对外部文档和文献的引用的文档类。</p>
</html>"  ));

  end References;

  partial package ExamplesPackage 
    "包含可运行示例的包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Polygon(
      origin = {8.0, 14.0}, 
      lineColor = {78, 138, 73}, 
      fillColor = {78, 138, 73}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-58.0, 46.0}, {42.0, -14.0}, {-58.0, -74.0}, {-58.0, 46.0}})}), Documentation(info = "<html>
<p>此图标表示包含可执行示例的包。</p>
</html>"  ));
  end ExamplesPackage;

  partial model Example "可运行示例的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(lineColor = {75, 138, 73}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100, -100}, {100, 100}}), 
      Polygon(lineColor = {0, 0, 255}, 
      fillColor = {75, 138, 73}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}), Documentation(info = "<html>
<p>此图标为示例的图标。播放按钮表示可执行示例。</p>
</html>"  ));
  end Example;

  partial package Package "标准包的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {200, 200, 200}, 
      fillColor = {248, 248, 248}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0), 
      Rectangle(
      lineColor = {128, 128, 128}, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0)}), Documentation(info = "<html>
<p>标准包的图标。</p>
</html>"  ));
  end Package;

  partial package BasesPackage "包含基类包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Ellipse(
      extent = {{-30.0, -30.0}, {30.0, 30.0}}, 
      lineColor = {128, 128, 128}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>这个图标应当用于包含基础模型和类的包/库。</p>
</html>"));
  end BasesPackage;

  partial package VariantsPackage "包含变体包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {
      Ellipse(
      origin = {10.0, 10.0}, 
      fillColor = {76, 76, 76}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-80.0, -80.0}, {-20.0, -20.0}}), 
      Ellipse(
      origin = {10.0, 10.0}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{0.0, -80.0}, {60.0, -20.0}}), 
      Ellipse(
      origin = {10.0, 10.0}, 
      fillColor = {128, 128, 128}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{0.0, 0.0}, {60.0, 60.0}}), 
      Ellipse(
      origin = {10.0, 10.0}, 
      lineColor = {128, 128, 128}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-80.0, 0.0}, {-20.0, 60.0}})}), 
      Documentation(info = "<html>
<p>此图标将用于包含一个组件的多个变体的包/库。</p>
</html>"));
  end VariantsPackage;

  partial package InterfacesPackage "包含接口包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Polygon(origin = {20.0, 0.0}, 
      lineColor = {64, 64, 64}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      points = {{-10.0, 70.0}, {10.0, 70.0}, {40.0, 20.0}, {80.0, 20.0}, {80.0, -20.0}, {40.0, -20.0}, {10.0, -70.0}, {-10.0, -70.0}}), 
      Polygon(fillColor = {102, 102, 102}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-100.0, 20.0}, {-60.0, 20.0}, {-30.0, 70.0}, {-10.0, 70.0}, {-10.0, -70.0}, {-30.0, -70.0}, {-60.0, -20.0}, {-100.0, -20.0}})}), 
      Documentation(info = "<html>
<p>此图标表示包含接口的包。</p>
</html>"));
  end InterfacesPackage;

  partial package SourcesPackage "包含源代码包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Polygon(origin = {23.3333, 0.0}, 
      fillColor = {128, 128, 128}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-23.333, 30.0}, {46.667, 0.0}, {-23.333, -30.0}}), 
      Rectangle(
      fillColor = {128, 128, 128}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-70, -4.5}, {0, 4.5}})}), 
      Documentation(info = "<html>
<p>此图标表示包含源代码的包。</p>
</html>"));
  end SourcesPackage;

  partial package SensorsPackage "包含传感器包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Ellipse(origin = {0.0, -30.0}, 
      fillColor = {255, 255, 255}, 
      extent = {{-90.0, -90.0}, {90.0, 90.0}}, 
      startAngle = 20.0, 
      endAngle = 160.0), 
      Ellipse(origin = {0.0, -30.0}, 
      fillColor = {128, 128, 128}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-20.0, -20.0}, {20.0, 20.0}}), 
      Line(origin = {0.0, -30.0}, 
      points = {{0.0, 60.0}, {0.0, 90.0}}), 
      Ellipse(origin = {-0.0, -30.0}, 
      fillColor = {64, 64, 64}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-10.0, -10.0}, {10.0, 10.0}}), 
      Polygon(
      origin = {-0.0, -30.0}, 
      rotation = -35.0, 
      fillColor = {64, 64, 64}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-7.0, 0.0}, {-3.0, 85.0}, {0.0, 90.0}, {3.0, 85.0}, {7.0, 0.0}})}), 
      Documentation(info = "<html>
<p>这个图标表示一个包含传感器的包。</p>
</html>"));
  end SensorsPackage;

  partial package UtilitiesPackage "实用程序包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {
      Polygon(
      origin = {1.3835, -4.1418}, 
      rotation = 45.0, 
      fillColor = {64, 64, 64}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-15.0, 93.333}, {-15.0, 68.333}, {0.0, 58.333}, {15.0, 68.333}, {15.0, 93.333}, {20.0, 93.333}, {25.0, 83.333}, {25.0, 58.333}, {10.0, 43.333}, {10.0, -41.667}, {25.0, -56.667}, {25.0, -76.667}, {10.0, -91.667}, {0.0, -91.667}, {0.0, -81.667}, {5.0, -81.667}, {15.0, -71.667}, {15.0, -61.667}, {5.0, -51.667}, {-5.0, -51.667}, {-15.0, -61.667}, {-15.0, -71.667}, {-5.0, -81.667}, {0.0, -81.667}, {0.0, -91.667}, {-10.0, -91.667}, {-25.0, -76.667}, {-25.0, -56.667}, {-10.0, -41.667}, {-10.0, 43.333}, {-25.0, 58.333}, {-25.0, 83.333}, {-20.0, 93.333}}), 
      Polygon(
      origin = {10.1018, 5.218}, 
      rotation = -45.0, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      points = {{-15.0, 87.273}, {15.0, 87.273}, {20.0, 82.273}, {20.0, 27.273}, {10.0, 17.273}, {10.0, 7.273}, {20.0, 2.273}, {20.0, -2.727}, {5.0, -2.727}, {5.0, -77.727}, {10.0, -87.727}, {5.0, -112.727}, {-5.0, -112.727}, {-10.0, -87.727}, {-5.0, -77.727}, {-5.0, -2.727}, {-20.0, -2.727}, {-20.0, 2.273}, {-10.0, 7.273}, {-10.0, 17.273}, {-20.0, 27.273}, {-20.0, 82.273}})}), 
      Documentation(info = "<html>
<p>此图标表示包含实用程序类的包。</p>
</html>"  ));
  end UtilitiesPackage;

  partial package TypesPackage "包含类型定义包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Polygon(
      origin = {-12.167, -23}, 
      fillColor = {128, 128, 128}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{12.167, 65}, {14.167, 93}, {36.167, 89}, {24.167, 20}, {4.167, -30}, 
      {14.167, -30}, {24.167, -30}, {24.167, -40}, {-5.833, -50}, {-15.833, 
      -30}, {4.167, 20}, {12.167, 65}}, 
      smooth = Smooth.Bezier), Polygon(
      origin = {2.7403, 1.6673}, 
      fillColor = {128, 128, 128}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{49.2597, 22.3327}, {31.2597, 24.3327}, {7.2597, 18.3327}, {-26.7403, 
      10.3327}, {-46.7403, 14.3327}, {-48.7403, 6.3327}, {-32.7403, 0.3327}, {-6.7403, 
      4.3327}, {33.2597, 14.3327}, {49.2597, 14.3327}, {49.2597, 22.3327}}, 
      smooth = Smooth.Bezier)}));
  end TypesPackage;

  partial package FunctionsPackage "包含函数包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Text(
      textColor = {128, 128, 128}, 
      extent = {{-90, -90}, {90, 90}}, 
      textString = "f")}));
  end FunctionsPackage;

  partial package IconsPackage "包含图标包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Polygon(
      origin = {-8.167, -17}, 
      fillColor = {128, 128, 128}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {
      4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, 
      -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, 
      smooth = Smooth.Bezier), Ellipse(
      origin = {-0.5, 56.5}, 
      fillColor = {128, 128, 128}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-12.5, -12.5}, {12.5, 12.5}})}));
  end IconsPackage;

  partial package InternalPackage 
    "内部包的图标(表示该包不应被用户直接使用)"

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Rectangle(
      lineColor = {215, 215, 215}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{-100, -100}, {100, 100}}, 
      radius = 25), 
      Rectangle(
      lineColor = {215, 215, 215}, 
      extent = {{-100, -100}, {100, 100}}, 
      radius = 25), 
      Ellipse(
      extent = {{-80, 80}, {80, -80}}, 
      lineColor = {215, 215, 215}, 
      fillColor = {215, 215, 215}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-55, 55}, {55, -55}}, 
      lineColor = {255, 255, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-60, 14}, {60, -14}}, 
      lineColor = {215, 215, 215}, 
      fillColor = {215, 215, 215}, 
      fillPattern = FillPattern.Solid, 
      rotation = 45)}), 
      Documentation(info = "<html>

<p>
这个图标应当用于包含不直接供用户使用的内部类的包。
</p>
</html>"));
  end InternalPackage;

  partial package MaterialPropertiesPackage 
    "包含属性类包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Ellipse(
      lineColor = {102, 102, 102}, 
      fillColor = {204, 204, 204}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Sphere, 
      extent = {{-60.0, -60.0}, {60.0, 60.0}})}), 
      Documentation(info = "<html>
<p>此图标表示包含属性的包。</p>
</html>"));
  end MaterialPropertiesPackage;

  partial package RecordsPackage "包含记录包的图标"
    extends Modelica.Icons.Package;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {
      Rectangle(
      origin = {0, -20}, 
      lineColor = {64, 64, 64}, 
      fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-80, -60}, {80, 60}}, 
      radius = 25.0), 
      Line(
      points = {{-80, 0}, {80, 0}}, 
      color = {64, 64, 64}), 
      Line(
      origin = {0, -40}, 
      points = {{-80, 0}, {80, 0}}, 
      color = {64, 64, 64}), 
      Line(
      origin = {0, -5}, 
      points = {{0, 45}, {0, -75}}, 
      color = {64, 64, 64})}), 
      Documentation(info = "<html>
<p>此图标表示包含记录的包</p>
</html>"));
  end RecordsPackage;

  partial class MaterialProperty "属性类的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(lineColor = {102, 102, 102}, 
      fillColor = {204, 204, 204}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Sphere, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}})}), 
      Documentation(info = "<html>
<p>这个图标表示一个属性类。</p>
</html>"  ));
  end MaterialProperty;
  partial class RotationalSensor "Icon representing a round measurement device"

    annotation(Protection(hideFromBrowser=true), 
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      fillColor = {245, 245, 245}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-70.0, -70.0}, {70.0, 70.0}}), 
      Line(points = {{0.0, 70.0}, {0.0, 40.0}}), 
      Line(points = {{22.9, 32.8}, {40.2, 57.3}}), 
      Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), 
      Line(points = {{37.6, 13.7}, {65.8, 23.9}}), 
      Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), 
      Ellipse(
      lineColor = {64, 64, 64}, 
      fillColor = {255, 255, 255}, 
      extent = {{-12.0, -12.0}, {12.0, 12.0}}), 
      Polygon(
      rotation = -17.5, 
      fillColor = {64, 64, 64}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-5.0, 0.0}, {-2.0, 60.0}, {0.0, 65.0}, {2.0, 60.0}, {5.0, 0.0}}), 
      Ellipse(
      fillColor = {64, 64, 64}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-7.0, -7.0}, {7.0, 7.0}})}), 
      Documentation(info = "<html>
<p>
This icon is designed for a <strong>rotational sensor</strong> model.
</p>
</html>"  ));
  end RotationalSensor;

  partial class RoundSensor "代表圆形测量装置的图标"

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      fillColor = {245, 245, 245}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-70.0, -70.0}, {70.0, 70.0}}), 
      Line(points = {{0.0, 70.0}, {0.0, 40.0}}), 
      Line(points = {{22.9, 32.8}, {40.2, 57.3}}), 
      Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), 
      Line(points = {{37.6, 13.7}, {65.8, 23.9}}), 
      Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), 
      Ellipse(
      lineColor = {64, 64, 64}, 
      fillColor = {255, 255, 255}, 
      extent = {{-12.0, -12.0}, {12.0, 12.0}}), 
      Polygon(
      rotation = -17.5, 
      fillColor = {64, 64, 64}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-5.0, 0.0}, {-2.0, 60.0}, {0.0, 65.0}, {2.0, 60.0}, {5.0, 0.0}}), 
      Ellipse(
      fillColor = {64, 64, 64}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-7.0, -7.0}, {7.0, 7.0}})}), 
      Documentation(info = "<html>
<p>
这个图标是为<strong>转动传感器</strong>模型设计的。
</p>
</html>"));
  end RoundSensor;

  partial class RectangularSensor 
    "表示线性测量装置的图标"

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      fillColor = {245, 245, 245}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-70.0, -60.0}, {70.0, 20.0}}), 
      Polygon(
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-40, -40}, {-50, -16}, {-30, -16}, {-40, -40}}), 
      Line(points = {{-40, 0}, {-40, -16}}), 
      Line(points = {{-70, 0}, {-40, 0}}), 
      Line(points = {{-50.0, -40.0}, {-50.0, -60.0}}), 
      Line(points = {{-30.0, -40.0}, {-30.0, -60.0}}), 
      Line(points = {{-10.0, -40.0}, {-10.0, -60.0}}), 
      Line(points = {{10.0, -40.0}, {10.0, -60.0}}), 
      Line(points = {{30.0, -40.0}, {30.0, -60.0}}), 
      Line(points = {{50.0, -40.0}, {50.0, -60.0}})}), 
      Documentation(info = "<html>
<p>
这个图标是为<strong>平动传感器</strong>模型设计的。
</p></html>"));
  end RectangularSensor;

  partial function Function "函数的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Text(
      textColor = {0, 0, 255}, 
      extent = {{-150, 105}, {150, 145}}, 
      textString = "%name"), 
      Ellipse(
      lineColor = {108, 88, 49}, 
      fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100, -100}, {100, 100}}), 
      Text(
      textColor = {108, 88, 49}, 
      extent = {{-90.0, -90.0}, {90.0, 90.0}}, 
      textString = "f")}), 
      Documentation(info = "<html>
<p>此图标表示Modelica函数。</p>
</html>"  ));
  end Function;

  partial record Record "记录的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
      Text(
      textColor = {0, 0, 255}, 
      extent = {{-150, 60}, {150, 100}}, 
      textString = "%name"), 
      Rectangle(
      origin = {0.0, -25.0}, 
      lineColor = {64, 64, 64}, 
      fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100.0, -75.0}, {100.0, 75.0}}, 
      radius = 25.0), 
      Line(
      points = {{-100.0, 0.0}, {100.0, 0.0}}, 
      color = {64, 64, 64}), 
      Line(
      origin = {0.0, -50.0}, 
      points = {{-100.0, 0.0}, {100.0, 0.0}}, 
      color = {64, 64, 64}), 
      Line(
      origin = {0.0, -25.0}, 
      points = {{0.0, 75.0}, {0.0, -75.0}}, 
      color = {64, 64, 64})}), Documentation(info = "<html>
<p>
此图标表示一个记录。
</p>
</html>"  ));
  end Record;

  type TypeReal "实数类型的图标"
    extends Real;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {160, 160, 164}, 
      fillColor = {160, 160, 164}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0), 
      Text(
      textColor = {255, 255, 255}, 
      extent = {{-90.0, -50.0}, {90.0, 50.0}}, 
      textString = "R")}), Documentation(info = "<html>
<p>
这个图标是为<strong>Real</strong>类型设计的。
</p>
</html>"    ));
  end TypeReal;

  type TypeInteger "整数类型的图标"
    extends Integer;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {160, 160, 164}, 
      fillColor = {160, 160, 164}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0), 
      Text(
      textColor = {255, 255, 255}, 
      extent = {{-90.0, -50.0}, {90.0, 50.0}}, 
      textString = "I")}), Documentation(info = "<html>
<p>
这个图标是为<strong>Integer</strong>类型设计的。
</p>
</html>"  ));
  end TypeInteger;

  type TypeBoolean "布尔类型的图标"
    extends Boolean;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {160, 160, 164}, 
      fillColor = {160, 160, 164}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0), 
      Text(
      textColor = {255, 255, 255}, 
      extent = {{-90.0, -50.0}, {90.0, 50.0}}, 
      textString = "B")}), 
      Documentation(info = "<html>
<p>
这个图标是为<strong>Boolean</strong>类型设计的。
</p></html>"  ));
  end TypeBoolean;

  type TypeString "字符串类型的图标"
    extends String;
    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {160, 160, 164}, 
      fillColor = {160, 160, 164}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0), 
      Text(
      textColor = {255, 255, 255}, 
      extent = {{-90.0, -50.0}, {90.0, 50.0}}, 
      textString = "S")}), Documentation(info = "<html>
<p>
这个图标是为<strong>String</strong>类型设计的。
</p>
</html>"    ));
  end TypeString;

  expandable connector SignalBus "信号总线的图标"

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, initialScale = 0.2), graphics = {
      Rectangle(
      lineColor = {255, 204, 51}, 
      lineThickness = 0.5, 
      extent = {{-20.0, -2.0}, {20.0, 2.0}}), 
      Polygon(
      fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 50.0}, {80.0, 50.0}, {100.0, 30.0}, {80.0, -40.0}, {60.0, -50.0}, {-60.0, -50.0}, {-80.0, -40.0}, {-100.0, 30.0}}, 
      smooth = Smooth.Bezier), 
      Ellipse(
      fillPattern = FillPattern.Solid, 
      extent = {{-65.0, 15.0}, {-55.0, 25.0}}), 
      Ellipse(
      fillPattern = FillPattern.Solid, 
      extent = {{-5.0, 15.0}, {5.0, 25.0}}), 
      Ellipse(
      fillPattern = FillPattern.Solid, 
      extent = {{55.0, 15.0}, {65.0, 25.0}}), 
      Ellipse(
      fillPattern = FillPattern.Solid, 
      extent = {{-35.0, -25.0}, {-25.0, -15.0}}), 
      Ellipse(
      fillPattern = FillPattern.Solid, 
      extent = {{25.0, -25.0}, {35.0, -15.0}})}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}, 
      initialScale = 0.2), graphics = {
      Polygon(
      points = {{-40, 25}, {40, 25}, {50, 15}, {40, -20}, {30, -25}, {-30, -25}, {-40, -20}, {-50, 15}}, 
      fillColor = {255, 204, 51}, 
      fillPattern = FillPattern.Solid, 
      smooth = Smooth.Bezier), 
      Ellipse(
      extent = {{-32.5, 7.5}, {-27.5, 12.5}}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-2.5, 12.5}, {2.5, 7.5}}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{27.5, 12.5}, {32.5, 7.5}}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-17.5, -7.5}, {-12.5, -12.5}}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{12.5, -7.5}, {17.5, -12.5}}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-150, 70}, {150, 40}}, 
      textString = "%name")}), 
      Documentation(info = "<html>
这个图标是为<strong>信号总线</strong>连接器设计的。
</html>"  ));
  end SignalBus;

  expandable connector SignalSubBus "信号子总线的图标"

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(
      points = {{-16.0, 2.0}, {16.0, 2.0}}, 
      color = {255, 204, 51}, 
      thickness = 0.5), 
      Rectangle(
      lineColor = {255, 204, 51}, 
      lineThickness = 0.5, 
      extent = {{-10.0, 0.0}, {8.0, 8.0}}), 
      Polygon(
      fillColor = {255, 215, 136}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 50.0}, {80.0, 50.0}, {100.0, 30.0}, {80.0, -40.0}, {60.0, -50.0}, {-60.0, -50.0}, {-80.0, -40.0}, {-100.0, 30.0}}, 
      smooth = Smooth.Bezier), 
      Ellipse(
      fillPattern = FillPattern.Solid, 
      extent = {{-55.0, 15.0}, {-45.0, 25.0}}), 
      Ellipse(
      fillPattern = FillPattern.Solid, 
      extent = {{45.0, 15.0}, {55.0, 25.0}}), 
      Ellipse(
      fillPattern = FillPattern.Solid, 
      extent = {{-5.0, -25.0}, {5.0, -15.0}}), 
      Rectangle(
      lineColor = {255, 215, 136}, 
      lineThickness = 0.5, 
      extent = {{-20.0, 0.0}, {20.0, 4.0}})}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Polygon(
      points = {{-40, 25}, {40, 25}, {50, 15}, {40, -20}, {30, -25}, {-30, -25}, {-40, -20}, {-50, 15}}, 
      fillColor = {255, 204, 51}, 
      fillPattern = FillPattern.Solid, 
      smooth = Smooth.Bezier), 
      Ellipse(
      extent = {{-22.5, 7.5}, {-17.5, 12.5}}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{17.5, 12.5}, {22.5, 7.5}}, 
      fillPattern = FillPattern.Solid), 
      Ellipse(
      extent = {{-2.5, -7.5}, {2.5, -12.5}}, 
      fillPattern = FillPattern.Solid), 
      Text(
      extent = {{-150, 70}, {150, 40}}, 
      textString = 
      "%name")}), 
      Documentation(info = "<html>
<p>
这个图标是为信号连接器中的<strong>子总线</strong>设计的。
</p>
</html>"  ));

  end SignalSubBus;

  partial class UnderConstruction 
    "仍在构建中类的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Polygon(points = {{-100, -100}, {0, 80}, {100, -100}, {-100, -100}}, 
      lineColor = {255, 0, 0}, 
      lineThickness = 0.5)}), Documentation(info = "<html>
<p>库开发人员可以使用这个图标来表示各自的模型正在构建中。</p>
</html>"));
  end UnderConstruction;

  partial class ObsoleteModel 
    "已过时并将在以后的版本中删除的类的图标"

    annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Rectangle(
      extent = {{-102, 102}, {102, -102}}, 
      lineColor = {255, 0, 0}, 
      pattern = LinePattern.Dash, 
      lineThickness = 0.5)}), Documentation(info = "<html>
<p>
这个部分类旨在为一个<u>过时的模型</u>提供默认图标，该模型将在未来的版本中从相应的库中移除。
</p>
</html>"));
  end ObsoleteModel;

  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
    -100}, {100, 100}}), graphics = {Polygon(
    origin = {-8.167, -17}, 
    fillColor = {128, 128, 128}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {
    4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, 
    -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, 
    smooth = Smooth.Bezier), Ellipse(
    origin = {-0.5, 56.5}, 
    fillColor = {128, 128, 128}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    extent = {{-12.5, -12.5}, {12.5, 12.5}})}), Documentation(info = "<html>
<p>此包包含用于图形布局的组件定义，这些组件可用于不同的库。
可以通过在所需类中使用&quot;extends&quot;继承图标，或直接复制&quot;icon&quot;层来使用这些图标。</p>

<h4>主要作者</h4>

<dl>
<dt><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dt>
    <dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd>
    <dd>Oberpfaffenhofen</dd>
    <dd>Postfach 1116</dd>
    <dd>D-82230 Wessling</dd>
    <dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
<dt>Christian Kral</dt>

    <dd>  <a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
</dd>
    <dd>1060 Vienna, Austria</dd>
    <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a></dd>
<dt>Johan Andreasson</dt>
    <dd><a href=\"https://www.modelon.com/\">Modelon AB</a></dd>
    <dd>Ideon Science Park</dd>
    <dd>22370 Lund, Sweden</dd>
    <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>

<p>
版权所有&copy; 1998-2020，Modelica协会及其贡献者
</p>
</html>"));
  partial package Library 
    "This icon will be removed in future Modelica versions, use Package instead"
    extends Modelica.Icons.ObsoleteModel;
    annotation(Protection(hideFromBrowser=true), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {200, 200, 200}, 
      fillColor = {248, 248, 248}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0), 
      Rectangle(
      lineColor = {128, 128, 128}, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0)}), Documentation(info = "<html>
<p>This icon of a package will be removed in future versions of the library.</p>
<h5>Note</h5>
<p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Package\">Package</a> shall be used.</p>
</html>"  ), 
      obsolete = "Obsolete package - use Modelica.Icons.Package instead");
  end Library;
  partial package Library2 
    "This icon will be removed in future Modelica versions, use Package instead"
    extends Modelica.Icons.ObsoleteModel;

    annotation(Protection(hideFromBrowser=true), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {200, 200, 200}, 
      fillColor = {248, 248, 248}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0), 
      Rectangle(
      lineColor = {128, 128, 128}, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
      radius = 25.0)}), Documentation(info = "<html>
<p>This icon of a package will be removed in future versions of the library.</p>
<h5>Note</h5>
<p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Package\">Package</a> shall be used.</p></html>"  ), 
      obsolete = "Obsolete package - use Modelica.Icons.Package instead");
  end Library2;
  partial class GearIcon 
    "This icon will be removed in future Modelica versions"
    extends Modelica.Icons.ObsoleteModel;

    annotation(Protection(hideFromBrowser=true), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {64, 64, 64}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{-90.0, -10.0}, {-60.0, 10.0}}), 
      Polygon(
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      points = {{-60.0, 10.0}, {-60.0, 20.0}, {-40.0, 40.0}, {-40.0, -40.0}, {-60.0, -20.0}, {-60.0, 10.0}}), 
      Rectangle(
      lineColor = {64, 64, 64}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{-40.0, -60.0}, {40.0, 60.0}}, 
      radius = 10.0), 
      Polygon(
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      points = {{60.0, 20.0}, {40.0, 40.0}, {40.0, -40.0}, {60.0, -20.0}, {60.0, 20.0}}), 
      Rectangle(
      lineColor = {64, 64, 64}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{60.0, -10.0}, {90.0, 10.0}}), 
      Polygon(
      fillColor = {64, 64, 64}, 
      fillPattern = FillPattern.Solid, 
      points = {{-60.0, -90.0}, {-50.0, -90.0}, {-20.0, -30.0}, {20.0, -30.0}, {48.0, -90.0}, {60.0, -90.0}, {60.0, -100.0}, {-60.0, -100.0}, {-60.0, -90.0}})}), 
      Documentation(info = "<html>
<p>
This icon of a <strong>gearbox</strong> will be removed in future versions of the library. Please use one of the icons of <a href=\"modelica://Modelica.Mechanics.Rotational.Icons\">Mechanics.Rotational.Icons</a> instead.
</p>
</html>"  ), 
      obsolete = "Obsolete class - use Modelica.Mechanics.Rotational.Icons instead");
  end GearIcon;
  partial class MotorIcon 
    "This icon will be removed in future Modelica versions."
    extends Modelica.Icons.ObsoleteModel;

    annotation(Protection(hideFromBrowser=true), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
      Rectangle(
      lineColor = {82, 0, 2}, 
      fillColor = {252, 37, 57}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{-100.0, -50.0}, {30.0, 50.0}}, 
      radius = 10.0), 
      Polygon(
      fillColor = {64, 64, 64}, 
      fillPattern = FillPattern.Solid, 
      points = {{-100.0, -90.0}, {-90.0, -90.0}, {-60.0, -20.0}, {-10.0, -20.0}, {20.0, -90.0}, {30.0, -90.0}, {30.0, -100.0}, {-100.0, -100.0}, {-100.0, -90.0}}), 
      Rectangle(
      lineColor = {64, 64, 64}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.HorizontalCylinder, 
      extent = {{30.0, -10.0}, {90.0, 10.0}})}), 
      Documentation(info = "<html>
<p>
This icon of an <strong>electrical motor</strong> model will be removed in future versions of the library. Please use a locally defined icon in your user defined libraries and applications.
</p>
</html>"  ), 
      obsolete = "Obsolete class");
  end MotorIcon;
  partial class Info "This icon will be removed in future Modelica versions."
    extends Modelica.Icons.ObsoleteModel;
    annotation(Protection(hideFromBrowser=true), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
      Ellipse(
      lineColor = {75, 138, 73}, 
      fillColor = {75, 138, 73}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      Polygon(
      origin = {-4.167, -15.0}, 
      fillColor = {255, 255, 255}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      points = {{-15.833, 20.0}, {-15.833, 30.0}, {14.167, 40.0}, {24.167, 20.0}, {4.167, -30.0}, {14.167, -30.0}, {24.167, -30.0}, {24.167, -40.0}, {-5.833, -50.0}, {-15.833, -30.0}, {4.167, 20.0}, {-5.833, 20.0}}, 
      smooth = Smooth.Bezier), 
      Ellipse(
      origin = {7.5, 56.5}, 
      fillColor = {255, 255, 255}, 
      pattern = LinePattern.None, 
      fillPattern = FillPattern.Solid, 
      extent = {{-12.5, -12.5}, {12.5, 12.5}})}), 
      Documentation(info = "<html>
<p>This icon indicate classes containing only documentation, intended for general description of e.g., concepts and features of a package.</p>
<h5>Note</h5>
<p>This icon will be removed in future versions of the Modelica Standard Library. Instead the icon <a href=\"modelica://Modelica.Icons.Information\">Information</a> shall be used.</p></html>"  ), 
      obsolete = "Obsolete class - use Modelica.Icons.Information instead");
  end Info;
end Icons;