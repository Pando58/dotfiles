function fish_prompt
    set -l last_status $status

    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -l vcs (fish_vcs_prompt " ")

    set -l c_main brgreen
    set -l c_main2 green
    set -l c_dark black
    set -l c_dark2 brblack
    set -l c_light2 brwhite
    set -l c_error brred

    set -l reset (set_color normal)

    echo

    echo -ns (set_color $c_dark2) ┏ $reset
    echo -ns (set_color $c_dark)  $reset
    if test $last_status -ne 0
        echo -ns (set_color $c_error -b $c_dark --bold) "$last_status " $reset
    else
        echo -ns (set_color $c_light -b $c_dark) " " $reset
    end
    if string length --quiet $SSH_CONNECTION
        echo -ns (set_color $c_dark -b $c_main2)  $reset
        echo -ns (set_color $c_dark -b $c_main2 --bold) " SSH " $reset
        echo -ns (set_color $c_main2 -b $c_dark)  $reset
    end
    echo -ns (set_color $c_dark -b $c_main)  $reset
    echo -ns (set_color $c_dark -b $c_main --bold) " $(prompt_pwd) " $reset
    if string length --quiet $IN_NIX_SHELL
        echo -ns (set_color $c_main -b $c_dark)  $reset
        echo -ns (set_color $c_dark -b $c_main2)  $reset
        echo -ns (set_color $c_dark -b $c_main2 --bold) " 󱄅 " $reset
    end
    if string length --quiet $vcs
        if string length --quiet $IN_NIX_SHELL
            echo -ns (set_color $c_main2 -b $c_dark)  $reset
        else
            echo -ns (set_color $c_main -b $c_dark)  $reset
        end
        echo -ns (set_color $c_light -b $c_dark) $vcs $reset
        echo -ns (set_color $c_dark)  $reset
    else
        if string length --quiet $IN_NIX_SHELL
            echo -ns (set_color $c_main2)  $reset
        else
            echo -ns (set_color $c_main)  $reset
        end

    end

    echo

    echo -ns (set_color $c_dark2) ┗ $reset
    echo -ns (set_color $c_light) "❯ " $reset
end
