within Modelica.Utilities;
package Streams "读取文件和写入文件"
  extends Modelica.Icons.FunctionsPackage;

  impure function print "打印字符串到终端或文件"
    extends Modelica.Icons.Function;
    input String string="" "要打印的字符串";
    input String fileName="" 
      "要打印的文件(空字符串是终端)" 
                 annotation(Dialog(saveSelector(filter="Text files (*.txt)", 
                        caption="Text file to store the output of print(..)")));
  external "C" ModelicaInternal_print(string, fileName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Streams.<strong>print</strong>(string);
Streams.<strong>print</strong>(string,fileName);
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>print</strong>(..)自动打开给定的文件，如果
它还没有开放。如果文件不存在，则创建该文件。
如果该文件确实存在，则将给定的字符串追加到该文件。
如果不希望这样做，请在调用print之前调用\"Files.remove(fileName)\"
(\"remove(..)\"是沉默的，如果文件不存在)。
Modelica环境可以在适当的时候关闭文件。
这可以通过调用<strong>Streams.close</strong>(fileName)来实现。
每次调用“print(..)”后，都会自动打印“new line”。
</p>
<h4>例子</h4>
<blockquote><pre>
Streams.print(\"x = \" + String(x));
Streams.print(\"y = \" + String(y));
Streams.print(\"x = \" + String(y), \"mytestfile.txt\");
</pre></blockquote>
<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.error\">Streams.error</a>,
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>
</p>
</html>"  ));
  end print;

  function readFile 
    "读取文件的内容并以字符串向量的形式返回"
    extends Modelica.Icons.Function;
    input String fileName "要读取的文件的名称" 
                 annotation(Dialog(loadSelector(filter="Text files (*.txt)", 
                        caption="Open text file for reading")));
    output String stringVector[countLines(fileName)] "文件内容";
    external "C" ModelicaInternal_readFile(fileName,stringVector,size(stringVector,1)) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
stringVector = Streams.<strong>readFile</strong>(fileName)
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>readFile</strong>(..)打开给定文件，读取完整的
内容，关闭文件并以字符串向量的形式返回内容。行之间用LF或CR-LF分隔;返回的字符串不包含行分隔符。
注意，可以使用helper函数将fileName定义为URI
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.
</p>
</html>"  ));
  end readFile;

  function readLine "从文件中读取一行文本并以字符串形式返回"
    extends Modelica.Icons.Function;
    input String fileName "要读取的文件的名称" 
                        annotation(Dialog(loadSelector(filter="Text files (*.txt)", 
                        caption="Open text file for reading")));
    input Integer lineNumber(min=1) "要读取的行数";
    output String string "文本行";
    output Boolean endOfFile 
      "如果为true，则在尝试读取行时到达文件结束";
   external "C" string=  ModelicaInternal_readLine(fileName,lineNumber,endOfFile) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(string, endOfFile) = Streams.<strong>readLine</strong>(fileName, lineNumber)
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>readLine</strong>(..)打开给定文件，读取足够的
内容来获取所请求的行，并将该行作为字符串返回。
行之间用LF或CR-LF分隔;返回的字符串不会
包含行分隔符。之后文件可能保持打开状态
调用。
</p>
<p>
如果 lineNumber > countLines(fileName)，则返回空字符串，endOfFile=true。
则返回空字符串，endOfFile=true。否则，endOfFile=false。
</p>
</html>"  ));
  end readLine;

  function countLines "返回文件中的行数"
    extends Modelica.Icons.Function;
    input String fileName "要读取的文件的名称" 
                       annotation(Dialog(loadSelector(filter="Text files (*.txt)", 
                        caption="Open text file for counting lines")));

    output Integer numberOfLines "文件中的行数";
  external "C" numberOfLines=  ModelicaInternal_countLines(fileName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
numberOfLines = Streams.<strong>countLines</strong>(fileName)
</pre></blockquote>
<h4>说明</h4>
<p>
函数<strong>countLines</strong>(...)打开给定文件，读取完整的
内容，关闭文件并返回行数。行以
以 LF 或 CR-LF 分隔。
</p>
</html>"  ));
  end countLines;

  pure function error "打印错误信息并取消所有操作-以防出现不可恢复的错误"
    extends Modelica.Icons.Function;
    input String string "要打印到错误消息窗口的字符串";
    external "C" ModelicaError(string) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaUtilities.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Streams.<strong>error</strong>(string);
</pre></blockquote>
<h4>说明</h4>
<p>
如果出现不可恢复的错误(即，如果求解器无法从错误中恢复)，
打印字符串\"string\"作为错误消息并取消所有操作。
如果用(默认)<strong>AssertionLevel.error</strong>调用，该函数在语义上等同于内置函数<strong>assert</strong>。
换行符的特征是字符串中的\"\\n\"。
</p>
<h4>例子</h4>
<blockquote><pre>
Streams.error(\"x (= \" + String(x) + \")\\nhas to be in the range 0 .. 1\");
</pre></blockquote>
<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>,
<a href=\"modelica://Modelica.Utilities.Streams.print\">Streams.print</a>,
<a href=\"modelica://ModelicaReference.Operators.'assert()'\">ModelicaReference.Operators.'assert()'</a>
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>
</p>
</html>"  ));
  end error;

  impure function close "关闭文件"
    extends Modelica.Icons.Function;
    input String fileName "要关闭的文件名" 
                 annotation(Dialog(loadSelector(filter="Text files (*.txt)", 
                        caption="Close text file")));
    external "C" ModelicaStreams_closeFile(fileName) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Streams.<strong>close</strong>(fileName)
</pre></blockquote>
<h4>描述</h4>
<p>
关闭文件，如果它是打开的。忽略，调用if
文件已关闭或不存在。
</p>
</html>"  ));
  end close;

  function readMatrixSize "从MATLAB MAT文件中读取实矩阵的维度"
    extends Modelica.Icons.Function;
    input String fileName "存储外部数据的文件" annotation(Dialog(loadSelector(filter="MATLAB MAT files (*.mat)", caption="Open MATLAB MAT file")));
    input String matrixName "文件中2D Real数组的名称/标识符";
    output Integer dim[2] "2D Real数组的行数和列数";
    external "C" ModelicaIO_readMatrixSizes(fileName, matrixName, dim) 
    annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaIO.h\"", Library={"ModelicaIO", "ModelicaMatIO", "zlib"});
    annotation(Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
dim = Streams.<strong>readMatrixSize</strong>(fileName, matrixName)
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>readMatrixSize</strong>(..)打开给定的MATLAB MAT文件
(格式为v4、v6、v7，如果Modelica工具也支持HDF，格式为v7.3)，
并读取给定实数矩阵的维数。
这些维度在整数向量dim中返回。
</p>

<h4>例子</h4>
<p>
见 <a href=\"modelica://Modelica.Utilities.Examples.ReadRealMatrixFromFile\">Examples.ReadRealMatrixFromFile</a>.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>,
<a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>
</p>
</html>"  ));
  end readMatrixSize;

  function readRealMatrix "从MATLAB MAT文件中读取实矩阵"
    extends Modelica.Icons.Function;
    input String fileName "存储外部数据的文件" annotation(Dialog(loadSelector(filter="MATLAB MAT files (*.mat)", caption="Open MATLAB MAT file")));
    input String matrixName "文件中2D Real数组的名称/标识符";
    input Integer nrow "2D Real数组的行数";
    input Integer ncol "2D Real数组的列数";
    input Boolean verboseRead = true 
      "= true:打印信息消息;= false:无提示信息";
    output Real matrix[nrow, ncol] "二维实阵";
    external "C" ModelicaIO_readRealMatrix(fileName, matrixName, matrix, size(matrix, 1), size(matrix, 2), verboseRead) 
    annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaIO.h\"", Library={"ModelicaIO", "ModelicaMatIO", "zlib"});
    annotation(
  Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
matrix = Streams.<strong>readRealMatrix</strong>(fileName, matrixName, nrow, ncol, verboseRead)
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>readRealMatrix</strong>(..)打开给定的MATLAB MAT文件
(格式为v4、v6、v7，如果Modelica工具也支持HDF，格式为v7.3)，
并从这个文件中读取给定的矩阵。这个矩阵的维数必须先
询问功能
<a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>
并通过参数nrow和ncol传递给这个函数.
</p>

<h4>例子</h4>
<p>
见 <a href=\"modelica://Modelica.Utilities.Examples.ReadRealMatrixFromFile\">Examples.ReadRealMatrixFromFile</a>.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>,
<a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>
</p>
</html>"  ));
  end readRealMatrix;

  impure function writeRealMatrix "将实矩阵写入MATLAB MAT文件"
    extends Modelica.Icons.Function;
    input String fileName "存储外部数据的文件" annotation(Dialog(saveSelector(filter="MATLAB MAT files (*.mat)", caption="Save MATLAB MAT file")));
    input String matrixName "文件中2D Real数组的名称/标识符";
    input Real matrix[:,:] "二维实阵";
    input Boolean append = false "向文件追加值";
    input String format = "4" "MATLAB MAT文件版本: \"4\" -> v4, \"6\" -> v6, \"7\" -> v7" 
      annotation(choices(choice="4" "MATLAB v4 MAT file", 
                         choice="6" "MATLAB v6 MAT file", 
                         choice="7" "MATLAB v7 MAT file"));
    output Boolean success "成功则为真";
    external "C" success = ModelicaIO_writeRealMatrix(fileName, matrixName, matrix, size(matrix, 1), size(matrix, 2), append, format) 
    annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaIO.h\"", Library={"ModelicaIO", "ModelicaMatIO", "zlib"});
    annotation(Documentation(info="<html>

<h4>语法</h4>
<blockquote><pre>
success = Streams.<strong>writeRealMatrix</strong>(fileName, matrixName, matrix, append, format)
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>writeRealMatrix</strong>(..)将给定的矩阵写入新的或现有的MATLAB MAT文件
(格式为v4、v6、v7，如果Modelica工具支持HDF，也支持v7.3)。
如果<code>append = false</code> (= default)，则该文件是新创建的
(或者删除现有文件并重新创建)。
如果<code>append = true</code>，则矩阵包含在现有文件中
文件尚不存在，此标志被忽略。如果文件存在，则
<code>append = true</code>，参数格式被忽略。
</p>

<p>
参数<strong>format</strong>定义值在文件中存储的格式。
支持以下格式:<br>&nbsp;
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td>format = </td><td>Type of format</td></tr>
<tr><td>\"4\"  </td><td>MATLAB MAT version v4</td></tr>
<tr><td>\"6\"  </td><td>MATLAB MAT version v6</td></tr>
<tr><td>\"7\"  </td><td>MATLAB MAT version v7</td></tr>
<tr><td>\"7.3\"</td><td>MATLAB MAT version v7.3<br>
                    (需要Modelica工具支持HDF)</td></tr>
</table>

<p>
如果矩阵写入成功，函数返回<code>success = true</code>
文件。否则，打印一条错误消息，函数返回
<code>success = false</code>.
</p>

<h4>例子</h4>
<p>
见 <a href=\"modelica://Modelica.Utilities.Examples.WriteRealMatrixToFile\">Examples.WriteRealMatrixToFile</a>.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>,
<a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>
</p>
</html>"  ));
  end writeRealMatrix;
  annotation (
    Documentation(info="<html>
<h4>库的内容</h4>
<p>
包<strong>Streams</strong>包含输入和输出字符串的函数
到消息窗口或文件上，以及从文件中读取矩阵
将矩阵写入文件。注意，字符串是被解释的
并显示为HTML文本(例如，带有print(..)或error(..))
如果包含Modelica html引号，例如:
</p>
<blockquote><p>
string = \"&lt;html&gt; first line &lt;br&gt; second line &lt;/html&gt;\".
</p></blockquote>
<p>
是否支持html的所有标签是实现的质量问题
或者只是一个子集，(b)如果输出设备
不允许显示格式化的文本。
</p>
<p>
在下表中给出了对每个函数的调用示例:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string)<br>
          <a href=\"modelica://Modelica.Utilities.Streams.print\">print</a>(string,fileName)</td>
      <td> 打印字符串\"string\"或字符串向量到消息窗口或上
文件 \"fileName\".</td>
  </tr>
  <tr><td>stringVector =
         <a href=\"modelica://Modelica.Utilities.Streams.readFile\">readFile</a>(fileName)</td>
      <td> 读取完整的文本文件并将其作为字符串向量返回.</td>
  </tr>
  <tr><td>(string, endOfFile) =
         <a href=\"modelica://Modelica.Utilities.Streams.readLine\">readLine</a>(fileName, lineNumber)</td>
      <td>从文件中返回行lineNumber的内容.</td>
  </tr>
  <tr><td>lines =
         <a href=\"modelica://Modelica.Utilities.Streams.countLines\">countLines</a>(fileName)</td>
      <td>返回文件中的行数.</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.error\">error</a>(string)</td>
      <td> 将错误消息\"string\"打印到消息窗口
然后取消所有动作</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.close\">close</a>(fileName)</td>
      <td> 关闭文件，如果它仍然是打开的。忽略，调用if
文件已关闭或不存在. </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a>(fileName, matrixName)</td>
      <td> 从MATLAB MAT文件中读取实矩阵的维度. </td></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>(fileName, matrixName, nrow, ncol)</td>
      <td> 从MATLAB MAT文件中读取实矩阵. </td></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>(fileName, matrixName, matrix, append, format)</td>
      <td> 将实矩阵写入MATLAB MAT文件. </td></tr>
</table>
<p>
使用函数<strong>scanXXX</strong> from package
<a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
解析字符串。
</p>
<p>
如果要打印实数、整数或布尔值
或者在错误消息中使用时，必须首先转换它们
到带有内置操作符的字符串
<a href=\"modelica://ModelicaReference.Operators.'String()'\">ModelicaReference.Operators.'String()'</a>(...).
例子:
</p>
<blockquote><pre>
<strong>if</strong> x &lt; 0 <strong>or</strong> x &gt; 1 <strong>then</strong>
   Streams.error(\"x (= \" + String(x) + \") has to be in the range 0 .. 1\");
<strong>end if</strong>;
</pre></blockquote>
</html>"));
end Streams;