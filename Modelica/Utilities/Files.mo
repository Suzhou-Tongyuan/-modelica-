within Modelica.Utilities;
package Files "处理文件和目录的功能"
  extends Modelica.Icons.FunctionsPackage;

impure function list "列出文件或目录的内容"
  extends Modelica.Icons.Function;
  input String name 
      "如果名称是目录，则列出目录内容。如果是文件，则列出文件内容";
//..............................................................
  protected
  constant Types.FileType fileType = Modelica.Utilities.Internal.FileSystem.stat(name);

  impure function listFile "列出文件内容"
     extends Modelica.Icons.Function;
     input String name;
    protected
     String file[Streams.countLines(name)] =  Streams.readFile(name);
    annotation();
  algorithm
     for i in 1:min(size(file,1), 100) loop
        Streams.print(file[i]);
     end for;
  end listFile;

public
function getDirectorysOrFiles 
   "如果isDir为true，则获取给定目录中的目录数，否则获取文件数"
   input String directory;
   input String names[:];
       input Boolean isDir;
   output Integer n;
 protected
   Integer nEntries = size(names, 1);
   Integer lenDirectory = Strings.length(directory);
   String directory2;
   Integer nDirectories;
   Integer nFiles;
    annotation();
 algorithm
   directory2 := if Strings.substring(directory, lenDirectory, lenDirectory) == "/" then 
    directory else directory + "/";
   nDirectories := 0;
   nFiles := 0;

   for i in 1:nEntries loop
     if Modelica.Utilities.Internal.FileSystem.stat(
     directory2 + names[i]) == Types.FileType.Directory then
       nDirectories := nDirectories + 1;
     else
       nFiles := nFiles + 1;
     end if;
   end for;
   if isDir then
     n := nDirectories;
   else
     n := nFiles;
   end if;
end getDirectorysOrFiles;

    impure function sortDirectory 
      "按字母顺序对目录和文件进行排序"
      extends Modelica.Icons.Function;
      input String directory 
        "读取的目录（包括尾部的 '/')";
      input String names[:] 
        "目录中的文件名和目录名，顺序不限";
      output String orderedNames[size(names, 1)] 
        "目录名后跟文件名";
      output Integer nDirectories 
        "orderedNames 中的前 nDirectories 条目是目录";
    protected
      Integer nEntries = size(names, 1);
      Integer nFiles;
      Integer lenDirectory = Strings.length(directory);
      String directory2;
      parameter Integer nDirs1 = getDirectorysOrFiles(directory, names, true);
      parameter Integer nFiles1 = getDirectorysOrFiles(directory, names, false);
      String orderDir[nDirs1];
      String orderFile[nFiles1];
      annotation();
    algorithm
      // 用尾部的 "/"
      directory2 := if Strings.substring(directory, lenDirectory, lenDirectory) == "/" then 
        directory else directory + "/";

      // 区分目录和文件
      nDirectories := 0;
      nFiles := 0;
      for i in 1:nEntries loop
        if Modelica.Utilities.Internal.FileSystem.stat(
          directory2 + names[i]) == Types.FileType.Directory then
          nDirectories := nDirectories + 1;
          orderedNames[nDirectories] := names[i];
        else
          nFiles := nFiles + 1;
          orderedNames[nEntries - nFiles + 1] := names[i];
        end if;
      end for;

      // 按字母顺序排列文件和目录
      if nDirectories > 0 then
        for i in 1:nDirs1 loop
          orderDir[i] := orderedNames[i];
        end for;
        //orderedNames[1:nDirectories] := Strings.sort(orderedNames[1:nDirectories], caseSensitive = false);
        orderDir := Strings.sort(orderDir, caseSensitive = false);

        for i in 1:nDirs1 loop
          orderedNames[i] := orderDir[i];
        end for;
      end if;
      if nFiles > 0 then
        for i in 1:nFiles1 loop
          orderFile[i] := orderedNames[nDirs1 + i];
        end for;
        /*orderedNames[nDirectories + 1:nEntries] := 
        Strings.sort(orderedNames[nDirectories + 1:nEntries], caseSensitive = false);*/
        orderFile := Strings.sort(orderFile, caseSensitive = false);
        for i in 1:nFiles1 loop
          orderedNames[nDirs1 + i] := orderFile[i];
        end for;
      end if;
    end sortDirectory;

    impure function listDirectory "列出目录内容"
      extends Modelica.Icons.Function;
      input String directoryName;
      input Integer nEntries;
    protected
      String files[nEntries];
      Integer nDirectories;
      parameter String files1[nEntries] = Modelica.Utilities.Internal.FileSystem.readDirectory(
        directoryName, nEntries) "目录内容";
      annotation();
    algorithm
      if nEntries > 0 then
        Streams.print("\nDirectory \"" + directoryName + "\":");
        /*files :=  Modelica.Utilities.Internal.FileSystem.readDirectory(
        directoryName, nEntries);*/
        (files,nDirectories) := sortDirectory(directoryName, files1);

        // 列出目录
        if nDirectories > 0 then
          Streams.print("  Subdirectories:");
          for i in 1:nDirectories loop
            Streams.print("    " + files[i]);
          end for;
          Streams.print(" ");
        end if;

        // 文件列表
        if nDirectories < nEntries then
          Streams.print("  Files:");
          for i in nDirectories + 1:nEntries loop
            Streams.print("    " + files[i]);
          end for;
        end if;
      else
        Streams.print("... Directory\"" + directoryName + "\" is empty");
      end if;
    end listDirectory;
algorithm
  //fileType := Modelica.Utilities.Internal.FileSystem.stat(name);
  if fileType == Types.FileType.RegularFile then
     listFile(name);
  elseif fileType == Types.FileType.Directory then
     listDirectory(name, Modelica.Utilities.Internal.FileSystem.getNumberOfFiles(name));
  elseif fileType == Types.FileType.SpecialFile then
     Streams.error("无法列出文件 \"" + name + "\"\n" + 
                   "since it is not a regular file (pipe, device, ...)");
  else
     Streams.error("无法列出文件或目录 \"" + name + "\"\n" + 
                   "since it does not exist");
  end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Files.<strong>list</strong>(name);
</pre></blockquote>
<h4>说明</h4>
<p>
如果\"name\"是一个常规文件，那么该文件的内容将被打印出来。
文件的内容将被打印出来.
</p>
<p>
如果 \"name\"  是一个目录，那么 \"name\"  目录中的目录名和文件名将按排序顺序打印。
则按排序打印。
</p>
</html>"));
end list;

impure function copy "生成文件或目录的副本"
  extends Modelica.Icons.Function;
  input String oldName "要复制的文件或目录的名称";
  input String newName "文件或目录副本的名称";
  input Boolean replace=false 
      "= true，如果现有文件可被所需副本替换";
//..............................................................
  protected
  impure function copyDirectory "复制目录"
     extends Modelica.Icons.Function;
     input String oldName 
        "旧目录名称不带尾部'/'；保证存在";
     input String newName 
        "新目录名称不带尾部 '/'; 目录已经创建";
     input Boolean replace "= true，如果可以替换现有的 newName";
      annotation();
  algorithm
     copyDirectoryContents(Modelica.Utilities.Internal.FileSystem.readDirectory(
                                       oldName, Modelica.Utilities.Internal.FileSystem.getNumberOfFiles(
                                                oldName)), oldName, newName, replace);
  end copyDirectory;

  impure function copyDirectoryContents
    extends Modelica.Icons.Function;
    input String oldNames[:];
    input String oldName;
    input String newName;
    input Boolean replace;
    protected
     String oldName_i;
     String newName_i;
    annotation();
  algorithm
     for i in 1:size(oldNames,1) loop
        oldName_i := oldName + "/" + oldNames[i];
        newName_i := newName + "/" + oldNames[i];
        Files.copy(oldName_i, newName_i, replace);
     end for;
  end copyDirectoryContents;
//..............................................................

  Integer lenOldName = Strings.length(oldName);
  Integer lenNewName = Strings.length(newName);
  String oldName2 = if Strings.substring(oldName,lenOldName,lenOldName) == "/" then 
                       Strings.substring(oldName,1,lenOldName-1) else oldName;
  String newName2 = if Strings.substring(newName,lenNewName,lenNewName) == "/" then 
                       Strings.substring(newName,1,lenNewName-1) else newName;
  Types.FileType oldFileType = Modelica.Utilities.Internal.FileSystem.stat(
                                             oldName2);
  Types.FileType newFileType;
algorithm
  if oldFileType == Types.FileType.NoFile then
     Streams.error("无法复制文件或目录\n" + 
                   "\"" + oldName2 + "\" because it does not exist.");
  elseif oldFileType == Types.FileType.Directory then
     newFileType :=Modelica.Utilities.Internal.FileSystem.stat(
                                 newName2);
     if newFileType == Types.FileType.NoFile then
        createDirectory(newName2);
     elseif newFileType == Types.FileType.RegularFile or 
            newFileType == Types.FileType.SpecialFile then
        if replace then
           Files.removeFile(newName2);
           Files.createDirectory(newName2);
        else
           Streams.error("目录 \"" + oldName2 + "\" 应复制到\n" + 
                         "\"" + newName2 + "\" which is an existing file.\n" + 
                         "Since argument replace=false, this is not allowed");
        end if;
     end if;
     copyDirectory(oldName2, newName2, replace);
  else // 普通或特殊文件
     if replace then
        Files.removeFile(newName2);
     else
        Files.assertNew(newName2, "文件 \"" + oldName2 + "\" 应复制或移至\n" + 
                                  "\"" + newName2 + "\" which is an existing file or directory.\n" + 
                                  "Since argument replace=false, this is not allowed");
     end if;
     Modelica.Utilities.Internal.FileSystem.copyFile(
                       oldName2, newName2);
  end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Files.<strong>copy</strong>(oldName, newName);
Files.<strong>copy</strong>(oldName, newName, replace = true);
</pre></blockquote>
<h4>说明</h4>
<p>
命令功能<strong>copy</strong>(..)复制文件或目录
去一个新的地方。通过可选参数<strong>replace</strong>
可以定义一个已经存在的文件是否可以
由所需副本代替。
</p>
<p>
如果oldName/newName是目录，那么newName
目录可能存在。在这种情况下，oldName的内容
被拷贝到目录newName。如果replace = <strong>false</strong>
它要求现有的文件
newName中的文件不同于
oldName。
</p>
<h4>例子</h4>
<blockquote><pre>
copy(\"C:/test1/directory1\", \"C:/test2/directory2\");
   -> the content of directory1 is copied into directory2
      if \"C:/test2/directory2\" does not exist, it is newly
      created. If \"replace=true\", files in directory2
      may be overwritten by their copy
copy(\"test1.txt\", \"test2.txt\")
   -> make a copy of file \"test1.txt\" with the name \"test2.txt\"
      in the current directory
</pre></blockquote>
</html>"));
end copy;

impure function move "将文件或目录移动到其他位置"
  extends Modelica.Icons.Function;
  input String oldName "要移动的文件或目录的名称";
  input String newName "被移动文件或目录的新名称";
  input Boolean replace=false 
      "= true，如果可以替换现有文件或目录";
algorithm
  // 如果 oldName 和 newName 都在当前目录中
  // 使用 Internal.renameFile
  if Strings.find(oldName,"/") == 0 and Strings.find(newName,"/") == 0 then
     if replace then
        Files.remove(newName);
     end if;
     Internal.FileSystem.rename(oldName, newName);
  else
     Files.copy(oldName, newName, replace);
     Files.remove(oldName);
  end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Files.<strong>move</strong>(oldName, newName);
Files.<strong>move</strong>(oldName, newName, replace = true);
</pre></blockquote>
<h4>说明</h4>
<p>
命令功能<strong>move</strong>(..)移动文件或目录
去一个新的地方。通过可选参数<strong>replace</strong>
可以定义一个已经存在的文件是否可以
被取代。
</p>
<p>
如果oldName/newName是目录，那么newName
目录可能存在。在这种情况下，oldName的内容
移动到目录newName。如果replace = <strong>false</strong>
它要求现有的文件
newName中的文件不同于
oldName。
</p>
<h4>例子</h4>
<blockquote><pre>
move(\"C:/test1/directory1\", \"C:/test2/directory2\");
   -> the content of directory1 is moved into directory2.
      Afterwards directory1 is deleted.
      if \"C:/test2/directory2\" does not exist, it is newly
      created. If \"replace=true\", files in directory2
      may be overwritten
move(\"test1.txt\", \"test2.txt\")
  -> rename file \"test1.txt\" into \"test2.txt\"
     within the current directory
</pre></blockquote>
</html>"));
end move;

impure function remove "删除文件或目录(忽略调用，如果它不存在)"
  extends Modelica.Icons.Function;
  input String name "要删除的文件或目录的名称";
//..............................................................
  protected
  impure function removeDirectory "删除目录，即使它不是空的"
     extends Modelica.Icons.Function;
     input String name;
    protected
     Integer lenName = Strings.length(name);
     // 删除可选的尾随符 "/"
     String name2 = if Strings.substring(name,lenName,lenName) == "/" then 
                       Strings.substring(name,lenName-1,lenName-1) else name;
      annotation();
  algorithm
     removeDirectoryContents(Modelica.Utilities.Internal.FileSystem.readDirectory(
                                        name2, Modelica.Utilities.Internal.FileSystem.getNumberOfFiles(
                                                name2)), name2);
     Modelica.Utilities.Internal.FileSystem.rmdir(name2);
  end removeDirectory;

  impure function removeDirectoryContents
      extends Modelica.Icons.Function;
      input String fileNames[:];
      input String name2;
    annotation();
  algorithm
      for i in 1:size(fileNames,1) loop
         Files.remove(name2 + "/" + fileNames[i]);
      end for;
  end removeDirectoryContents;
//..............................................................
  String fullName;
  constant Types.FileType fileType=Modelica.Utilities.Internal.FileSystem.stat(name);
algorithm
  if fileType == Types.FileType.RegularFile or 
     fileType == Types.FileType.SpecialFile then
     Modelica.Utilities.Internal.FileSystem.removeFile(name);
  elseif fileType == Types.FileType.Directory then
     fullName :=Files.fullPathName(name);
     removeDirectory(fullName);
  end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Files.<strong>remove</strong>(name);
</pre></blockquote>
<h4>描述</h4>
<p>
删除文件或目录\"name\"。如果\"name\"不存在，
函数调用被忽略。如果\"name\"是目录，首先
目录的内容被删除，然后
目录本身。
</p>
<p>
这个函数是静默的，也就是说，它不打印消息。
</p>
</html>"));
end remove;

impure function removeFile "删除文件(忽略调用，如果它不存在)"
  extends Modelica.Icons.Function;
  input String fileName "应该删除的文件名";
  protected
  Types.FileType fileType = Modelica.Utilities.Internal.FileSystem.stat(
                                          fileName);
algorithm
  if fileType == Types.FileType.RegularFile then
     Streams.close(fileName);
     Modelica.Utilities.Internal.FileSystem.removeFile(
                         fileName);
  elseif fileType == Types.FileType.Directory then
     Streams.error("文件 \"" + fileName + "\" 应该被移除.\n" + 
                   "This is not possible, because it is a directory");
  elseif fileType == Types.FileType.SpecialFile then
     Streams.error("文件 \"" + fileName + "\" 应该被移除.\n" + 
                   "This is not possible, because it is a special file (pipe, device, etc.)");
  end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Files.<strong>removeFile</strong>(fileName);
</pre></blockquote>
<h4>描述</h4>
<p>
删除文件\"fileName\"。如果\"fileName\"不存在，
函数调用被忽略。如果\"fileName\"存在，但为
没有常规文件(例如，目录，管道，设备等)和
触发错误。
</p>
<p>
这个函数是静默的，也就是说，它不打印消息。
</p>
</html>"));
end removeFile;

impure function createDirectory 
    "创建目录(如果目录已经存在，忽略调用)"
  extends Modelica.Icons.Function;
  input String directoryName 
      "要创建的目录名(如果存在，忽略调用)";
//..............................................................
  impure function existDirectory 
      "查询目录是否存在；如果不是目录，则触发错误"
     extends Modelica.Icons.Function;
     input String directoryName;
     output Boolean exists "= 如果目录存在，则为true";
    protected
     Types.FileType fileType = Modelica.Utilities.Internal.FileSystem.stat(
                                             directoryName);
    annotation();
  algorithm
     if fileType == Types.FileType.RegularFile or 
        fileType == Types.FileType.SpecialFile then
        Streams.error("目录\"" + directoryName + "\"不能创建\n" + 
                      "因为这是一个已经存在的文件。");
     elseif fileType == Types.FileType.Directory then
        exists :=true;
     else
        exists :=false;
     end if;
  end existDirectory;

  function assertCorrectIndex 
      "如果目录中最后一个重要字符的索引错误，则打印错误"
     extends Modelica.Icons.Function;
     input Integer index "索引必须是 > 0";
     input String directoryName "错误消息的目录名";
    annotation();
  algorithm
     if index < 1 then
        Streams.error("无法创建目录\n" + 
                      "\"" + directoryName + "\"\n" + 
                      "因为这个目录名无效");
     end if;
  end assertCorrectIndex;

//..............................................................
protected
  String fullName;
  Integer index;
  Integer oldIndex;
  Integer lastIndex;
  Boolean found;
  Boolean finished;
  Integer nDirectories = 0 "需要生成的目录数";
algorithm
  // 忽略调用，如果目录存在
  if not existDirectory(directoryName) then
     fullName := Files.fullPathName(directoryName);

     // 去除尾迹 "/"
        index :=Strings.length(fullName);
        if Strings.substring(fullName,index,index) == "/" then
           index :=index - 1;
           assertCorrectIndex(index,fullName);
        end if;
        lastIndex := index;
        fullName := Strings.substring(fullName,1,index);

     // 搜索上层目录，直到找到存在的目录
     // ??? 稍后检查下面的while循环，如果还包括
     //  "c:/", "c:", "//name" 正确处理 ???
        found := false;
        while not found loop
           oldIndex := index;
           index := Strings.findLast(fullName,"/",startIndex=index);
           if index == 0 then
              index := oldIndex;
              found := true;
           else
              index := index - 1;
              assertCorrectIndex(index, fullName);
              found := existDirectory(Strings.substring(fullName,1,index));
           end if;
        end while;
        index := oldIndex;

     // 创建目录
        finished := false;
        while not finished loop
           Modelica.Utilities.Internal.FileSystem.mkdir(
                          Strings.substring(fullName,1,index));
           if index >= lastIndex then
              finished := true;
           elseif index < lastIndex then
              index := Strings.find(fullName, "/", startIndex=index+2);
              if index == 0 then
                 index :=lastIndex;
              end if;
           end if;
        end while;
  end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Files.<strong>createDirectory</strong>(directoryName);
</pre></blockquote>
<h4>描述</h4>
<p>
创建目录\"directoryName\"。如果这个目录已经存在，
函数调用被忽略。如果\"directoryName\"中的多个目录
不存在，它们都是创建的。例如，假设
该目录\"E:/test1\"存在并且该目录
\"E:/test1/test2/test3\"。在这种情况下
目录\"test1\"中的\"test2\"和\"test2\"中的\"test3\"
创建。
</p>
<p>
这个函数是静默的，也就是说，它不打印消息。
如果出现错误(例如，\"directoryName\"是一个已存在的正则
文件)，则触发一个断言。
</p>
</html>"));
end createDirectory;

impure function exist "查询文件或目录是否存在"
  extends Modelica.Icons.Function;
  input String name "文件或目录的名称";
  output Boolean result "= 如果文件或目录存在，则为True";
algorithm
  result := Modelica.Utilities.Internal.FileSystem.stat(
                          name) > Types.FileType.NoFile;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
result = Files.<strong>exist</strong>(name);
</pre></blockquote>
<h4>描述</h4>
<p>
如果\"name\"是一个已存在的文件或目录，则返回true。
如果不是这种情况，则函数返回false。
</p>
</html>"));
end exist;

impure function assertNew "如果存在文件或目录，则触发一个断言"
  extends Modelica.Icons.Function;
  input String name "文件或目录的名称";
  input String message="这是不允许的." 
      "消息，该消息应打印在默认消息之后的新行中";
  protected
  Types.FileType fileType = Modelica.Utilities.Internal.FileSystem.stat(
                                          name);
algorithm
  if fileType == Types.FileType.RegularFile then
     Streams.error("文件 \"" + name + "\" 已经存在.\n" + message);
  elseif fileType == Types.FileType.Directory then
     Streams.error("目录 \"" + name + "\" 已经存在.\n" + message);
  elseif fileType == Types.FileType.SpecialFile then
     Streams.error("特殊文件(管道、设备等) \"" + name + "\" 已经存在.\n" + message);
  end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Files.<strong>assertNew</strong>(name);
Files.<strong>assertNew</strong>(name, message=\"This is not allowed\");
</pre></blockquote>
<h4>描述</h4>
<p>
如果\"name\"是一个已存在的文件或目录，则触发断言。错误信息的结构如下:
</p>
<blockquote><pre>
File \"&lt;name&gt;\" already exists.
&lt;message&gt;
</pre></blockquote>
</html>"));
end assertNew;

function fullPathName "获取文件的完整路径名或目录名"
  extends Modelica.Icons.Function;
  input String name "绝对或相对文件或目录名";
  output String fullName "name的完整路径";
external "C" fullName = ModelicaInternal_fullPathName(name) annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
fullName = Files.<strong>fullPathName</strong>(name);
</pre></blockquote>
<h4>描述</h4>
<p>
返回文件或目录的完整路径名 \"name\".
</p>
</html>"));
end fullPathName;

function splitPathName 
    "在目录中拆分路径名称，文件名内核，文件扩展名"
  extends Modelica.Icons.Function;
  input String pathName "绝对或相对文件或目录名";
  output String directory "包含尾符的目录名 '/'";
  output String name "不带扩展名的文件名";
  output String extension "文件名的扩展名。开始于 '.'";

  protected
  Integer lenPath = Strings.length(pathName);
  Integer i = lenPath;
  Integer indexDot = 0;
  Integer indexSlash = 0;
  String c;
algorithm
  while i >= 1 loop
    c :=Strings.substring(pathName, i, i);
    if c == "." then
       indexDot := i;
       i := 0;
    elseif c == "/" then
       indexSlash := i;
       i := 0;
    else
       i := i - 1;
    end if;
  end while;

  if indexSlash == lenPath then
     directory := pathName;
     name      := "";
     extension := "";
  elseif indexDot > 0 then
     indexSlash :=Strings.findLast(pathName, "/", startIndex=indexDot - 1);
     if indexSlash == 0 then
        directory :="";
        name :=Strings.substring(pathName, 1, indexDot - 1);
     else
        directory :=Strings.substring(pathName, 1, indexSlash);
        name :=Strings.substring(pathName, indexSlash + 1, indexDot - 1);
     end if;
     extension :=Strings.substring(pathName, indexDot, lenPath);
   else
     extension :="";
     if indexSlash > 0 then
       directory :=Strings.substring(pathName, 1, indexSlash);
       name :=Strings.substring(pathName, indexSlash + 1, lenPath);
     else
       directory :="";
       name :=pathName;
     end if;
   end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(directory, name, extension) = Files.<strong>splitPathName</strong>(pathName);
</pre></blockquote>
<h4>描述</h4>
<p>
命令功能<strong>splitPathName</strong>(..)将路径名拆分为多个部分。
</p>
<h4>示例</h4>
<blockquote><pre>
(directory, name, extension) = Files.splitPathName(\"C:/user/test/input.txt\")

-> directory = \"C:/user/test/\"
   name      = \"input\"
   extension = \".txt\"
</pre></blockquote>
</html>"));
end splitPathName;

function temporaryFileName 
    "返回不存在的文件的任意名称，该文件位于访问权限允许写入该文件的目录中(用于文件的临时输出)"
  extends Modelica.Icons.Function;
  output String fileName "临时文件的完整路径名";
  external "C" fileName=ModelicaInternal_temporaryFileName() annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaInternal.h\"", Library="ModelicaExternalC");
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
fileName = Files.<strong>temporaryFileName</strong>();
</pre></blockquote>
<h4>描述</h4>
<p>
返回不存在的文件的任意名称
并且位于访问权限允许的目录中
写入此文件(用于文件的临时输出)。
</p>
<p>
创建的临时文件在关闭时不会自动删除，但需要显式删除，例如通过<strong> <a href=\"modelica://Modelica.Utilities.Files.removeFile\">removeFile</a></strong>(fileName)。
</p>
<p>
<strong>警告:</strong>
<strong>ModelicaInternal_temporaryFileName</strong>的底层C实现调用标准C函数<strong>tmpnam</strong>，如果另一个进程在<strong>tmpnam</strong>生成完整路径名之后创建了一个具有相同fileName的文件，则存在竞争条件安全问题。
</p>
<h4>示例</h4>
<blockquote><pre>
fileName = Files.temporaryFileName();
   -> fileName is the absolute path name of the temporary file
Streams.print(String(System.getPid()), fileName);
   -> Create the temporary file
      Warning: Possible race condition on file access
Files.removeFile(fileName);
   -> Explicitly delete the temporary file (after use)
</pre></blockquote>
</html>"));
end temporaryFileName;

  function loadResource 
    "返回URI的绝对路径名或本地文件名"
    extends 
      Modelica.Utilities.Internal.PartialModelicaServices.ExternalReferences.PartialLoadResource;
    extends ModelicaServices.ExternalReferences.loadResource;
    annotation(
      Documentation(info = 
      "<html>
<h4>语法</h4>
<blockquote><pre>
fileReference = Files.<strong>loadResource</strong>(uri);
</pre></blockquote>
<h4>描述</h4>
<p>
函数调用\"<code>Files.<strong>loadResource</strong>(uri)</code>\"返回文件的<strong>绝对路径名</strong>，
由URI或本地定义路径名。使用返回的文件名，可以使用C标准库的函数调用访问该文件。
如果数据或文件存储在数据库中，这可能需要将资源复制到临时文件夹并引用该文件夹。
</p>

<p>
此功能的实现是特定于工具的。然而，至少Modelica URIs(参见Modelica规范“第13.2.3章外部资源”)，也支持绝对本地文件路径名。
</p>

<h4>示例</h4>
<blockquote><pre>
file1 = loadResource(\"modelica://Modelica/Resources/Data/Utilities/Examples_readRealParameters.txt\")
      // file1 is the absolute path name of the file
file2 = loadResource(\"C:\\\\data\\\\readParameters.txt\")
      file2 = \"C:/data/readParameters.txt\"
</pre></blockquote>
</html>"  ));
  end loadResource;
    annotation (
Documentation(info="<html>
<p>
该软件包包含处理文件和目录的函数。
作为本软件包的一般惯例，“/”在所有函数的输入和输出参数中都用作目录
分隔符。
例如
</p>
<blockquote><pre>
exist(\"Modelica/Mechanics/Rotational.mo\");
</pre></blockquote>
<p>
这些函数提供了与底层操作系统目录分隔符的映射。
目录分隔符的映射。请注意，在 Windows 系统中使用
作为目录分隔符会很不方便，因为这个字符也是 Modelica 和 C 字符串中的转义字符。
字符也是 Modelica 和 C 字符串中的转义字符。
</p>
<p>
下表列出了每个函数的调用示例：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Function/type</em></strong></th><th><strong><em>Description</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Files.list\">list</a>(name)</td>
      <td> 列出文件或目录的内容.</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Files.copy\">copy</a>(oldName, newName)<br>
          <a href=\"modelica://Modelica.Utilities.Files.copy\">copy</a>(oldName, newName, replace=false)</td>
      <td> 生成文件或目录的副本.</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Files.move\">move</a>(oldName, newName)<br>
          <a href=\"modelica://Modelica.Utilities.Files.move\">move</a>(oldName, newName, replace=false)</td>
      <td> 将文件或目录移动到其他位置.</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Files.remove\">remove</a>(name)</td>
      <td> 删除文件或目录（如果不存在，则忽略调用）.</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Files.removeFile\">removeFile</a>(name)</td>
      <td> 删除文件（如果不存在，则忽略调用）</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Files.createDirectory\">createDirectory</a>(name)</td>
      <td> 创建目录（如果目录已存在，则忽略调用）.</td>
  </tr>
  <tr><td>result = <a href=\"modelica://Modelica.Utilities.Files.exist\">exist</a>(name)</td>
      <td> 查询文件或目录是否存在.</td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Utilities.Files.assertNew\">assertNew</a>(name,message)</td>
      <td> 如果文件或目录存在，则触发断言.</td>
  </tr>
  <tr><td>fullName = <a href=\"modelica://Modelica.Utilities.Files.fullPathName\">fullPathName</a>(name)</td>
      <td> 获取文件或目录名的完整路径名.</td>
  </tr>
  <tr><td>(directory, name, extension) = <a href=\"modelica://Modelica.Utilities.Files.splitPathName\">splitPathName</a>(name)</td>
      <td> 分割目录中的路径名、文件名内核、文件名扩展名.</td>
  </tr>
  <tr><td>fileName = <a href=\"modelica://Modelica.Utilities.Files.temporaryFileName\">temporaryFileName</a>()</td>
      <td> 返回不存在的任意文件名<br>
并且位于访问权限允许<br>的目录中。
写入此文件(用于文件的临时输出)。</td>
  </tr>
  <tr><td>fileReference = <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>(uri)</td>
      <td>返回URI的绝对路径名或本地文件名.</td>
  </tr>
</table>
</html>"));
end Files;