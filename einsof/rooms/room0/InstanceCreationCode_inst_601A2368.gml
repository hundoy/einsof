script_content=@"
[lh java p=r g=normal c=1 f=0]
[dh 扎瓦]
立绘的一个测试。现在是在右边，普通动作，便装，脸1。
[lh java f=1]
变个脸
[lh java f=2]
再变个脸
[lh java c=0 f=1]
衣服换成制服，表情也变一下
[lh java f=0]
表情再变一下
[lh java g=think c=0 f=0]
现在我动作也切换了，其实是一个大切换，必须什么都指定一下。
[lh java f=1]
表情变一下
[lh java g=normal c=0 f=0]
变回最初的样子，立绘测试结束。
[bg 7home t=60]
[wt trans]
慢慢显示背景并等待
[pretrans]
[bg rest]
[lh java p=0.5 g=normal c=1 f=0]
[trans t=120]
[wt trans]
立绘和背景一起变，并等待
[bg 7home t=0]
[lh java p=r g=normal c=1 f=1 t=0]
然后一瞬间显示
[lh java p=r g=think c=0 f=0 t=120]
慢慢切换立绘，但这回不等了
[xlh]
[xdh]
[bg]
";