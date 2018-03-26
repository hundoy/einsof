script_content=@"
*start
[val j=$+1]
[lh boy]
[dh 男孩]
标签测试耶\v[j]
[val i=0]
*head
[lh wolf]
[dh 狼忍者]
循环\v[i]次~
[val i=$+1]
[jump head cond=$i<5]
[lh boy]
[dh 男孩]
说完了，谢谢
[xlh]
[xdh]
[jump start cond=$j=1]
";