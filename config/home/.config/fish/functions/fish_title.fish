function fish_title
    if [ "$theme_title_display_user" = 'yes' ]
        if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
            set -l IFS .
            uname -n | read -l host __
            echo -ns (whoami) '@' $host ' '
        end
    end

    if [ "$theme_title_display_process" = 'yes' ]
        echo $_

        [ "$theme_title_display_path" != 'no' ]
        and echo ' '
    end

    if [ "$theme_title_display_path" != 'no' ]
        if [ "$theme_title_use_abbreviated_path" = 'no' ]
            echo $PWD
        else
            prompt_pwd
        end
    end
end
