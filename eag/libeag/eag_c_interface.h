/*
   File: eag_c_interface.h
   Defines the interface between C and EAG for programs in C that use parsers generated by EAG

   CVS ID: "$Id: eag_c_interface.h,v 1.3 2004/12/25 22:19:08 marcs Exp $"
*/
#ifndef IncEagCInterface
#define IncEagCInterface

/* libebs includes */
#include <ebs_bst.h>
#include <ebs_cst.h>
#include <ebs_value.h>

/* exported functions */
void init_C_interface ();
void assign_input_affix ();
void collect_output_affix ();
void reserve_collection_space ();
int parse_this_buffer (char *buffer, value *ivals, value ***cvals);

#endif /* IncEagCInterface */
