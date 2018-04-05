script_content=@"
[lh wolf]
[dh 狼忍者]
接下来测试选择支吧。
# 选择支
[sel clear]
[sel add t=sayhi x=打个招呼]
[sel add t=saygun x=哪来的狗qnmd]
[sel add t=ignore x=假装没看到]
[sel show]
*sayhi
你好呀~
[jump goon]
*saygun
永远有多远，你就滚多远！
[jump goon]
*ignore
今天天气不错，还是打个招呼吧
[sel rm t=ignore]
[sel show]
*goon
呜啦啦啦~
[xlh]
[xdh]
";