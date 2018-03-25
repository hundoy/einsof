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
    我们第一次说话呢，你好!
@else
    不止一次说话了呢。
    @if $talk_time=2
        我们第二次说
    @elsif $talk_time=3
        第三次啦
    @else
        再次见面了
    @endif
    真的不止一次说话了。
@endif
但有两个数字\v[no_change]和\v[another]不变
[xlh]
[xdh]
";