#NoEnv
#Warn
#MaxThreadsPerHotkey 3
#MaxHotkeysPerInterval 1000

AutoReloadEn := False

scan_timeout = 5

bar_begin_x := 222
bar_end_x := 410
bar_middle_y := 936

window_search_begin := 280
window_search_end := 300
slide_search_offset_left := 6
slide_search_offset_right := 3

background_cl := 0x1A1A1A
window_cl := 0xABABAB
slide_cl := 0xFFFFFF

Numpad0::
Suspend Toggle
Return

; autoreload
; reloadbar 222x925 - 410x948 px
*NumpadDiv::
AutoReloadEn := !AutoReloadEn
While AutoReloadEn {
    first_pixel_color := 0
    PixelGetColor, first_pixel_color, 222, 925
    if (first_pixel_color == background_cl) {
        window_x := 0
        window_y := 0
        PixelSearch, window_x, window_y, window_search_begin, bar_middle_y, window_search_end, bar_middle_y, window_cl, 0, Fast
        if not ErrorLevel {
            slide_x := 0
            slide_y := 0
            PixelSearch, slide_x, slide_y, window_x - slide_search_offset_left, bar_middle_y, window_x + slide_search_offset_right, bar_middle_y, slide_cl, 0, Fast
            if not ErrorLevel {
                SendRaw, r
            }
        }
    }
    Sleep, scan_timeout
}
Return
