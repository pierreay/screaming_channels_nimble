#include <string.h>
#include "screamingchannels_console.h"
#include "screamingchannels/misc.h"
#include "screamingchannels/input.h"
#include "console/console.h"

static void screamingchannels_process_input(struct os_event *ev);

static struct console_input screamingchannels_console_buf;

static struct os_event screamingchannels_console_event = {
    .ev_cb = screamingchannels_process_input,
    .ev_arg = &screamingchannels_console_buf
};

/* Event callback to process a line of input from console. */
static void
screamingchannels_process_input(struct os_event *ev)
{
    char *line;
    struct console_input *input;

    input = ev->ev_arg;
    assert (input != NULL);

    line = input->line;
    /* Do some work with line */
    if (!strcmp(line, "mode_train")) {
        sc_misc_set_train_mode();
        dump_sc_state();
    }
    else if (!strcmp(line, "mode_attack")) {
        sc_misc_set_attack_mode();
        dump_sc_state();
    }
    else if (!strcmp(line, "mode_dump")) {
        dump_sc_state();
    }
    else if (!strcmp(line, "input_sub")) {
        SC_INPUT_MODE = SC_INPUT_MODE_SUB;
        // TODO: Fill input.
        SC_INPUT_SUB_OK = 1;
    }
    else if (!strcmp(line, "input_gen")) {
        SC_INPUT_MODE = SC_INPUT_MODE_GEN;
    }
    else if (!strcmp(line, "input_dump")) {
        dump_sc_input();
    }
    else {
        console_printf("commands: mode_train mode_attack mode_dump input_sub input_gen input_dump\n");
    }
    /* Done processing line. Add the event back to the avail_queue */
    console_line_event_put(ev);
    return;
}

void screamingchannels_console_init()
{
    console_line_event_put(&screamingchannels_console_event);
    console_line_queue_set(os_eventq_dflt_get());
}
