/*
 * ion/ioncore/floatframe.h
 *
 * Copyright (c) Tuomo Valkonen 1999-2006. 
 *
 * Ion is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 */

#ifndef ION_IONCORE_FLOATFRAME_H
#define ION_IONCORE_FLOATFRAME_H

#include <libtu/setparam.h>
#include <libextl/extl.h>
#include <ioncore/common.h>
#include <ioncore/frame.h>
#include <ioncore/window.h>
#include <ioncore/rectangle.h>

#include "classes.h"

DECLCLASS(WFloatFrame){
    WFrame frame;
    int bar_w;
    
    double bar_max_width_q;
    int tab_min_w;
};


extern WFloatFrame *create_floatframe(WWindow *parent, const WFitParams *fp);

extern void floatframe_managed_remove(WFloatFrame *frame, WRegion *reg);

extern WRegion *floatframe_load(WWindow *par, const WFitParams *fp, 
                                ExtlTab tab);

extern void floatframe_toggle_shade(WFloatFrame *frame);

/* Geometry */

extern void floatframe_offsets(const WFloatFrame *frame, WRectangle *off);
extern void floatframe_geom_from_managed_geom(const WFloatFrame *frame, 
                                              WRectangle *geom);
extern void floatframe_geom_from_initial_geom(WFloatFrame *frame, 
                                              WGroupWS *ws,
                                              WRectangle *geom, 
                                              int gravity);
extern void floatframe_managed_geom(const WFloatFrame *frame, WRectangle *geom);
extern void floatframe_bar_geom(const WFloatFrame *frame, WRectangle *geom);
extern void floatframe_border_geom(const WFloatFrame *frame, WRectangle *geom);

/* Misc. */

extern bool floatframe_set_sticky(WFloatFrame *frame, int sp);
extern bool floatframe_is_sticky(WFloatFrame *frame);

#endif /* ION_IONCORE_FLOATFRAME_H */