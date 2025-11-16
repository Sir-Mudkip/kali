PROMPT_COLOR="${PROMPT_COLOR:-31}"  # Red color (31) for the Kali style
PROMPT_USERHOST="${PROMPT_USERHOST:-\u㉿\h}"
PROMPT_SEPARATOR="${PROMPT_SEPARATOR:-:}"
PROMPT_DIRECTORY="${PROMPT_DIRECTORY:-\w}"
colorpre='\[\e['
colorsuf='m\]'
colorreset="${colorpre}0${colorsuf}"
PS1='┌──('"${colorpre}"'${PROMPT_COLOR}'"${colorsuf}"'${PROMPT_USERHOST@P}'"${colorreset}"')-[${PROMPT_DIRECTORY@P}]\n└─'"${colorpre}"'${PROMPT_COLOR}'"${colorsuf}"'❯ '"${colorreset}"

prompt_default() {
    PROMPT_COLOR="$1"
    PROMPT_DIR_COLOR="$2"
    PROMPT_SEPARATOR=':'
    PROMPT_DIRECTORY='\w'
    PROMPT_START=''
    PROMPT_END=''
}

prompt_traditional() {
    PROMPT_COLOR="${1:-0}"
    PROMPT_DIR_COLOR="$2"
    PROMPT_SEPARATOR=' '
    PROMPT_DIRECTORY='\W'
    PROMPT_START='['
    PROMPT_END=']'
}

prompt_default_os() {
    eval "$(grep ANSI_COLOR /etc/os-release)"
    PROMPT_COLOR="$ANSI_COLOR"
    PROMPT_DIR_COLOR="$1"
    PROMPT_SEPARATOR=':'
    PROMPT_DIRECTORY='\w'
    PROMPT_START=''
    PROMPT_END=''
}
