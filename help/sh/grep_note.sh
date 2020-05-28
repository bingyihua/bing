grep -E 'SIGNAL|OFL Hit'

grep -v "svn\|prj\|test\|auto_load"
#不显示上面的文字所在行
grep -nriE 'start ub|finish boot' *
find -name '*.h' | xargs grep -nr pt_regs
grep --color 'x\{2,3\}y' b 
# \{m,n\}:至少m次，至多n次
# xxy
# xxxy
cat c
He like his lover
She love her liker
He love his lover
She like her liker

grep '\(l..e\).*\1' c
He love his lover
She like her liker
# \1:后向引用，引用前面的第一个左括号以及与之对应的右括号中的模式匹配到的内容，意思是说前面出现一次，在\1这也要出现一次
做变量换算需要使用”“
贪婪模式：尽可能的长的去匹配字符：

位置锚定：用于指定字符出现的位置
^:锚定行首
^Char
$:锚定行尾
grepchar$
^$:空白行
单词的位置锚定
\<char ：锚定词首，\b
char\> : 锚定词尾，char\b
分组：
\(\)
\(ab\)*xy \(a.b\)xy\1 = a6bxya6b 

grep "chr1\>" Chrs.txt
chr1
grep "chr1\b" Chrs.txt
chr1
grep -w "chr1" Chrs.txt
chr1
#查找chr1的行

[0-9]=[[:digit:]] ：任意单个数字
[a-z]=[[:lower:]] ：任意单个小写字母
[A-Z]=[[:upper:]] ：任意单个大写字母
[[:alpha:]]：任意单个英文大小写字母
[[:alnum:]]：任意单个数字或英文大小写字母
[[:space:]]：空白字符
[[:punct:]]：任意标点符号
grep "a[0-9]" file.txt 
grep "a[[:alpha:]]" file.txt
grep "[^0-9]x" file.txt 
#非数字[^0-9]
a\{1,3\}b
#ab,aab,aaab

grep "^ab" file.txt
#ab开头，$锚定行尾

grep  ^[^#]  /etc/ansible/ansible.cfg 查找非#开头都内容
grep  -v #  file 过滤非#
