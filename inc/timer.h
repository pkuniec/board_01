#ifndef TIMER__H
#define TIMER__H

typedef void os_TimerFunc(void);

typedef struct _os_TIMER_ {
    struct _os_TIMER_ *timer_next;
    uint8_t timer_expire;
    uint8_t timer_period;
    os_TimerFunc *timer_func;
} os_Timer;


void os_timer_init(os_TimerFunc *func);
void os_timer_setfn(os_Timer *timer, os_TimerFunc *func);
void os_timer_arm(os_Timer *timer, uint8_t time, uint8_t repeat);
void os_timer_disarm(os_Timer *timer);
void os_timer_event(void);

#endif