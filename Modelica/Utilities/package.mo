within Modelica;
package Utilities "专用于脚本编写的实用函数库(对文件、流、字符串、系统进行操作)"
  extends Modelica.Icons.UtilitiesPackage;

package UsersGuide "实用程序库的用户指南"
  extends Modelica.Icons.Information;

  class ImplementationNotes "实现说明"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>
以下是本库的主要设计决策总结。
</p>
<ul>
<li> <strong>C-函数接口</strong><br>
     本库包含多个与C函数的接口，用于与环境交互。正如所明确的，通常要求Modelica工具供应商提供适用于其环境的C函数实现。
     在目录\"Modelica/Resources/C-Sources\"中，提供了适用于Microsoft Windows系统和POSIX环境的参考实现。
     文件\"ModelicaInternal.c\"和\"ModelicaStrings.c\"可作为在供应商环境中集成的基础。<br>&nbsp;</li>
<li> <strong>字符编码</strong><br>
     操作系统中字符的表示方式不同。
     例如，现代的操作系统（如Windows-NT）使用早期版本的Unicode（每个字符16位），
     而其他操作系统（如Windows-ME）使用8位编码。此外，还存在32位字符和多字节表示方式。这一点很重要，
     例如，日本的Modelica用户需要Unicode表示。本库的设计方式是，通过一组基本的操作系统调用来隐藏实际的字符表示。
     这意味着本包的所有功能都可以独立于底层字符表示进行使用。<br>
     Modelica语言的C接口仅提供8位字符编码的字符串传递机制。因此，\"Modelica.Utilities\\C-Source\"中的参考实现
     需要根据Modelica供应商环境支持的字符表示进行适配。<br>&nbsp;</li>
<li> <strong>内部字符串表示</strong><br>
     本包的设计旨在使字符串处理更加方便。这与C语言不同，C语言中的字符串处理不方便、繁琐且容易出错，
     但从某种意义上来说是“高效”的。
     \"Modelica.Utilities\\C-Source\"中的标准参考实现基于C语言标准的字符串定义，即指向一系列字符的指针，以
     null终止字符结束。为了使本包中的字符串处理更加方便，做了一些假设，特别是访问子字符串时的效率（O(1)
     访问，而不是C语言中的O(n)）。这使得字符串指针运算对用户是隐藏的。
     在这种情况下，对于大多数高阶操作（如查找、排序、替换），可以预期达到类似C语言中的效率。
     如果字符数存储在字符串中，并且字符长度是固定的（例如16位或32位，如果所有Unicode字符都需要表示），
     则可以实现“高效的字符访问”。供应商应根据这一点适配参考实现。<br>&nbsp;</li>
<li> <strong>字符串复制 = 指针复制</strong><br>
     Modelica语言没有改变字符串中字符的机制。当需要修改字符串时，唯一的方法是重新生成它。
     优势在于，Modelica工具可以将字符串视为常量实体，并可以通过指针复制操作替代（昂贵的）字符串复制操作。
     例如，在对一组字符串进行排序时，会发生以下类型的操作：
     <blockquote><pre>
String s[:], s_temp;
 ...
s_temp := s[i];
s[i]   := s[j];
s[j]   := s_temp;
     </pre></blockquote>
     从形式上看，复制了三个字符串。由于上述功能，Modelica工具可以通过指针赋值来替代该复制操作，这是一种“廉价”的操作。
     如果工具支持这种优化，Modelica.Utilities函数将高效地执行。
</li>
</ul>
</html>"  ));
  end ImplementationNotes;

  class ReleaseNotes "发布说明"
    extends Modelica.Icons.ReleaseNotes;

    annotation (Documentation(info="<html>
<h4>Version 1.0, 2004-09-29</h4>
<p>
第一个版本实现。
</p>
</html>"  ));
  end ReleaseNotes;

  class Contact "联系方式"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<h4>库管理员</h4>

<p>
<a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a><br>
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e.V. (DLR)<br>
Institut f&uuml;r Systemdynamik und Regelungstechnik (DLR-SR)<br>
Forschungszentrum Oberpfaffenhofen<br>
D-82234 Wessling<br>
Germany
</p>

<p>
<strong>Hans Olsson</strong><br>
Dassault Syst&egrave;mes AB, Lund, Sweden
</p>

<h4>主要作者</h4>

<p>
<strong>Dag Br&uuml;ck</strong><br>
Dassault Syst&egrave;mes AB, Lund, Sweden.<br>
email: <a href=\"mailto:Dag.Bruck@3ds.com\">Dag.Bruck@3ds.com</a>
</p>

<h4>致谢</h4>

<ul>
<li> 该库的设计者包括：<br>
     <blockquote>
     Dag Br&uuml;ck, Dassault Syst&egrave;mes AB, Sweden<br>
     Hilding Elmqvist, previously at Dassault Syst&egrave;mes AB, Sweden<br>
     Hans Olsson, Dassault Syst&egrave;mes AB, Sweden<br>
     Martin Otter, DLR Oberpfaffenhofen, Germany.
     </blockquote></li>
<li> 该库包括 C 语言的参考由Martin Otter和Dag Br&uuml;ck实现。</li>
<li> 使用该库实现计算器的 Examples.calculator 示例来自 Hilding Elmqvist.</li>
<li> 感谢瑞典 Link&ouml;ping PELAB 的 Kaj Nystr&ouml;m 提出的有益意见、
     以及对在维也纳、Link&ouml;ping 和德累斯顿举行的第 34、36 和 40 届 Modelica 设计会议上的讨论表示感谢。</li>
</ul>
</html>"      ));
  end Contact;

annotation (DocumentationClass=true, Documentation(info="<html>
<p>
<strong>Modelica.Utilities</strong>库包含特别适用于<strong>脚本编程</strong>的Modelica<strong>函数</strong>。
目前，只有一个初步的用户指南，该指南将在下一个版本中改进。
当前用户指南包括以下章节：
</p>
<ol>
<li>
<a href=\"modelica://Modelica.Utilities.UsersGuide.ReleaseNotes\">发布说明</a>
  总结了该库不同版本之间的差异。
</li>
<li>
<a href=\"modelica://Modelica.Utilities.UsersGuide.ImplementationNotes\">实现说明</a>
  描述了该库的设计决策，特别是针对Modelica工具供应商。
</li>
<li>
<a href=\"modelica://Modelica.Utilities.UsersGuide.Contact\">联系方式</a> 提供了该库作者的信息以及致谢部分。
</li>
</ol>
<p>
<strong>错误处理</strong><br>
如果发生错误，该库中的所有函数使用Modelica的\"assert(..)\"提供错误信息并取消所有操作。
这意味着，如果函数内部触发错误，函数将不会返回。
</p>
</html>"));
end UsersGuide;
    annotation (
Documentation(info="<html>
<p>
这个包包含Modelica<strong>函数</strong>，特别适合<strong>脚本编写</strong>。
函数可能用于处理字符串，从文件中读取数据，写入数据到文件或复制、移动和删除文件。
</p>
<p>
作为介绍，你可以特别看看:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.UsersGuide\">Modelica.Utilities.User's Guide</a>
     讨论这个库的最重要的方面。</li>
<li> <a href=\"modelica://Modelica.Utilities.Examples\">Modelica.Utilities.Examples</a>
     包含演示此库用法的示例。</li>
</ul>
<p>
以下主要子库是可用的：
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.Files\">Files</a>
     提供对文件和目录进行操作的函数，例如：复制、移动、删除文件。</li>
<li> <a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>
     提供从文件中读取和写入文件的函数。</li>
<li> <a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
     提供对字符串进行操作的函数。例如：substring、find、replace、sort、scanToken。</li>
<li> <a href=\"modelica://Modelica.Utilities.System\">System</a>
     提供与环境交互的函数。例如，获取或设置工作目录或环境变量和向默认shell发送命令。</li>
</ul>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"));
end Utilities;