#include "stm8s.h"
#include "timer.h"

static os_Timer sys_timer;

// Init for system timer (primary timer)
void os_timer_init(os_TimerFunc *func) {
    sys_timer.timer_next = 0;
    sys_timer.timer_expire = 10;
    sys_timer.timer_period = 10;
    
    if( func ) {
        sys_timer.timer_func = func;
    } else {
        sys_timer.timer_func = 0;
    }
}


void os_timer_setfn(os_Timer *timer, os_TimerFunc *func) {
    timer->timer_func = func;
}


void os_timer_arm(os_Timer *timer, uint8_t time, uint8_t repeat) {
    os_Timer *cur = &sys_timer;

    while ( cur->timer_next ) {
        if ( cur->timer_next == timer ) {
            break;
        }
        cur = cur->timer_next;
    }
    cur->timer_next = timer;
    
    timer->timer_expire = time;

    if( repeat ) {
        timer->timer_period = time;
    } else {
        timer->timer_period = 0;
    }
}


void os_timer_disarm(os_Timer *timer) {
    timer->timer_expire = 0;
    timer->timer_func = 0;
    timer->timer_period = 0;
}


void os_timer_event(void) {
    os_Timer *cur = &sys_timer;

    do {
        if ( cur->timer_expire ) {
            cur->timer_expire--;
        } else {
            if( cur->timer_func ) {
                cur->timer_func();

                if( cur->timer_period ) {
                    cur->timer_expire = cur->timer_period;
                } else {
                    cur->timer_func = 0;
                }
            }
        }
        cur = cur->timer_next;
    } while ( cur );
}