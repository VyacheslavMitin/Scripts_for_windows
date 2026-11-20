#Requires AutoHotkey v2.0

doubleSpaceTime := 300
lastSpace := 0
autoDot := false

$Space::
{
    global lastSpace, autoDot, doubleSpaceTime

    now := A_TickCount

    if (now - lastSpace <= doubleSpaceTime)
    {
        ; Первый пробел уже находится в тексте.
        ; Удаляем только его.
        Send "{Backspace}"

        ; Ставим точку и пробел
        Send ". "

        autoDot := true
        lastSpace := 0
    }
    else
    {
        ; Обычный пробел
        Send "{Space}"

        lastSpace := now
        autoDot := false
    }
}

$Backspace::
{
    global autoDot

    if (autoDot)
    {
        ; Удаляем пробел после точки и саму точку
        Send "{Backspace 2}"

        autoDot := false
    }
    else
    {
        ; Обычный Backspace
        Send "{Backspace}"
    }
}

