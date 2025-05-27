within Modelica.Utilities;
package System "与环境的互动"
  extends Modelica.Icons.FunctionsPackage;

function getWorkDirectory "获取工作目录的完整路径名"
  extends Modelica.Icons.Function;
  output String directory "工作目录的完整路径名";
// POSIX函数"getcwd"
  external "C" directory = ModelicaInternal_getcwd(0) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>

</html>"));
end getWorkDirectory;

impure function setWorkDirectory "设置工作目录"
  extends Modelica.Icons.Function;
  input String directory "新建工作目录";
// POSIX函数"chdir"
external "C" ModelicaInternal_chdir(directory) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>

</html>"));
end setWorkDirectory;

function getEnvironmentVariable "获取环境变量的内容"
  extends Modelica.Icons.Function;
  input String name "环境变量名称";
  input Boolean convertToSlash =  false 
      "True，如果环境变量中的本地目录分隔符必须更改为'/'";
  output String content 
      "环境变量的内容(如果不存在则为空)";
  output Boolean exist 
      "= true，如果环境变量存在;= false，如果不存在";
  external "C" ModelicaInternal_getenv(name, convertToSlash, content, exist) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>

</html>"));
end getEnvironmentVariable;

impure function setEnvironmentVariable "设置本地环境变量的内容"
  extends Modelica.Icons.Function;
  input String name "环境变量名称";
  input String content "环境变量的值";
  input Boolean convertFromSlash =  false 
      "True，如果环境变量中的'/'必须更改为本机目录分隔符";
external "C" ModelicaInternal_setenv(name, content, convertFromSlash) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>

</html>"));
end setEnvironmentVariable;

  impure function getTime "检索本地时间(在本地时区中)"
    extends Modelica.Icons.Function;
    output Integer ms "毫秒";
    output Integer sec "第二个";
    output Integer min "一分钟";
    output Integer hour "小时";
    output Integer day "一天";
    output Integer mon "月";
    output Integer year "一年";
    external "C" ModelicaInternal_getTime(ms,sec,min,hour,day,mon,year) 
      annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(ms, sec, min, hour, day, mon, year) = System.<strong>getTime</strong>();
</pre></blockquote>
<h4>描述</h4>
<p>
返回调用此函数时的本地时间。
所有返回值都是Integer类型，具有以下含义:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>参数</th>
  <th>范围</th>
  <th>描述</th></tr>

<tr><td>ms</td> <td>0 .. 999</td>
  <td>秒后的毫秒</td></tr>

<tr><td>sec</td> <td>0 .. 59</td>
  <td>分钟后的秒</td></tr>

<tr><td>min</td> <td>0 .. 59</td>
  <td>一小时后的分钟</td></tr>

<tr><td>hour</td> <td>0 .. 23</td>
  <td>午夜过后数小时</td></tr>

<tr><td>day</td> <td>1 .. 31</td>
  <td>月中的一天</td></tr>

<tr><td>mon</td> <td>1 .. 12</td>
  <td>本月</td></tr>

<tr><td>year</td> <td>&ge; 2015</td>
  <td>今年</td></tr>
</table>
</blockquote>

<h4>例子</h4>
<blockquote><pre>
(ms, sec, min, hour, mon, year) = getTime()   // = (281, 30, 13, 10, 15, 2, 2015)
                                            // Feb. 15, 2015 at 10:13 after 30.281 s
</pre></blockquote>
<h4>请注意</h4>
<p>这个函数不纯!</p>
</html>"    ,   revisions="<html>
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
</html>"    ));
  end getTime;

  impure function getPid "检索当前进程id"
    extends Modelica.Icons.Function;
    output Integer pid "进程ID";
    external "C" pid = ModelicaInternal_getpid() annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
pid = System.<strong>getPid</strong>();
</pre></blockquote>
<h4>描述</h4>
<p>
返回该函数所在进程的pid(进程标识)
被称为。这是一个非纯函数，返回值取决于
操作系统。
</p>

<h4>例子</h4>
<blockquote><pre>
getPid()   // = 3044
</pre></blockquote>
<h4>请注意</h4>
<p>这个函数是非纯粹的！</p>
</html>"    ,   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
  <td>

<table border=\"0\">
<tr><td>
       <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
       A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter实现的初始版本。<br>
       <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
  end getPid;

impure function command "在默认shell中执行命令"
  extends Modelica.Icons.Function;
  input String string "传递给shell的字符串";
  output Integer result "命令的返回值(取决于环境)";
  external "C" result = system(string) annotation(Include="#include <stdlib.h>", Library="ModelicaExternalC");
    annotation (Documentation(info="<html>

</html>"));
end command;

impure function exit "终止Modelica环境的执行"
  extends ModelicaServices.System.exit;
    annotation (Documentation(info="<html>

</html>"));
end exit;
    annotation (
Documentation(info="<html>
<p>
这个包包含与环境交互的函数。
</p>
</html>"));
end System;