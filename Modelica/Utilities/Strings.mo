within Modelica.Utilities;
package Strings "字符串操作"
  extends Modelica.Icons.FunctionsPackage;

  pure function length "返回字符串长度"
    extends Modelica.Icons.Function;
    input String string;
    output Integer result "字符串的字符数";
  external "C" result = ModelicaStrings_length(string) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Strings.<strong>length</strong>(string);
</pre></blockquote>
<h4>描述</h4>
<p>
返回\"string\"的字符数。
</p>
</html>"  ));
  end length;

  pure function substring "返回由开始和结束索引定义的子字符串"
    extends Modelica.Icons.Function;
    input String string "从其中查询子字符串的字符串";
    input Integer startIndex(min=1) 
      "子字符串的字符位置begin (index=1是字符串中的第一个字符)";
    input Integer endIndex(min=1) "子字符串结束的字符位置";
    output String result 
      "包含子字符串的字符串[startIndex:endIndex]";
  external "C" result = ModelicaStrings_substring(string,startIndex,endIndex) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
string2 = Strings.<strong>substring</strong>(string, startIndex, endIndex);
</pre></blockquote>
<h4>描述</h4>
<p>
这个函数返回
从位置startIndex的子字符串
到并包括位置endIndex \"string\" .
</p>
<p>
如果index、startIndex或endIndex不正确，例如:
if endIndex &gt;长度(字符串)，触发一个断言。
</p>
<h4>例子</h4>
<blockquote><pre>
string1 := \"This is line 111\";
string2 := Strings.substring(string1,9,12); // string2 = \"line\"
</pre></blockquote>
</html>"  ));
  end substring;

  function repeat "重复一个字符串n次"
    extends Modelica.Icons.Function;
    input Integer n(min=0) = 1 "出现次数";
    input String string=" " "重复的字符串";
    output String repeatedString "包含n个连接字符串的字符串";
  algorithm
    repeatedString :="";
    for i in 1:n loop
       repeatedString := repeatedString + string;
    end for;
    annotation (
  Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
string2 = Strings.<strong>repeat</strong>(n);
string2 = Strings.<strong>repeat</strong>(n, string=\" \");
</pre></blockquote>
<h4>描述</h4>
<p>
第一种形式返回一个由n个空格组成的字符串。
</p>
<p>
第二种形式返回一个由n个子字符串组成的字符串
由可选参数\"string\"定义.
</p>
</html>"  ));
  end repeat;

  pure function compare "按字典顺序比较两个字符串"
    extends Modelica.Icons.Function;
    input String string1;
    input String string2;
    input Boolean caseSensitive=true "= False，如果忽略字母大小写";
    output Modelica.Utilities.Types.Compare result "比较结果";
  external "C" result = ModelicaStrings_compare(string1, string2, caseSensitive) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
result = Strings.<strong>compare</strong>(string1, string2);
result = Strings.<strong>compare</strong>(string1, string2, caseSensitive=true);
</pre></blockquote>
<h4>描述</h4>
<p>
比较两个字符串。如果可选参数casessensitive =false，
大写字母将被视为小写字母。
比较的结果返回为:
</p>
<blockquote><pre>
result = Modelica.Utilities.Types.Compare.Less     // string1 &lt; string2
     = Modelica.Utilities.Types.Compare.Equal    // string1 = string2
     = Modelica.Utilities.Types.Compare.Greater  // string1 &gt; string2
</pre></blockquote>
<p>
比较是关于字典顺序的,
e.g., \"a\" &lt; \"b\";
</p>
</html>"  ));
  end compare;

  function isEqual "确定两个字符串是否相同"
    extends Modelica.Icons.Function;
    input String string1;
    input String string2;
    input Boolean caseSensitive=true 
      "= 如果在比较中忽略小写和大写，则为False";
    output Boolean identical "如果string1与string2相同，则为True";
  algorithm
    identical :=compare(string1, string2, caseSensitive) == Types.Compare.Equal;
    annotation (
  Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Strings.<strong>isEqual</strong>(string1, string2);
Strings.<strong>isEqual</strong>(string1, string2, caseSensitive=true);
</pre></blockquote>
<h4>描述</h4>
<p>
比较两个字符串是否相同，
可选忽略大小写.
</p>
</html>"  ));
  end isEqual;

  function isEmpty 
    "如果字符串为空(只有空白字符)则返回true"
    extends Modelica.Icons.Function;
    input String string;
    output Boolean result "True，如果字符串为空";
  protected
    Integer nextIndex;
    Integer len;
  algorithm
    nextIndex := Strings.Advanced.skipWhiteSpace(string);
    len := Strings.length(string);
    if len < 1 or nextIndex > len then
      result := true;
    else
      result := false;
    end if;

    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Strings.<strong>isEmpty</strong>(string);
</pre></blockquote>
<h4>描述</h4>
<p>
如果字符串没有字符，或者字符串包含字符，则返回true
只有空白字符。否则，返回false。
</p>

<h4>例子</h4>
<blockquote><pre>
isEmpty(\"\");       // returns true
isEmpty(\"   \");    // returns true
isEmpty(\"  abc\");  // returns false
isEmpty(\"a\");      // returns false
</pre></blockquote>
</html>"  ));
  end isEmpty;

  function count "计算字符串不重叠出现的次数"
    extends Modelica.Icons.Function;
    input String string "被分析的字符串";
    input String searchString "在String中搜索的字符串";
    input Integer startIndex(min=1)=1 "从索引startIndex开始搜索";
    input Boolean caseSensitive=true 
      "= False，如果计数忽略小写和大写";
    output Integer result "'searchString'在'string'中出现的次数";
  protected
    Integer lenSearchString = length(searchString);
    Integer i = startIndex;
  algorithm
    result := 0;
    while i <> 0 loop
       i := find(string, searchString, i, caseSensitive);
       if i > 0 then
          result := result + 1;
          i := i + lenSearchString;
       end if;
    end while;
    annotation (
  Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Strings.<strong>count</strong>(string, searchString)
Strings.<strong>count</strong>(string, searchString, startIndex=1,
                   caseSensitive=true)
</pre></blockquote>
<h4>描述</h4>
<p>
返回字符串\"searchString\"不重叠出现的次数。
在\"string\"。搜索从索引\"startIndex\"(默认值= 1)开始。
如果可选参数\"caseSensitive\"为false，
对于计数来说，字母是否在上方并不重要
或者小写。
</p>
</html>"  ));
  end count;

  function find "查找一个字符串在另一个字符串中的第一次出现"
    extends Modelica.Icons.Function;
    input String string "被分析的字符串";
    input String searchString "在String中搜索的字符串";
    input Integer startIndex(min=1)=1 "从索引startIndex开始搜索";
    input Boolean caseSensitive=true 
      "= False，如果在搜索中忽略小写和大写";
     output Integer index 
      "'searchString'在'string'中第一次出现的开头的索引，如果不存在则为零";
  protected
    Integer lengthSearchString = length(searchString);
    Integer len = lengthSearchString-1;
    Integer i = startIndex;
    Integer i_max = length(string) - lengthSearchString + 1;
  algorithm
    index := 0;
    while i <= i_max loop
       if isEqual(substring(string,i,i+len), 
                  searchString, caseSensitive) then
          index := i;
          i := i_max + 1;
       else
          i := i+1;
       end if;
    end while;
    annotation (
  Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
index = Strings.<strong>find</strong>(string, searchString);
index = Strings.<strong>find</strong>(string, searchString, startIndex=1,
                   caseSensitive=true);
</pre></blockquote>
<h4>描述</h4>
<p>
查找\"string\"中第一个出现的\"searchString\"
并返回相应的索引。
从索引\"startIndex\"开始搜索(默认值= 1)。
如果可选参数\"caseSensitive\"为false，则降低
和大写字母在搜索中被忽略。
如果没有找到\"searchString\"，则返回值\"0\"。
</p>
</html>"  ));
  end find;

  function findLast "查找一个字符串在另一个字符串中的最后一次出现"
    extends Modelica.Icons.Function;
    input String string "被分析的字符串";
    input String searchString "在String中搜索的字符串";
    input Integer startIndex(min=0)=0 
      "从索引startIndex开始搜索。如果startIndex = 0，从长度(字符串)开始";
    input Boolean caseSensitive=true 
      "= False，如果在搜索中忽略小写和大写";
    output Integer index 
      "'searchString'最后一次出现在'string'中的开头的索引，如果不存在则为零";
  protected
    Integer lenString = length(string);
    Integer lenSearchString = length(searchString);
    Integer iMax=lenString - lenSearchString + 1;
    Integer i;
  algorithm
    i := if startIndex == 0 or startIndex > iMax then iMax else startIndex;
    index := 0;
    while i >= 1 loop
       if isEqual(substring(string,i,i+lenSearchString-1), 
                  searchString, caseSensitive) then
          index := i;
          i := 0;
       else
          i := i-1;
       end if;
    end while;
    annotation (
  Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
index = Strings.<strong>findLast</strong>(string, searchString);
index = Strings.<strong>findLast</strong>(string, searchString,
                       startIndex=length(string), caseSensitive=true,
</pre></blockquote>
<h4>描述</h4>
<p>
查找\"string\"中第一个出现的\"searchString\"
当从\"string\"的最后一个字符开始搜索时
向后，并返回相应的索引。
开始搜索索引\"startIndex\"(默认= 0;
如果startIndex = 0，则从长度(字符串)开始搜索。
如果可选参数\"caseSensitive\"为false，则降低
和大写字母在搜索中被忽略。
如果没有找到\"searchString\"，则返回值\"0\"。
</p>
</html>"  ));
  end findLast;

  function replace 
    "从左到右替换不重叠的字符串"
    extends Modelica.Icons.Function;
    input String string "要修改的字符串";
    input String searchString 
      "用'replaceString'替换'string'中不重叠的'searchString'";
    input String replaceString 
      "替换' String'中的'searchString'的字符串";
    input Integer startIndex=1 "Start search at index startIndex";
    input Boolean replaceAll=true 
      "= False，如果只替换第一个出现项，否则替换所有出现项";
    input Boolean caseSensitive=true 
      "= false，如果在搜索searchString时忽略小写和大写";
    output String result "替换操作的结果字符串";
  protected
    Integer lenString = length(string);
    Integer lenSearchString = length(searchString);
    Integer i = startIndex;
    Integer i_found;
  algorithm
    result := if startIndex == 1 then "" else substring(string,1,startIndex-1);
    while i > 0 loop
       i_found := find(string, searchString, i, caseSensitive);
       if i_found > 0 then
          result := if i_found == 1 then 
                       replaceString else 
                       result + (if i_found-1<i then "" else substring(string, i, i_found-1)) + replaceString;
          i := i_found + lenSearchString;
          if i > lenString then
             i := 0;
          elseif not replaceAll then
             result := result + substring(string, i, lenString);
             i := 0;
          end if;
       elseif lenString<i then
          i := 0;
       else
          result := result + substring(string, i, lenString);
          i := 0;
       end if;
    end while;
    annotation (
  Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Strings.<strong>replace</strong>(string, searchString, replaceString);
Strings.<strong>replace</strong>(string, searchString, replaceString,
              startIndex=1, replaceAll=true, caseSensitive=true);
</pre></blockquote>
<h4>描述</h4>
<p>
在\"string\"中搜索\"searchString\"并替换找到的
子字符串由\"replaceString\".
</p>
<ul>
<li> 搜索从\"string\"的第一个字符开始，
或在字符位置\"startIndex\"，
如果提供了此可选参数。</li>
<li> I如果可选参数\"replaceAll\"为<strong>true</strong>(默认值)，
所有出现的\"searchString\"都会被替换。
如果参数为<strong>false</strong>，只出现第一次
被替换。</li>
<li> 搜索\"searchString\"区分大小写
信件。如果可选参数\"caseSensitive\"为
<strong>false</strong>,
搜索忽略字母是否大写
或者小写。</li>
</ul>
<p>
函数返回\"string\"和
进行更换。
</p>
</html>"  ));
  end replace;

  function sort "按字母顺序排序字符串向量"
    extends Modelica.Icons.Function;
    input String stringVector1[:] "字符串向量";
    input Boolean caseSensitive=true 
      "= false，如果在比较stringVector1的元素时忽略小写和大写";
    output String stringVector2[size(stringVector1,1)] 
      "按字母顺序排序的stringVector1";
    /* shellsort算法;应该在以后改进 */
  protected
    Integer gap;
    Integer i;
    Integer j;
    String tempString;
    Integer nStringVector1 = size(stringVector1,1);
    Boolean swap;
  algorithm
    stringVector2 := stringVector1;
    gap := div(nStringVector1,2);

    while gap > 0 loop
       i := gap;
       while i < nStringVector1 loop
          j := i-gap;
          if j >= 0 then
             swap := compare(stringVector2[j+1], stringVector2[j+gap+1], caseSensitive) 
                     == Modelica.Utilities.Types.Compare.Greater;
          else
             swap := false;
          end if;

          while swap loop
             tempString := stringVector2[j+1];
             stringVector2[j+1] := stringVector2[j+gap+1];
             stringVector2[j+gap+1] := tempString;
             j := j - gap;
             if j >= 0 then
                swap := compare(stringVector2[j+1], stringVector2[j+gap+1], caseSensitive) 
                        == Modelica.Utilities.Types.Compare.Greater;
             else
                swap := false;
             end if;
          end while;
          i := i + 1;
       end while;
       gap := div(gap,2);
    end while;

    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
stringVector2 = Streams.<strong>sort</strong>(stringVector1);
stringVector2 = Streams.<strong>sort</strong>(stringVector1, caseSensitive=true);
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>sort</strong>(…)对字符串向量stringVector1进行排序
按字典顺序排列，并以stringVector2的形式返回结果。
如果可选参数\"caseSensitive\"为<strong>false</strong>，则降低
大写字母不区分。
</p>
<h4>例子</h4>
<blockquote><pre>
s1 = {\"force\", \"angle\", \"pressure\"};
s2 = Strings.sort(s1);
   -> s2 = {\"angle\", \"force\", \"pressure\"};
</pre></blockquote>
</html>"  ));
  end sort;

  pure function hashString "创建字符串的散列值"
    extends Modelica.Icons.Function;
    input String string "要从中创建散列的字符串";
    output Integer hash "字符串的哈希值";
    external "C" hash=  ModelicaStrings_hashString(string) 
       annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
hash = Strings.<strong>hashString</strong>(string);
</pre></blockquote>
<h4>描述</h4>
<p>
返回所提供字符串的整数散列值
(哈希可以是任何整数，包括零或负数).
</p>

<h4>例子</h4>
<blockquote><pre>
hashString(\"this is a test\")     // =  1827717433
hashString(\"Controller.noise1\")  // = -1025762750
</pre></blockquote>
</html>"  ,   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
  <td>

<table border=\"0\">
<tr><td>
       <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
       实现的初始版本
       A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
       <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"  ));
  end hashString;

  function scanToken "扫描下一个令牌并返回它"
    extends Modelica.Icons.Function;
    input String string "要扫描的字符串";
    input Integer startIndex(min=1) = 1 
      "从字符startIndex处开始扫描字符串";
    input Boolean unsigned=false 
      "= 如果Real和Integer标记不能以符号开头，则为true";
    output Types.TokenValue token "扫描的令牌";
    output Integer nextIndex 
      "找到的标记后的字符索引;= 0，如果NoToken";
  protected
    Integer startTokenIndex;
  algorithm
    // 初始化标志
    token.real :=0.0;
    token.integer :=0;
    token.boolean :=false;
    token.string :="";

    // 跳过空白和行注释
    startTokenIndex := Advanced.skipLineComments(string, startIndex);
    if startTokenIndex > length(string) then
      token.tokenType := Modelica.Utilities.Types.TokenType.NoToken;
      nextIndex := startTokenIndex;
    else
      // 扫描整数
        (nextIndex, token.integer) := Advanced.scanInteger(string, startTokenIndex, unsigned);
         token.tokenType := Types.TokenType.IntegerToken;

      // 实数
      if nextIndex == startTokenIndex then
        (nextIndex, token.real) :=Advanced.scanReal(string, startTokenIndex, unsigned);
         token.tokenType := Types.TokenType.RealToken;
      end if;

      // 扫描字符串
      if nextIndex == startTokenIndex then
         (nextIndex,token.string) := Advanced.scanString(string, startTokenIndex);
          token.tokenType:= Types.TokenType.StringToken;
      end if;

      // 标识符或布尔值
      if nextIndex == startTokenIndex then
         (nextIndex,token.string) := Advanced.scanIdentifier(string, startTokenIndex);
         if nextIndex > startTokenIndex then
            if token.string == "false" then
               token.string := "";
               token.boolean :=false;
               token.tokenType := Types.TokenType.BooleanToken;
            elseif token.string == "true" then
               token.string := "";
               token.boolean := true;
               token.tokenType := Types.TokenType.BooleanToken;
            else
               token.tokenType := Types.TokenType.IdentifierToken;
            end if;
         end if;
      end if;

      // 扫描分隔符
      if nextIndex == startTokenIndex then
         token.string :=substring(string, startTokenIndex, startTokenIndex);
         token.tokenType := Types.TokenType.DelimiterToken;
         nextIndex := startTokenIndex + 1;
      end if;
    end if;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(token, nextIndex) = Strings.<strong>scanToken</strong>(string, startIndex, unsigned=false);
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>scanToken</strong>扫描从索引开始的字符串
\"startIndex\"并返回下一个标记，以及
直接在令牌后面索引。返回的令牌是一条记录
它保存令牌的类型和令牌的值:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td>token.tokenType</td>
    <td>令牌的类型，见下文</td></tr>
<tr><td>token.real</td>
    <td>Real value if tokenType == TokenType.RealToken</td></tr>
<tr><td>token.integer</td>
    <td>Integer value if tokenType == TokenType.IntegerToken</td></tr>
<tr><td>token.boolean</td>
    <td>Boolean value if tokenType == TokenType.BooleanToken</td></tr>
<tr><td>token.string</td>
    <td>String value if tokenType == TokenType.StringToken/IdentifierToken/DelimiterToken</td></tr>
</table>
<p>
变量的令牌。tokenType是一个枚举(模拟为一个包)
使用常量)，可以有以下值:
</p>
<blockquote><pre>
import T = Modelica.Utilities.Types.TokenType;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td>T.RealToken</td>
    <td>Modelica Real literal (e.g., 1.23e-4)</td></tr>
<tr><td>T.IntegerToken</td>
    <td>Modelica Integer literal (e.g., 123)</td></tr>
<tr><td>T.BooleanToken</td>
    <td>Modelica Boolean literal (e.g., false)</td></tr>
<tr><td>T.StringToken</td>
    <td>Modelica String literal (e.g., \"string 123\")</td></tr>
<tr><td>T.IdentifierToken</td>
    <td>Modelica identifier (e.g., \"force_a\")</td></tr>
<tr><td>T.DelimiterToken</td>
    <td>任何没有空格的字符<br>
作为上述记号中的第一个字符 (e.g., \"&amp;\")</td></tr>
<tr><td>T.NoToken</td>
    <td>空白，行注释和没有其他标记<br>
直到字符串的末尾</td></tr>
</table>
<p>
Modelica行注释 (\"// ... end-of-line/end-of-string\")
空白也会被忽略。
如果\"unsigned=true\"，一个实数或整数字面值
不允许以\"+\" or \"-\" 符号开头。
</p>
<h4>例子</h4>
<blockquote><pre>
import Modelica.Utilities.Strings;
import T = Modelica.Utilities.Types.TokenType;
(token, index) := Strings.scanToken(string);
<strong>if</strong> token.tokenType == T.RealToken <strong>then</strong>
 realValue := token.real;
<strong>elseif</strong> token.tokenType == T.IntegerToken <strong>then</strong>
 integerValue := token.integer;
<strong>elseif</strong> token.tokenType == T.BooleanToken <strong>then</strong>
 booleanValue := token.boolean;
<strong>elseif</strong> token.tokenType == T.Identifier <strong>then</strong>
 name := token.string;
<strong>else</strong>
 Strings.syntaxError(string,index,\"Expected Real, Integer, Boolean or identifier token\");
<strong>end if</strong>;
</pre></blockquote>
</html>"  ));
  end scanToken;

  function scanReal 
    "扫描下一个实数，如果不存在则触发断言"
    extends Modelica.Icons.Function;
    input String string "要扫描的字符串";
    input Integer startIndex(min=1)=1 
      "从字符startIndex处开始扫描字符串";
    input Boolean unsigned=false 
      "= 真实的符号不应该以符号开始";
    input String message="" 
      "如果扫描不成功，在错误消息中使用的消息";
    output Real number "实数值";
    output Integer nextIndex "在找到的数字之后的字符索引";
  algorithm
    (nextIndex, number) :=Advanced.scanReal(string, startIndex, unsigned);
    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       if unsigned then
          syntaxError(string, nextIndex, "期待一个没有符号的实数 " + message);
       else
          syntaxError(string, nextIndex, "期望一个实数 " + message);
       end if;
    end if;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
           number = Strings.<strong>scanReal</strong>(string);
(number, nextIndex) = Strings.<strong>scanReal</strong>(string, startIndex=1,
                                          unsigned=false, message=\"\");
</pre></blockquote>
<h4>描述</h4>
<p>
第一个形式\"scanReal(string)\"扫描\"string\"来查找a
带前导空白的实数并返回值。
</p>
<p>
第二种形式，\"scanReal(string,startIndex,unsigned)\"，
扫描从索引开始的字符串
\"startIndex\"，检查下一个标记是否为Real文字
并返回其值为实数，以及
指数直接在实数之后。
如果可选参数\"unsigned\"为<strong>true</strong>，
实数不能有前导\"+\"或\"-\"符号。
</p>
<p>
如果所需的实数与前导空白
\"string\"中不存在，则触发一个断言。
</p>
</html>"  ));
  end scanReal;

  function scanInteger 
    "扫描下一个整数，如果不存在则触发断言"
    extends Modelica.Icons.Function;
    input String string "要扫描的字符串";
    input Integer startIndex(min=1)=1 
      "从字符startIndex处开始扫描字符串";
    input Boolean unsigned=false 
      "= 如果整数标记不以符号开头，则为true";
    input String message="" 
      "如果扫描不成功，在错误消息中使用的消息";
    output Integer number "整数的值";
    output Integer nextIndex "在找到的数字之后的字符索引";
  algorithm
    (nextIndex, number) :=Advanced.scanInteger(string, startIndex, unsigned);
    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       if unsigned then
          syntaxError(string, nextIndex, "期望一个没有符号的整数 " + message);
       else
          syntaxError(string, nextIndex, "期望一个整数 " + message);
       end if;
    end if;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
           number = Strings.<strong>scanInteger</strong>(string);
(number, nextIndex) = Strings.<strong>scanInteger</strong>(string, startIndex=1,
                                             unsigned=false, message=\"\");
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>scanInteger</strong>扫描从索引开始的字符串
\"startIndex\"，检查下一个标记是否为整数字面值
并返回其值为整数，以及
直接在整数后面索引。触发一个断言，
如果扫描的字符串不包含可选的整数字面值
前导留白。
</p>
</html>"  ));
  end scanInteger;

  function scanBoolean 
    "扫描下一个布尔值，如果不存在则触发断言"
    extends Modelica.Icons.Function;
    input String string "要扫描的字符串";
    input Integer startIndex(min=1)=1 
      "从字符startIndex处开始扫描字符串";
    input String message="" 
      "如果扫描不成功，在错误消息中使用的消息";
    output Boolean number "布尔值";
    output Integer nextIndex "在找到的数字之后的字符索引";
  protected
    String identifier;
  algorithm
    (nextIndex, identifier) :=Advanced.scanIdentifier(string, startIndex);

    if nextIndex > startIndex then
       if identifier == "false" then
          number := false;
       elseif identifier == "true" then
          number := true;
       else
          nextIndex := startIndex;
       end if;
    end if;

    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       syntaxError(string, nextIndex, 
         "Expected a Boolean constant, i.e., \"false\" or \"true\" " + message);
    end if;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
           number = Strings.<strong>scanBoolean</strong>(string);
(number, nextIndex) = Strings.<strong>scanBoolean</strong>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>scanBoolean</strong>扫描从索引开始的字符串
\"startIndex\"，检查下一个标记是否为布尔字面值
(即，如果转换为小写字母，是字符串\"false\"还是\"true\")
并返回其值为布尔值，以及
索引直接在布尔值之后。触发一个断言，
如果扫描的字符串不包含可选的布尔字面值
前导留白。
</p>
</html>"  ));
  end scanBoolean;

  function scanString 
    "扫描下一个Modelica字符串，如果不存在则触发断言"
    extends Modelica.Icons.Function;
    input String string "要扫描的字符串";
    input Integer startIndex(min=1)=1 
      "从字符startIndex处开始扫描字符串";
    input String message="" 
      "如果扫描不成功，在错误消息中使用的消息";
    output String result "字符串的值";
    output Integer nextIndex "找到的字符串后的字符索引";
  algorithm
    (nextIndex, result) :=Advanced.scanString(string, startIndex);
    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       syntaxError(string, nextIndex, "期望是用双引号括起来的字符串 " + message);
    end if;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
           string2 = Strings.<strong>scanString</strong>(string);
(string2, nextIndex) = Strings.<strong>scanString</strong>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>scanString</strong>扫描从索引开始的字符串
\"startIndex\"，检查下一个标记是否为String字面值
并返回其值为String，以及
直接在字符串后面索引。触发一个断言，
如果扫描的字符串不包含带有optional的string字面值
前导留白。
</p>
</html>"    ));
  end scanString;

  function scanIdentifier 
    "扫描下一个标识符，如果不存在则触发断言"
    extends Modelica.Icons.Function;
    input String string "要扫描的字符串";
    input Integer startIndex(min=1)=1 
      "从字符startIndex处开始扫描标识符";
    input String message="" 
      "如果扫描不成功，在错误消息中使用的消息";
    output String identifier "标识符的值";
    output Integer nextIndex "在找到的标识符之后的字符索引";
  algorithm
    (nextIndex, identifier) :=Advanced.scanIdentifier(string, startIndex);
    if nextIndex == startIndex then
       nextIndex :=Advanced.skipWhiteSpace(string, startIndex);
       syntaxError(string, nextIndex, "期望一个标识符 " + message);
    end if;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
           identifier = Strings.<strong>scanIdentifier</strong>(string);
(identifier, nextIndex) = Strings.<strong>scanIdentifier</strong>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>scanIdentifier</strong>扫描从索引开始的字符串
\"startIndex\"，检查下一个令牌是否为标识符
并以字符串形式返回它的值，以及
直接在标识符后面索引。触发一个断言，
如果扫描的字符串不包含带有可选的标识符
前导留白。
</p>
</html>"  ));
  end scanIdentifier;

  function scanDelimiter 
    "扫描下一个分隔符，如果不存在则触发断言"
    extends Modelica.Icons.Function;
    input String string "要扫描的字符串";
    input Integer startIndex(min=1)=1 
      "从字符startIndex处开始扫描分隔符";
    input String requiredDelimiters[:]={","} "搜索的分隔符";
    input String message="" 
      "如果扫描不成功，在错误消息中使用的消息";
    output String delimiter "发现分隔符";
    output Integer nextIndex "在找到的分隔符之后的字符索引";
  protected
    Integer lenString = length(string);
    Integer lenDelimiter;
    Integer nDelimiters = size(requiredDelimiters,1);
    Integer endIndex;
    Boolean found;
    Integer i;

    encapsulated function concatenate "将字符串连接在一起"
       import Modelica;
       extends Modelica.Icons.Function;
       input String strings[:];
       output String string;
      annotation();
    algorithm
       string := "{\"";
       for i in 1:size(strings,1) loop
          if i == 1 then
             string := "{\"" + strings[1] + "\"";
          else
             string := string + ", \"" + strings[i] + "\"";
          end if;
       end for;
       string := string + "}";
    end concatenate;
  algorithm
    nextIndex := Advanced.skipLineComments(string,startIndex);
    found := false;
    i := 1;
    while not found and i <= nDelimiters loop
       lenDelimiter :=length(requiredDelimiters[i]);
       if lenDelimiter == 0 then
          found := true;
          delimiter := "";
       else
          endIndex :=nextIndex + lenDelimiter - 1;
          if endIndex <= lenString then
             if substring(string,nextIndex,endIndex) == requiredDelimiters[i] then
                found := true;
                delimiter := requiredDelimiters[i];
             end if;
          end if;
          i := i + 1;
       end if;
    end while;

    if found then
        nextIndex := nextIndex + lenDelimiter;
    else
       if size(requiredDelimiters,1) == 1 then
          syntaxError(string, nextIndex, "预期的分隔符 \"" + requiredDelimiters[1] + "\"\n" + message);
       else
          syntaxError(string, nextIndex, "的分隔符 " + 
                      concatenate(requiredDelimiters) + "\n" + message);
       end if;
    end if;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
           delimiter = Strings.<strong>scanDelimiter</strong>(string);
(delimiter, nextIndex) = Strings.<strong>scanDelimiter</strong>(string, startIndex=1,
                               requiredDelimiters={\",\"}, message=\"\");
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong> scanelimiter </strong>扫描从索引开始的字符串
\"startIndex\"，检查下一个标记是否为分隔符字符串
并以字符串形式返回它的值，以及
直接在分隔符之后索引。触发一个断言，
如果扫描的字符串不包含分隔符
所需分隔符列表。输入参数requiredDelimiters是一个向量
的字符串。元素可以是任意长度，包括长度为0的元素。
如果所需分隔符中的一个元素为零，则为空白
被视为分隔符。函数返回delimiter=\"\"和nextIndex
是第一个非空白字符的索引。</p>
</html>"  ));
  end scanDelimiter;

  function scanNoToken "扫描字符串并检查它是否不再包含令牌"
    extends Modelica.Icons.Function;
    input String string "要扫描的字符串";
    input Integer startIndex(min=1)=1 
      "从字符startIndex处开始扫描字符串";
    input String message="" 
      "如果扫描不成功，在错误消息中使用的消息";
  protected
    Integer nextIndex;
  algorithm
    nextIndex :=Advanced.skipLineComments(string, startIndex);
    if nextIndex <= length(string) then
       syntaxError(string, nextIndex, "不再期待更多的象征 " + message);
    end if;
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Strings.<strong>scanNoToken</strong>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>scanNoToken</strong>扫描从索引开始的字符串
\"startIndex\"并检查是否没有更多的令牌
字符串。如果不是这种情况，则触发assert。
使用\"message\"参数作为
错误文本。
</p>
</html>"  ));
  end scanNoToken;

  function syntaxError 
    "打印一条错误消息、一个字符串和扫描检测到错误的索引"
    extends Modelica.Icons.Function;
    input String string "在位置索引处有错误的字符串";
    input Integer index "扫描检测到错误的字符串索引";
    input String message="" "在错误消息末尾打印的字符串";

  protected
    Integer maxIndex = 40;
    Integer maxLenString = 60;
    Integer lenString = length(string);
    String errString;
    Integer index2 = if index < 1 then 1 else if index > lenString then lenString else index;
  algorithm
  // 如果"string"太长，打印时跳过部分字符串
     if index2 <= maxIndex then
       errString := string;
     else
       errString := "... " + substring(string, index2-maxIndex, lenString);
       index2 := maxIndex + 5; // 标记正确位置
     end if;

     if length(errString) > maxLenString then
        errString := substring(errString, 1, maxLenString) + " ...";
     end if;

  // 打印错误信息
     Streams.error("字符处的语法错误 " + String(index) + " of\n" + 
                   errString + "\n" + 
                   repeat(index2-1, " ") + "*" + "\n" + 
                   message);
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Strings.<strong>syntaxError</strong>(string, index, message);
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>syntaxError</strong>打印错误消息
下面的形式:
</p>
<blockquote><pre>
列&lt;index&gt;的
& lt; string&gt;
  ^       // 显示出错误的性格
&lt;message&gt;
</pre></blockquote>
<p>
其中&lt;…&gt;的实际值是
函数的输入参数。
</p>
<p>
如果给定的字符串太长，只有一个相关的
打印字符串的一部分。
</p>
</html>"  ));
  end syntaxError;

  package Advanced "高级扫描功能"
    extends Modelica.Icons.FunctionsPackage;

    pure function scanReal "扫描有符号实数"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1 "开始扫描的索引";
      input Boolean unsigned=false 
        "= 真的，如果数字不能以开头 '+' or '-'";
      output Integer nextIndex 
        "找到的令牌之后的索引(success=true)或扫描失败的索引(success=false)";
      output Real number "实数的值";
      external "C" ModelicaStrings_scanReal(string, startIndex, unsigned, nextIndex, number) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");
      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(nextIndex, realNumber) = <strong>scanReal</strong>(string, startIndex=1, unsigned=false);
</pre></blockquote>
<h4>描述</h4>
<p>
开始扫描位置\"startIndex\"的\"string\"。
首先跳过空白，然后扫描一个数字
根据Modelica语法，带有可选符号的Real类型:
</p>
<blockquote><pre>
real     ::= [sign] unsigned [fraction] [exponent]
sign     ::= '+' | '-'
unsigned ::= digit [unsigned]
fraction ::= '.' [unsigned]
exponent ::= ('e' | 'E') [sign] unsigned
digit    ::= '0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'
</pre></blockquote>
<p>
如果成功，该函数返回nextIndex =字符的索引
直接在后面找到实数，以及值
在第二个输出参数中.
</p>
<p>
如果不成功，则返回nextIndex = startIndex和
第二个输出参数为0。
</p>
<p>
如果可选参数\"unsigned\"为<strong>true</strong>，则
不能以 '+' 或 '-'.开头。\"unsigned\"的默认值是<strong>false</strong>.
</p>
<h4>另见</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>"        ));
    end scanReal;

    pure function scanInteger "扫描有符号整数"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1;
      input Boolean unsigned=false 
        "= true，如果数字不能以'+'或'-'开头";
      output Integer nextIndex 
        "找到的令牌之后的索引(success=true)或扫描失败的索引(success=false)";
      output Integer number "整数的值";
      external "C" ModelicaStrings_scanInteger(string, startIndex, unsigned, nextIndex, number) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");
      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(nextIndex, integerNumber) = <strong>scanInteger</strong>(string, startIndex=1, unsigned=false);
</pre></blockquote>
<h4>描述</h4>
<p>
开始扫描位置\"startIndex\"的\"string\"。
首先跳过空白，然后扫描一个有符号的数字
类型为整型。整数以可选的'+'开头。
或者'-'，马上
后跟一个非空的数字序列.
</p>
<p>
如果成功，该函数返回nextIndex =字符的索引
直接在找到的整数值之后，以及整数值
在第二个输出参数中。
</p>
<p>
如果不成功，则返回nextIndex = startIndex和
第二个输出参数为0。
</p>
<p>
注意，不处理实数，例如\"123.4\"
作为整数，scanInteger将返回
在本例中，nextIndex = startIndex。
</p>
<p>
如果可选参数\"unsigned\"为<strong>true</strong>，则
不能以'+'或'-'开头。\"unsigned\"的默认值是<strong>false</strong>.
</p>
<h4>另见</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>"        ));
    end scanInteger;

    pure function scanString "扫描字符串"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1 "开始扫描的索引";
      output Integer nextIndex 
        "找到的令牌之后的索引(success=true)或扫描失败的索引(success=false)";
      output String string2 "字符串记号的值";
      external "C" ModelicaStrings_scanString(string, startIndex, nextIndex, string2) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");
      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(nextIndex, string2) = <strong>scanString</strong>(string, startIndex=1);
</pre></blockquote>
<h4>描述</h4>
<p>
开始扫描位置\"startIndex\"的\"string\"。
首先跳过空白，然后扫描字符串
根据Modelica语法，即字符串
用双引号括起来。
</p>
<p>
如果成功，该函数返回nextIndex =字符的索引
直接在找到的字符串之后，以及字符串值
在第二个输出参数中。
</p>
<p>
如果不成功，则返回nextIndex = startIndex和
第二个输出参数是一个空字符串。</p>
<h4>另见</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>"        ));
    end scanString;

    pure function scanIdentifier "扫描简单标识符"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1 "开始扫描的索引";
      output Integer nextIndex 
        "找到的令牌之后的索引(success=true)或扫描失败的索引(success=false)";
      output String identifier "标识令牌的值";
      external "C" ModelicaStrings_scanIdentifier(string, startIndex, nextIndex, identifier) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");

      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(nextIndex, identifier) = <strong>scanIdentifier</strong>(string, startIndex=1);
</pre></blockquote>
<h4>描述</h4>
<p>
开始扫描位置\"startIndex\"的\"string\"。
首先跳过空白，然后扫描一个Modelica
标识符，即以。开头的字符序列
一个字母(\"a\"..\"z\" 或 \"A\"..\"Z\")后面跟着字母，
数字或下划线(\"_\")。
</p>
<p>
如果成功，该函数返回nextIndex =字符的索引
直接在找到的标识符之后，以及标识符之后
作为第二个输出参数中的字符串。
</p>
<p>
如果不成功，则返回nextIndex = startIndex和
第二个输出参数是一个空字符串。
</p>
<h4>另见</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>"        ));
    end scanIdentifier;

    pure function skipWhiteSpace "扫描空白区域"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1;
      output Integer nextIndex;
      external "C" nextIndex = ModelicaStrings_skipWhiteSpace(string, startIndex) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStrings.h\"", Library="ModelicaExternalC");
      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
nextIndex = <strong>skipWhiteSpace</strong>(string, startIndex);
</pre></blockquote>
<h4>描述</h4>
<p>
开始扫描位置\"startIndex\"和的\"string\"
跳过空白。函数返回nextIndex =字符的索引
第一个非空白字符的。
</p>
<h4>另见</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>"        ));
    end skipWhiteSpace;

    function skipLineComments "扫描注释和空白"
      extends Modelica.Icons.Function;
      input String string;
      input Integer startIndex(min=1)=1;
      output Integer nextIndex;
    protected
      Integer lenString = length(string);
      Boolean scanning;
      Boolean lineComment;
    algorithm
      nextIndex := startIndex;
      scanning := true;
      while scanning loop
         nextIndex := Advanced.skipWhiteSpace(string, nextIndex);
         if nextIndex+1 <= lenString then
            if substring(string,nextIndex,nextIndex+1) == "//" then
               // 搜索行尾注释
               nextIndex := nextIndex + 2;
               if nextIndex <= lenString then
                  lineComment := true;
                  while lineComment loop
                     if substring(string,nextIndex,nextIndex) == "\n" then
                        lineComment := false;
                     end if;
                     nextIndex := nextIndex + 1;
                     if nextIndex > lenString then
                        lineComment := false;
                        scanning := false;
                     end if;
                  end while;
               else
                  scanning := false;
               end if;
            else
               scanning := false;
            end if;
         else
            scanning := false;
         end if;
      end while;
      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
nextIndex = <strong>skipLineComments</strong>(string, startIndex);
</pre></blockquote>
<h4>描述</h4>
<p>
开始扫描位置\"startIndex\"的\"string\"。
首先跳过空白，然后扫描一个Modelica(C/C++)
行注释，即一个字符序列
以 \"//\"开头，以行尾\"\\n\"或结尾
用字符串的结尾。如果到达end- line，
该函数继续跳过空白和
扫描行注释，直到字符串结束
已达，或检测到另一个令牌。
</p>
<p>
如果成功，该函数返回nextIndex =字符的索引
直接在找到的行注释之后。
</p>
<p>
如果不成功，则返回 nextIndex = startIndex。
</p>
<h4>另见</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>"    ));
    end skipLineComments;
    annotation (Documentation(info="<html>
<h4>图书内容</h4>
<p>
包<强>字符串。Advanced</strong>包含基本扫描
功能。这些函数应该<strong>而不是直接调用</strong>，因为
使用更高级的函数\"Strings.scanXXX\"要简单得多。
字符串的函数。高级库提供
基本的接口才能实现较高的层次
\"Strings\"包中的函数。
</p>
<p>
库\"Advanced\"提供了以下函数:
</p>
<blockquote><pre>
(nextIndex, realNumber)    = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanReal\">scanReal</a>        (string, startIndex, unsigned=false);
(nextIndex, integerNumber) = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanInteger\">scanInteger</a>     (string, startIndex, unsigned=false);
(nextIndex, string2)       = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanString\">scanString</a>      (string, startIndex);
(nextIndex, identifier)    = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanIdentifier\">scanIdentifier</a>  (string, startIndex);
nextIndex                 = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipWhiteSpace\">skipWhiteSpace</a>  (string, startIndex);
nextIndex                 = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipLineComments\">skipLineComments</a>(string, startIndex);
</pre></blockquote>
<p>
所有函数都执行以下操作:
</p>
<ol>
<li> 扫描从字符位置\"startIndex\"开始
\"string\" (startIndex默认值为1).</li>
<li> 首先，跳过空白，比如空格 (\" \"), 选项卡 (\"\\t\"), 或换行符 (\"\\n\")</li>
<li> 然后，扫描所需的令牌.</li>
<li> 如果成功，则返回nextIndex =字符的索引
直接在找到的令牌和令牌值之后返回
作为第二个输出参数.<br>
 如果不成功，就回来 nextIndex = startIndex.
 </li>
</ol>
<p>
以下附加规则适用于扫描:
</p>
<ul>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanReal\">scanReal</a>:<br>
扫描一个完整的数字，包括一个可选的前导\"+\"或 \"-\"(如果unsigned=false)
根据Modelica语法。例如，\"+1.23e-5\"，\"0.123\"是
实数，但是\". 1\"不是。
注意，整数，如\"123\"也被视为实数。<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanInteger\">scanInteger</a>:<br>
扫描一个整数，包括一个可选的前导\"+\"
或\"-\"(如果unsigned=false)，根据Modelica(和C/C++)语法。
例如，\"+123\"、\"20\"都是整数。
注意，实数，如\"123.4\"不是整数和
scanInteger返回nextIndex = startIndex.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanString\">scanString</a>:<br>
根据Modelica(和C/C++)语法扫描字符串，例如:
\"This is a \"string\"\"是一个有效的字符串记号.<br>&nbsp;</li>
<li> Function <a href=\"modelica:// modelica . utilities . strings . advanced .scanIdentifier\">scanIdentifier</a>:<br>
扫描一个Modelica标识符，即，标识符启动
以字母开头，后面跟着字母、数字或 \"_\"。
例如, \"w_rel\", \"T12\".<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanIdentifier\">scanIdentifier</a><br>
迭代地跳过空白和Modelica(C/C++)行注释。
行注释以\"//\"开头，以an结尾
行尾(\"\\n\")或\"string\"的末尾.</li>
</ul>
</html>"    ));
  end Advanced;
  annotation (
    Documentation(info="<html>
<h4>库内容</h4>
<p>
包 <strong>Strings</strong> 包含用于操作字符串的函数。
</p>
<p>
下表中给出了使用默认选项调用每个函数的示例。.
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Function</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td>len = <a href=\"modelica://Modelica.Utilities.Strings.length\">length</a>(string)</td>
      <td>Returns length of string</td></tr>
  <tr><td>string2 = <a href=\"modelica://Modelica.Utilities.Strings.substring\">substring</a>(string1,startIndex,endIndex)
       </td>
      <td>Returns a substring defined by start and end index</td></tr>
  <tr><td>result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n)<br>
 result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n,string)</td>
      <td>Repeat a blank or a string n times.</td></tr>
  <tr><td>result = <a href=\"modelica://Modelica.Utilities.Strings.compare\">compare</a>(string1, string2)</td>
      <td>Compares two substrings with regards to alphabetical order</td></tr>
  <tr><td>identical =
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">isEqual</a>(string1,string2)</td>
      <td>Determine whether two strings are identical</td></tr>
  <tr><td>result = <a href=\"modelica://Modelica.Utilities.Strings.count\">count</a>(string,searchString)</td>
      <td>Count the number of occurrences of a string</td></tr>
  <tr>
<td>index = <a href=\"modelica://Modelica.Utilities.Strings.find\">find</a>(string,searchString)</td>
      <td>Find first occurrence of a string in another string</td></tr>
<tr>
<td>index = <a href=\"modelica://Modelica.Utilities.Strings.findLast\">findLast</a>(string,searchString)</td>
      <td>Find last occurrence of a string in another string</td></tr>
  <tr><td>string2 = <a href=\"modelica://Modelica.Utilities.Strings.replace\">replace</a>(string,searchString,replaceString)</td>
      <td>Replace one or all occurrences of a string</td></tr>
  <tr><td>stringVector2 = <a href=\"modelica://Modelica.Utilities.Strings.sort\">sort</a>(stringVector1)</td>
      <td>Sort vector of strings in alphabetic order</td></tr>
  <tr><td>hash = <a href=\"modelica://Modelica.Utilities.Strings.hashString\">hashString</a>(string)</td>
      <td>Create a hash value of a string</td></tr>
  <tr><td>(token, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanToken\">scanToken</a>(string,startIndex)</td>
      <td>Scan for a token (Real/Integer/Boolean/String/Identifier/Delimiter/NoToken)</td></tr>
  <tr><td>(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">scanReal</a>(string,startIndex)</td>
      <td>Scan for a Real constant</td></tr>
  <tr><td>(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanInteger\">scanInteger</a>(string,startIndex)</td>
      <td>Scan for an Integer constant</td></tr>
  <tr><td>(boolean, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanBoolean\">scanBoolean</a>(string,startIndex)</td>
      <td>Scan for a Boolean constant</td></tr>
  <tr><td>(string2, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanString\">scanString</a>(string,startIndex)</td>
      <td>Scan for a String constant</td></tr>
  <tr><td>(identifier, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanIdentifier\">scanIdentifier</a>(string,startIndex)</td>
      <td>Scan for an identifier</td></tr>
  <tr><td>(delimiter, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanDelimiter\">scanDelimiter</a>(string,startIndex)</td>
      <td>Scan for delimiters</td></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Strings.scanNoToken\">scanNoToken</a>(string,startIndex)</td>
      <td>Check that remaining part of string consists solely of<br>
          white space or line comments (\"// ...\\n\").</td></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Strings.syntaxError\">syntaxError</a>(string,index,message)</td>
      <td> Print a \"syntax error message\" as well as a string and the<br>
           index at which scanning detected an error</td></tr>
</table>
<p>
The functions \"compare\", \"isEqual\", \"count\", \"find\", \"findLast\", \"replace\", \"sort\"
have the optional
input argument <strong>caseSensitive</strong> with default <strong>true</strong>.
If <strong>false</strong>, the operation is carried out without taking
into account whether a character is upper or lower case.
</p>
</html>"));
end Strings;