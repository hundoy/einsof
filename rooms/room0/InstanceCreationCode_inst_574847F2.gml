image_index = 15;

script_content=@"
[str boy_name=刘一三]
[lh boy]
[dh 男孩]
你好，小姑娘。我叫\s[boy_name]呀~
[val no_change=5]
[val talk_time+1]
[lh girl]
[dh 少女]
你跟我搭话了\v[talk_time]次。
但有一个数字\v[no_change]不变
[xlh]
[xdh]
";