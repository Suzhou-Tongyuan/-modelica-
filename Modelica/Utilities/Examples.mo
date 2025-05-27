within Modelica.Utilities;
package Examples 
  "示例演示如何使用Modelica.Utilities"
  extends Modelica.Icons.ExamplesPackage;

  function calculator 
    "计算器，用于计算包含+、-、*、/、()、sin()、cos()、tan()、sqrt()、asin()、acos()、atan()、exp()、log()、pi的简单表达式"
    import Modelica.Utilities.Strings;
    extends Modelica.Icons.Function;
    input String string "被评估的表达式";
    output Real result "表达式的值";

  protected
    Integer nextIndex;
  algorithm
    (result,nextIndex) := expression(string, 1);
    Strings.scanNoToken(string,nextIndex);

    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
result = <strong>calculator</strong>(expression);
</pre></blockquote>
<h4>描述</h4>
<p>
该函数演示了如何使用Strings.scanToken(..)和Strings.scanDelimiter(..)函数，
以递归下降解析器的形式实现一个简单的表达式计算器。
</p>
<p>
支持以下操作(pi=3.14... 是预定义常数):
</p>
<blockquote><pre>
+, -
*, /
(expression)
sin(expression)
cos(expression)
tan(expression)
sqrt(expression)
asin(expression)
acos(expression)
atan(expression)
exp(expression)
log(expression)
pi
</pre></blockquote>
<h4>示例</h4>
<blockquote><pre>
calculator(\"2+3*(4-1)\");  // returns 11
calculator(\"sin(pi/6)\");  // returns 0.5
</pre></blockquote>
</html>"        ));
  end calculator;

  function expression 
    "表达式解释器，返回表达式后的当前位置(表达式可以包含 +、-、*、/、()、sin()、cos()、tan()、sqrt()、asin()、acos()、atan()、exp()、log()、pi)"
    import Modelica.Utilities.Types;
    import Modelica.Utilities.Strings;
    import Modelica.Math;
    import Modelica.Constants;

    extends Modelica.Icons.Function;
    input String string "被评估的表达式";
    input Integer startIndex = 1 
      "从字符 startIndex 开始扫描表达式";
    input String message = "" 
      "如果扫描不成功，错误信息中使用的信息";
    output Real result "表达的价值";
    output Integer nextIndex "扫描表达式后的索引";

  protected
    function term "评估表达式的项"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex;
      input String message = "";
      output Real result;
      output Integer nextIndex;
    protected
      Real result2;
      Boolean scanning = true;
      String opString;
      annotation();
    algorithm
      // 扫描 "primary * primary" 或 "primary / primary"
      (result,nextIndex) := primary(string, startIndex, message);
      while scanning loop
        (opString,nextIndex) := Strings.scanDelimiter(
          string, nextIndex, {"*", "/", ""}, message);
        if opString == "" then
          scanning := false;
        else
          (result2,nextIndex) := primary(string, nextIndex, message);
          result := if opString == "*" then result * result2 else result / result2;
        end if;
      end while;
    end term;

  public
    function primary "评估表达式的主项"
      extends Modelica.Icons.Function;

      input String string;
      input Integer startIndex;
      input String message = "";
      output Real result;
      output Integer nextIndex;
    protected
      Types.TokenValue token;
      Real result2;
      String delimiter;
      String functionName;
      Real pi = Constants.pi;
      annotation();
    algorithm
      (token,nextIndex) := Strings.scanToken(string, startIndex, unsigned = true);
      if token.tokenType == Types.TokenType.DelimiterToken and token.string == "(" then
        (result,nextIndex) := expression(string, nextIndex, message);
        (delimiter,nextIndex) := Strings.scanDelimiter(string, nextIndex, {")"}, message);

      elseif token.tokenType == Types.TokenType.RealToken then
        result := token.real;

      elseif token.tokenType == Types.TokenType.IntegerToken then
        result := token.integer;

      elseif token.tokenType == Types.TokenType.IdentifierToken then
        if token.string == "pi" then
          result := pi;
        else
          functionName := token.string;
          (delimiter,nextIndex) := Strings.scanDelimiter(string, nextIndex, {"("}, message);
          (result,nextIndex) := expression(string, nextIndex, message);
          (delimiter,nextIndex) := Strings.scanDelimiter(string, nextIndex, {")"}, message);
          if functionName == "sin" then
            result := Math.sin(result);
          elseif functionName == "cos" then
            result := Math.cos(result);
          elseif functionName == "tan" then
            result := Math.tan(result);
          elseif functionName == "sqrt" then
            if result < 0.0 then
              Strings.syntaxError(string, startIndex, "调用参数 \"sqrt(" + String(result) + ")\" 为负数.\n" + 
                "这个计算器不支持虚数.\n" + message);
            end if;
            result := sqrt(result);
          elseif functionName == "asin" then
            result := Math.asin(result);
          elseif functionName == "acos" then
            result := Math.acos(result);
          elseif functionName == "atan" then
            result := Math.atan(result);
          elseif functionName == "exp" then
            result := Math.exp(result);
          elseif functionName == "log" then
            if result <= 0.0 then
              Strings.syntaxError(string, startIndex, "调用参数 \"log(" + String(result) + ")\" 不是正数.\n" + message);
            end if;
            result := Math.log(result);
          else
            Strings.syntaxError(string, startIndex, "函数 \"" + functionName + "\" 未知（不支持）\n" + message);
          end if;
        end if;

      else
        Strings.syntaxError(string, startIndex, "表达式的主语无效.\n" + message);
      end if;
    end primary;

  protected
    Real result2;
    String signOfNumber;
    Boolean scanning = true;
    String opString;
  algorithm
    // 扫描可选的前导 "+" or "-" 标志
    (signOfNumber,nextIndex) := Strings.scanDelimiter(
      string, startIndex, {"+", "-", ""}, message);

    // 扫描 "term + term" 或 "term - term"
    (result,nextIndex) := term(string, nextIndex, message);
    if signOfNumber == "-" then
      result := -result;
    end if;

    while scanning loop
      (opString,nextIndex) := Strings.scanDelimiter(
        string, nextIndex, {"+", "-", ""}, message);
      if opString == "" then
        scanning := false;
      else
        (result2,nextIndex) := term(string, nextIndex, message);
        result := if opString == "+" then result + result2 else result - result2;
      end if;
    end while;

    annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
           result = <strong>expression</strong>(string);
(result, nextIndex) = <strong>expression</strong>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>说明</h4>
<p>
该函数几乎与Examples.<strong>calculator</strong>相同。
其主要区别在于函数\"expression\"可以用于其他解析操作：
在表达式被解析和计算后，函数返回表达式的值以及紧跟在表达式之后的字符位置。
</p>
<p>
该函数演示了如何使用递归下降解析器的形式实现一个简单的表达式计算器，
基本上是通过Strings.scanToken(..)和scanDelimiters(..)函数。
此函数包含两个局部函数(term和primary)，它们实现了语法中的相应部分。
</p>
<p>
支持如下操作(pi=3.14...是一个预定义的常量):
</p>
<blockquote><pre>
+, -
*, /
(expression)
sin(expression)
cos(expression)
tan(expression)
sqrt(expression)
asin(expression)
acos(expression)
atan(expression)
exp(expression)
log(expression)
pi
</pre></blockquote>
<p>
可选参数\"startIndex\"定义了从哪个位置开始扫描表达式。
</p>
<p>
如果发生错误，可选参数\"message\"会被附加到错误信息中，以便提供关于错误发生位置的更多信息。
</p>
<p>
该函数解析以下语法：
</p>
<blockquote><pre>
expression: [ add_op ] term { add_op term }
add_op    : \"+\" | \"-\"
term      : primary { mul_op primary }
mul_op    : \"*\" | \"/\"
primary   : UNSIGNED_NUMBER
          | pi
          | ( expression )
          | functionName( expression )
function  :   sin
          | cos
          | tan
          | sqrt
          | asin
          | acos
          | atan
          | exp
          | log
</pre></blockquote>
<p>
注意，在Examples.readRealParameter中展示了如何将expression函数作为另一个扫描操作的一部分使用。
</p>
<h4>示例</h4>
<blockquote><pre>
expression(\"2+3*(4-1)\");  // returns 11
expression(\"sin(pi/6)\");  // returns 0.5
</pre></blockquote>
</html>"    ));
  end expression;

  function readRealParameter "从文件中读取实型参数的值"
    extends Modelica.Icons.Function;
    input String fileName "文件名称" annotation(Dialog(
      loadSelector(filter = "Text files (*.txt)", 
      caption = "Open file in which Real parameters are present")));
    input String name "参数名称";
    output Real result "文件中参数的实际值";

  protected
    String line;
    String identifier;
    String delimiter;
    Integer nextIndex;
    Integer iline = 1;
    Types.TokenValue token;
    String message = "in file \"" + fileName + "\" on line ";
    String message2;
    Boolean found = false;
    Boolean endOfFile = false;
  algorithm
    (line,endOfFile) := Streams.readLine(fileName, iline);

    while not found and not endOfFile loop
      (token,nextIndex) := Strings.scanToken(line);
      if token.tokenType == Types.TokenType.NoToken then
        // 跳过一行
        iline := iline + 1;
      elseif token.tokenType == Types.TokenType.IdentifierToken then
        if token.string == name then
          // 找到名称，获取值 "name = value;"
          message2 := message + String(iline);
          (delimiter,nextIndex) := Strings.scanDelimiter(line, nextIndex, {"="}, message2);
          (result,nextIndex) := Examples.expression(line, nextIndex, message2);
          (delimiter,nextIndex) := Strings.scanDelimiter(line, nextIndex, {";", ""}, message2);
          Strings.scanNoToken(line, nextIndex, message2);
          found := true;
        else
          // 名字错了，跳线
          iline := iline + 1;
        end if;
      else
        // 错误的标记
        Strings.syntaxError(line, nextIndex, "将标识符 " + message + String(iline));
      end if;

      // 阅读下一行
      (line,endOfFile) := Streams.readLine(fileName, iline);
    end while;

    if not found then
      Streams.error("参数 \"" + name + "\" 文件中未找到 \"" + fileName + "\"");
    end if;
    annotation(Documentation(info = 
      "<html>
<h4>语法</h4>
<blockquote><pre>
result = <strong>readRealParameter</strong>(fileName, name);
</pre></blockquote>
<h4>描述</h4>
<p>
该函数演示了如何实现一个从文件中读取参数值的函数。该函数执行以下操作：
</p>
<ol>
<li> 打开文件\"fileName\"并读取文件中的每一行。</li>
<li> 在每一行中，跳过 Modelica 行注释(\"// ... end-of-line\")。</li>
<li> 如果某一行的格式为\"name = expression\"，且该行中的\"name\"与函数调用的第二个参数\"name\"相同，
则使用表达式计算器Examples.expression来计算\"=\"后面的表达式。表达式可以选择性地以\";\"结尾。</li>
<li> 表达式计算的结果将作为参数\"name\"的值返回。</li>
</ol>
<h4>示例</h4>
<p>
在文件\"test.txt\"中可能会出现以下几行:
</p>
<blockquote><pre>
// Motor data
J        = 2.3     // inertia
w_rel0   = 1.5*2;  // relative angular velocity
phi_rel0 = pi/3
</pre></blockquote>
<p>
当函数被调用时，它返回值\"3.0\"：
</p>
<blockquote><pre>
readRealParameter(\"test.txt\", \"w_rel0\")
</pre></blockquote>
</html>"        ));
  end readRealParameter;

  model readRealParameterModel 
    "演示Examples.readRealParameter/.expression的用法"

    extends Modelica.Icons.Example;

    parameter String file = Modelica.Utilities.Files.loadResource(
      "modelica://Modelica/Resources/Data/Utilities/Examples_readRealParameters.txt") 
      "存储数据的文件" 
      annotation(Dialog(loadSelector(filter = "Text files (*.txt)", 
      caption = "Open text file to read parameters of the form \"name = value\"")));
    parameter Modelica.Units.SI.Inertia J = readRealParameter(file, "J") 
      "惯性";
    parameter Modelica.Units.SI.Angle phi_rel0 = readRealParameter(file, "phi_rel0") 
      "相对的角";
    parameter Modelica.Units.SI.AngularVelocity w_rel0 = readRealParameter(file, "w_rel0") 
      "相对角速度";
  equation
    when terminal() then
      Streams.close(file);
    end when;

    annotation(preferredView = "text", Documentation(info = "<html>
<p>
展示如何使用Examples.readRealParameter和Examples.expression的模型。
该模型有三个参数，参数的值是从文件中读取的。
</p>
</html>"  ), experiment(StopTime = 1.01));
  end readRealParameterModel;

  model WriteRealMatrixToFile 
    "演示函数Streams.writeRealMatrix的用法"
    extends Modelica.Icons.Example;
    parameter Real A[3,2] = [11, 12;
      21, 22;
      31, 32] "矩阵以不同格式存储在文件中";
    output Boolean success1 "= 如果成功写入 Test_RealMatrix_v4.mat 则为 true";
    output Boolean success2 "= 如果向 Test_RealMatrix_v4.mat 追加成功，则为 true";
    output Boolean success3 "= 如果成功写入 Test_RealMatrix_v6.mat 则为 true";
    output Boolean success4 "= 如果成功写入 Test_RealMatrix_v7.mat 则为 true";
  algorithm
    when initial() then
      success1 := Modelica.Utilities.Streams.writeRealMatrix("Test_RealMatrix_v4.mat", "Matrix_A", A);
      success2 := Modelica.Utilities.Streams.writeRealMatrix("Test_RealMatrix_v4.mat", "Matrix_B", A, append = true, format = "4");
      success3 := Modelica.Utilities.Streams.writeRealMatrix("Test_RealMatrix_v6.mat", "Matrix_A", A, format = "6");
      success4 := Modelica.Utilities.Streams.writeRealMatrix("Test_RealMatrix_v7.mat", "Matrix_A", A, format = "7");
    end when;

    annotation(preferredView = "text", experiment(StopTime = 0.1), Documentation(info = "<html>
<p>
示例模型，演示如何使用函数
<a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>
将一个实数矩阵以MATLAB MAT格式写入文件。
</p>
</html>"    ));
  end WriteRealMatrixToFile;

  model ReadRealMatrixFromFile 
    "演示函数Streams.readRealMatrix的用法"
    import Modelica.Utilities.Streams.print;
    extends Modelica.Icons.Example;
    parameter String file = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v4.mat") "File name of matrix" 
      annotation(Dialog(loadSelector(filter="MATLAB MAT files (*.mat)", caption="Open MATLAB MAT file")));
    parameter String matrixName = "Matrix_A" "文件中的矩阵名称";
    final parameter Integer dim[2] = Modelica.Utilities.Streams.readMatrixSize(file,matrixName) "矩阵的维度";
    final parameter Real A[:,:] = Modelica.Utilities.Streams.readRealMatrix(file,matrixName,dim1[1],dim1[2]) "矩阵数据";

    final parameter String file1 = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v4.mat") "File name of check matrix 1";
    final parameter String file2 = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v6.mat") "File name of check matrix 2";
    final parameter String file3 = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Utilities/Test_RealMatrix_v7.mat") "File name of check matrix 3";
    final parameter String matrixName1 = "Matrix_A" "校验矩阵名称";
    final parameter Integer dim1[2] = Modelica.Utilities.Streams.readMatrixSize(file1,matrixName1) "校验矩阵尺寸1";
    final parameter Integer dim2[2] = Modelica.Utilities.Streams.readMatrixSize(file2,matrixName1) "校验矩阵尺寸2";
    final parameter Integer dim3[2] = Modelica.Utilities.Streams.readMatrixSize(file3,matrixName1) "校验矩阵尺寸3";
    final parameter Real A1[:,:] = Modelica.Utilities.Streams.readRealMatrix(file1,matrixName1,dim1[1],dim1[2]) "检查矩阵1的数据";
    final parameter Real A2[:,:] = Modelica.Utilities.Streams.readRealMatrix(file2,matrixName1,dim2[1],dim2[2]) "检查矩阵2的数据";
    final parameter Real A3[:,:] = Modelica.Utilities.Streams.readRealMatrix(file3,matrixName1,dim3[1],dim3[2]) "检查矩阵3的数据";
    Real x(start=1, fixed=true) "Dummy state";
  protected
    constant Real eps = 10* Modelica.Constants.eps;
  equation
    assert(abs(A1[1,1] - 11) <= eps, "Resources/Data/Utilities/Test_RealMatrix_v4.mat not correctly loaded");
    assert(abs(A2[1,1] - 11) <= eps, "Resources/Data/Utilities/Test_RealMatrix_v6.mat not correctly loaded");
    assert(abs(A3[1,1] - 11) <= eps, "Resources/Data/Utilities/Test_RealMatrix_v7.mat not correctly loaded");

    der(x) = -A[1,1]*x;
  algorithm
    when initial() then
       print("... Matrix " + matrixName + "[" + String(size(A,1)) + "," + String(size(A,2)) + "] read from file " + file);
       print("...    " + matrixName + "[1,1] = " + String(A[1,1]));
    end when;

    annotation(preferredView="text", experiment(StopTime=0.1), Documentation(info="<html>
<p>
示例模型，演示如何使用函数
<a href=\"modelica://Modelica.Utilities.Streams.readMatrixSize\">readMatrixSize</a> 和
<a href=\"modelica://Modelica.Utilities.Streams.readRealMatrix\">readRealMatrix</a>
从文件中读取MATLAB MAT格式的实数矩阵。
</p>
<p>
此外，从支持的文件格式中加载特定矩阵，并检查加载的矩阵是否具有预期的值。
</p>
</html>"        ));
  end ReadRealMatrixFromFile;
  annotation (Documentation(info="<html>
<p>
本软件包包含相当多的示例，演示如何使用
如何使用 Modelica.Utilities 包的功能。特别是
包含以下示例。
</p>
<ul>
<li> 函数<a href=\"modelica://Modelica.Utilities.Examples.calculator\">calculator</a>。
     是一个解释器，用于评估
     表达式的解释器 +,-,*,/,(),sin(), cos(), tan(), sqrt(), pi.
     For example: calculator(\"1.5*sin(pi/6)\");<br>&nbsp;</li>
<li> 函数<a href=\"modelica://Modelica.Utilities.Examples.expression\">expression</a>
     是用于评估表达式的基本函数。
     如果表达式解释器用于较大的
     扫描操作（如下面的 readRealParameter）中使用时非常有用。<br>&nbsp;</li>
<li> 函数 <a href=\"modelica://Modelica.Utilities.Examples.readRealParameter\">readRealParameter</a> 读取参数值。
     读取一个参数的值
     从文件中读取参数值。文件中的值
     用 Examples.expression 函数解释，因此可以是一个表达式。
     解释，因此可以是一个表达式。<br>&nbsp;</li>
<li> Model<a href=\"modelica://Modelica.Utilities.Examples.readRealParameterModel\">readRealParameterModel</a>
是一个测试模型，用于演示\"readRealParameter\"的用法。该模型
<a href=\"modelica://Modelica/Resources/Data/Utilities/Examples_readRealParameters.txt\">Examples_readRealParameters.txt</a>.<br>&nbsp;
     </li>
<li> Model <a href=\"modelica://Modelica.Utilities.Examples.WriteRealMatrixToFile\">WriteRealMatrixToFile</a>
演示了函数\"Streams.writeReaMatrix\"的用法。将矩阵以各种MATLAB MAT格式存储在文件中.<br>&nbsp;
     </li>
<li> Model <a href=\"modelica://Modelica.Utilities.Examples.ReadRealMatrixFromFile\">ReadRealMatrixFromFile</a>
演示了函数\"Streams. readMatrixSize\"和 \"Streams.readRealMatrix\"
从文件中读取各种MATLAB MAT格式的矩阵。
     </li>
</ul>
</html>"));
end Examples;