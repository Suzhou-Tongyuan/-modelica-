within Modelica.Mechanics.MultiBody.Visualizers.Colors;
function colorMapToSvg 
  "在SVG(可伸缩矢量图形)格式中保存颜色映射到文件"
  extends Modelica.Icons.Function;
  encapsulated type HeaderType = enumeration(
    svgBeginAndEnd, 
    svgBegin, 
    svgEnd, 
    noHeader) annotation();
  import Modelica.Utilities.Streams.print;
  input Real colorMap[:,3] "要以SVG格式存储的颜色映射" 
    annotation(choices(choice = Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.jet(), 
    choice = Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.hot(), 
    choice = Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.gray(), 
    choice = Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.spring(), 
    choice = Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.summer(), 
    choice = Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.autumn(), 
    choice = Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps.winter()));
  input String fileName = "colorMap.svg" 
    "SVG表示将要存储的文件名";
  input Real width(unit = "mm") = 10 "SVG图形中的宽度";
  input Real height(unit = "mm") = 100 "SVG图形中的高度";
  input Real x(unit = "mm") = 20 "左上角的X坐标";
  input Real y(unit = "mm") = 10 "左上角的Y坐标";
  input Real T_min = 0 "与colorMap[1,:]对应的标量值";
  input Real T_max = 100 "与colorMap[end,:]对应的标量值";
  input Integer nScalars = 11 
    "在右侧显示的标量数量";
  input String format = ".3g" "数字的格式";
  input Real fontSize = 11 "字体大小[pt]";
  input Real textWidth(unit = "mm") = 8 
    "从x+width+textWidth开始右对齐数字";
  input String caption = "" "地图上方的标题";
  input HeaderType headerType = Colors.colorMapToSvg.HeaderType.svgBeginAndEnd 
    "头部类型";
protected
  Integer nc = size(colorMap, 1);
  Real dy = height / nc;
  Real yy = y - dy;
  String strWidth = String(width);
  String strHeight = String(dy);
  Real T;
  Integer ni;
  constant Real ptToMm = 127 / 360 "1Point=ptToMmmm";
  Real fontHeight(unit = "mm") = fontSize * ptToMm;
  Real xx = x + width + textWidth;
  String strXX = String(xx);
  Real xHeading = x + width / 2;
  Real yHeading = y - 1.2 * fontHeight;
algorithm
  if headerType == HeaderType.svgBeginAndEnd or 
    headerType == HeaderType.svgBegin then
    Modelica.Utilities.Files.remove(fileName);
    print("...生成SVG文件:" + Modelica.Utilities.Files.fullPathName(fileName));
  end if;
  if caption <> "" then
    print("..." + caption);
  end if;

  if headerType == HeaderType.svgBeginAndEnd or 
    headerType == HeaderType.svgBegin then
    print("<svgxmlns=\"http://www.w3.org/2000/svg\">", fileName);
  end if;

  print("<g>", fileName);

  // Print colors
  for i in nc:-1:1 loop
    // print:  <rect x="XXmm" y="XXmm" width="YYmm" height="ZZmm" style="fill:rgb(100,128,255);stroke:none"/>
    yy := yy + dy;
    print("<rectx=\"" + String(x) + 
      "mm\"y=\"" + String(yy) + 
      "mm\"width=\"" + strWidth + 
      "mm\"height=\"" + strHeight + 
      "mm\"style=\"fill:rgb(" + String(integer(colorMap[i,1])) + "," 
      + String(integer(colorMap[i,2])) + "," 
      + String(integer(colorMap[i,3])) + 
      ");stroke:none\"/>", fileName);
  end for;

  // Print numbers
  ni := if nScalars == 1 then 2 else if nScalars < 1 then 
    0 else nScalars;
  dy := height / (ni - 1);
  yy := y - dy + 0.3 * fontHeight;
  for i in ni:-1:1 loop
    // print: <text x="22mm" y="12mm" font-family="Arial,sans-ser如果" font-size="11pt">1.2345</text>
    yy := yy + dy;
    T := T_min + (T_max - T_min) * (i - 1) / (ni - 1);
    print("<textx=\"" + strXX + 
      "mm\"y=\"" + String(yy) + 
      "mm\"font-family=\"Fixedsys\"font-size=\"" + String(fontSize) + 
      "pt\"text-anchor=\"end\">" + String(T, format = format) + 
      "</text>", fileName);
  end for;

  if caption <> "" then
    print("<textx=\"" + String(xHeading) + 
      "mm\"y=\"" + String(yHeading) + 
      "mm\"font-family=\"Fixedsys\"font-size=\"" + String(fontSize) + 
      "pt\"text-anchor=\"middle\">" + caption + 
      "</text>", fileName);
  end if;

  print("</g>", fileName);

  if headerType == HeaderType.svgBeginAndEnd or 
    headerType == HeaderType.svgEnd then
    print("</svg>", fileName);
  end if;
  annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Colors.<strong>colorMapToSvg</strong>(colorMap);
Colors.<strong>colorMapToSvg</strong>(colorMap,
fileName=\"colorMap.svg\",
width=10,//[mm]
height=100,//[mm]
x=20,//[mm]
y=10,//[mm]
T_min=0,
T_max=100,
nScalars=11,
format=\".3g\",
fontSize=11,//[pt]
textWidth=8,//[mm]
caption=\"\",
headerType=Colors.colorMapToSvg.Header.svgBeginAndEnd)
//svgBegin
//svgEnd
//svgNoHeader
</pre></blockquote>
<h4>描述</h4>
<p>
此函数将颜色映射\"Real colorMap[:,3]\"保存到文件\"fileName\"中，格式为svg。
颜色映射的宽度为\"width\"，高度为\"height\"，左上角位于坐标\"(x,y)\"处。
在颜色映射上方放置了标题\"caption\"。
在颜色映射的右侧，显示了一组标量场值T，其中\"T_min\"放置在colorMap[1,:]处，\"T_max\"放置在colorMap[end,:]处，显示介于\"T_min\"和\"T_max\"之间的\"nScalars\"个值(包括T_min和T_max)。
数字的打印格式由\"format\"定义，见下面的定义。
使用参数\"headerType\"可定义是否打印\"svg\"开始和结束行。
如果要打印\"begin\"svg标记，则删除文件\"fileName\"(如果已存在)。
否则，所有输出都将附加到文件\"fileName\"中。
</p>

<p>
\"svg\"文件可以通过Web浏览器(如<a href=\"http://www.mozilla.org/firefox\">Firefox</a>)来显示，只需将文件拖放到浏览器窗口中。
或者，可以在图形程序中加载svg文件，如免费的<a href=\"http://inkscape.org\">Inkscape</a>，进行操作，并将其导出为其他图形格式。
下面的图像是通过调用\"colorMapToSvg\"生成的，生成的文件已加载到Inkscape中，并以\"png\"格式导出：</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/ColorMaps/jet.png\">
</blockquote>

<p>
\"format\"参数根据ANSI-C定义了字符串格式，不包含\"%\"和\"*\"字符<br>(例如，\".6g\"、\"14.5e\"、\"+6f\")。
具体为：</p>

<p>
format=\"[&lt;flags&gt;] [&lt;width&gt;] [.&lt;precision&gt;] &lt;conversion&gt;\"其中</p>

<blockquote>
<table>
<tr>
<td>&lt;flags&gt;</td>
<td>一个或多个以下标志：<br>
\"-\":将转换后的数字左对齐<br>
\"+\":数字将始终带有符号<br>
\"0\":使用前导零填充字段宽度</td></tr>
<tr>
<td>&lt;width&gt;</td>
<td>最小字段宽度。
转换后的数字将在此宽度及更宽处打印。
如果转换后的数字<br>
字符较少，则会在左边(或右边，取决于&lt;flags&gt;)用空格或0(取决于&lt;flags&gt;)进行填充。
</td></tr>
<tr>
<td>&lt;precision&gt;</td>
<td>对于e、E或f转换，要打印的小数点后的位数，或者对于g或G转换，要打印的有效数字位数。
</td></tr>
<tr>
<td>&lt;conversion&gt;</td>
<td>=\"e\":以小写e进行指数表示<br>
=\"E\":以大写E进行指数表示<br>
=\"f\":固定点表示<br>
=\"g\":\"e\"或\"f\"<br>
=\"G\":与\"g\"相同，但使用大写E</td></tr>
</table>
</blockquote>
</html>"));
end colorMapToSvg;