function fish_right_prompt
    set_color brblack

    set -l theme_date_format "+%H:%M:%S"
    set -l theme_right_prompt_glyph "·"
    set -l theme_cmd_duration_min 0 # in ms

    __theme_cmd_duration
    __theme_timestamp

    set_color normal
end

function __theme_cmd_duration -S
    [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt "$theme_cmd_duration_min" ]
    and return

    if [ "$CMD_DURATION" -lt 5000 ]
        echo -ns $CMD_DURATION 'ms'
    else if [ "$CMD_DURATION" -lt 60000 ]
        __theme_format_ms $CMD_DURATION s
    else if [ "$CMD_DURATION" -lt 3600000 ]
        set_color $fish_color_error
        __theme_format_ms $CMD_DURATION m
    else
        set_color $fish_color_error
        __theme_format_ms $CMD_DURATION h
    end

    echo -ns ' ' $theme_right_prompt_glyph ' '
end

function __theme_format_ms -S -a ms -a interval
    set -l interval_ms
    set -l scale 1

    switch $interval
        case s
            set interval_ms 1000
        case m
            set interval_ms 60000
        case h
            set interval_ms 3600000
            set scale 2
    end

    switch $FISH_VERSION
        case 2.0.\* 2.1.\* 2.2.\* 2.3.\*
            # Fish 2.3 and lower doesn't know about the -s argument to math.
            math "scale=$scale;$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
        case 2.\*
            # Fish 2.x always returned a float when given the -s argument.
            math -s$scale "$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
        case \*
            math -s$scale "$ms/$interval_ms"
            echo -ns $interval
    end
end

function __theme_timestamp -S
    set -q theme_date_format
    or set -l theme_date_format "+%c"

    set -q theme_date_timezone
        and env TZ="$theme_date_timezone" date $theme_date_format
        or date $theme_date_format
end
