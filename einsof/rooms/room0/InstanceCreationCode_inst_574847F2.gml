image_index = 15;

script_content=@"
[str boy_name=刘一三]
[lh boy]
[dh 男孩]
你好，小姑娘。我叫\s[boy_name]呀~
[val no_change=5]
[val talk_time=$+1]
[val another=$no_change+10]
[lh girl]
[dh 少女]
你跟我搭话了\v[talk_time]次。
@if $talk_time=1
    我们第一次说话呢，你好！
@else
    @if $talk_time<3
        再次见面了
    @else
        事不过三，别再来烦我了！
    @endif
@endif
但有两个数字\v[no_change]和\v[another]不变
[xlh]
[xdh]
";