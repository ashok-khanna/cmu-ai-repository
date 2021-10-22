/*
(c) Copyright Taiichi Yuasa and Masami Hagiya, 1984.  All rights reserved.
(c) Copyright Enhancements by DELPHI SpA, 1987. All rights reserved.
    Copying of this file is authorized to users who have executed the true and
    proper "License Agreement for DELPHI Common LISP" with DELPHI SpA.
*/

#include <stdio.h>
#include <setjmp.h>
#define PDE
#define LOCATIVE
#define MTCL
#define CLOS 

#ifndef VOL
#define VOL
#endif

#define	TRUE		1
#define	FALSE		0

typedef int bool;
typedef int fixnum;
typedef float shortfloat;
typedef double longfloat;

typedef union lispunion *object;
#define	OBJNULL		((object)NULL)
struct fixnum_struct {
	short	t, m;
	fixnum	FIXVAL;
};

#define IMMEDIATE(obje)	((int)(obje) & 3)
#define MAKE_FIXNUM(n)	((object)(((int)(n) << 2) | 1))
#define	fix(obje)	(((int)(obje)) >> 2)

#ifdef LOCATIVE
#define FIXNUMP(obje)	((((int)(obje)) & 3) == 1)
#define LOCATIVEP(obje)	((((int)(obje)) & 3) == 2)
#define MAKE_LOCATIVE(n)((object)(((int)(n) << 2) | 2))
#define DEREF(loc)	(*(object *)((unsigned int)(loc) >> 2))
#define UNBOUNDP(loc)	(DEREF(loc) == OBJNULL)
#else
#define FIXNUMP(obje)	(((int)(obje)) & 1)
#endif LOCATIVE

struct shortfloat_struct {
	short		t, m;
	shortfloat	SFVAL;
};
#define	sf(obje)	(obje)->SF.SFVAL
struct longfloat_struct {
	short		t, m;
	longfloat	LFVAL;
};
#define	lf(obje)	(obje)->LF.LFVAL
struct bignum {
	short		t, m;
	struct bignum   *big_cdr;
	int		big_car;
};
struct ratio {
	short	t, m;
	object	rat_den;

	object	rat_num;

};
struct complex {
	short	t, m;
	object	cmp_real;

	object	cmp_imag;

};
struct character {
	short		t, m;
	unsigned short	ch_code;
	unsigned char	ch_font;
	unsigned char	ch_bits;
};
extern struct character character_table[];
#define	code_char(c)		(object)(character_table+((unsigned char)(c)))
#define	char_code(obje)		(obje)->ch.ch_code
#define	char_font(obje)		(obje)->ch.ch_font
#define	char_bits(obje)		(obje)->ch.ch_bits
enum stype {
	stp_ordinary,
	stp_constant,
        stp_special
};
#define	Cnil			((object)&Cnil_body)
#define	Ct			((object)&Ct_body)
struct symbol {
	short	t, m;
	object	s_dbind;
	int	(*s_sfdef)();

#define	NOT_SPECIAL		((int (*)())Cnil)
#define	s_fillp		st_fillp
#define	s_self		st_self
	int	s_fillp;
	char	*s_self;
	object	s_gfdef;
	object	s_plist;
	object	s_hpack;
	short	s_stype;
	short	s_mflag;
};
struct package {
	short	t, m;
	object	p_name;
	object	p_nicknames;
	object	p_shadowings;
	object	p_uselist;
	object	p_usedbylist;
	object	*p_internal;
	object	*p_external;
	struct package
		*p_link;
};
#define	INTERNAL	1
#define	EXTERNAL	2
#define	INHERITED	3
struct cons {
	short	t, m;
	object	c_cdr;
	object	c_car;
};
enum httest {
	htt_eq,
	htt_eql,
	htt_equal
};
struct htent {
	object	hte_key;
	object	hte_value;
};
struct hashtable {
	short	t, m;
	struct htent
		*ht_self;
	object	ht_rhsize;
	object	ht_rhthresh;
	int	ht_nent;
	int	ht_size;
	short	ht_test;

};
enum aelttype {
	aet_object,
	aet_ch,
	aet_bit,
	aet_fix,
	aet_sf,
	aet_lf
};
struct array {
	short	t, m;
	short	a_rank;
	short	a_adjustable;
	int	a_dim;
	int	*a_dims;
	object	*a_self;
	object	a_displaced;
	short	a_elttype;
	short	a_offset;
};
struct vector {
	short	t, m;
	short	v_hasfillp;
	short	v_adjustable;
	int	v_dim;
	int	v_fillp;
	object	*v_self;
	object	v_displaced;
	short	v_elttype;
	short	v_offset;
};
struct string {
	short	t, m;
	short	st_hasfillp;
	short	st_adjustable;
	int	st_dim;
	int	st_fillp;
	char	*st_self;
	object	st_displaced;
};
struct ustring {
	short	t, m;
	short	ust_hasfillp;
	short	ust_adjustable;
	int	ust_dim;
	int	ust_fillp;
	unsigned char
		*ust_self;
	object	ust_displaced;
};
struct bitvector {
	short	t, m;
	short	bv_hasfillp;
	short	bv_adjustable;
	int	bv_dim;
	int	bv_fillp;
	char	*bv_self;
	object	bv_displaced;
	short	bv_elttype;
	short	bv_offset;
};
struct fixarray {
	short	t, m;
	short	fixa_rank;
	short	fixa_adjustable;
	int	fixa_dim;
	int	*fixa_dims;
	fixnum	*fixa_self;
	object	fixa_displaced;
	short	fixa_elttype;
	short	fixa_offset;
};
struct sfarray {
	short	t, m;
	short	sfa_rank;
	short	sfa_adjustable;
	int	sfa_dim;
	int	*sfa_dims;
	shortfloat
		*sfa_self;
	object	sfa_displaced;
	short	sfa_elttype;
	short	sfa_offset;
};
struct lfarray {
	short	t, m;
	short	lfa_rank;
	short	lfa_adjustable;
	int	lfa_dim;
	int	*lfa_dims;
	longfloat
		*lfa_self;
	object	lfa_displaced;
	short	lfa_elttype;
	short	lfa_offset;
};
struct structure {
	short	t, m;
	object	str_name;
	object	*str_self;
	int	str_length;
};
enum smmode {
	smm_input,
	smm_output,
	smm_io,
	smm_probe,
	smm_synonym,
	smm_broadcast,
	smm_concatenated,
	smm_two_way,
	smm_echo,
	smm_string_input,
	smm_string_output
};
struct stream {
	short	t, m;
	FILE	*sm_fp;
	object	sm_object0;
	object	sm_object1;
	int	sm_int0;
	int	sm_int1;
	short	sm_mode;

};
struct random {
	short		t, m;
	unsigned	rnd_value;
};
enum chattrib {
	cat_whitespace,
	cat_terminating,
	cat_non_terminating,
	cat_single_escape,
	cat_multiple_escape,
	cat_constituent
};
struct rtent {
	enum chattrib	rte_chattrib;
	object		rte_macro;
	object		*rte_dtab;
};
struct readtable {
	short		t, m;
	struct rtent	*rt_self;
};
struct pathname {
	short	t, m;
	object	pn_host;
	object	pn_device;
	object	pn_directory;
	object	pn_name;
	object	pn_type;
	object	pn_version;
};
struct cfun {
	short	t, m;
	object	cf_name;
	int	(*cf_self)();
	object	cf_data;

	char	*cf_start;
	int	cf_size;
};
struct cclosure {
	short	t, m;
	object	cc_name;
	int	(*cc_self)();
	object	cc_env;
	object	cc_data;
	char	*cc_start;
	int	cc_size;
	object	*cc_turbo;
};
struct spice {
	short	t, m;
	int	spc_dummy;
};
struct dummy {
	short	t, m;
};
#ifdef MTCL
struct cont {
	short	t,m;
	object	cn_thread;
	bool	cn_resumed;
	bool	cn_timed_out;
};
struct thread {
	short   t, m;
	char    *th_self;
	int	th_size;
	object	th_fun;

	object	th_cont;
};
#endif MTCL

#ifdef CLOS
struct instance {
	short	t, m;
	object	co_class;
	object	*co_self;
	int	co_length;
};

struct gfun {
	short	t, m;
	object	gf_name;
	object  gf_meth_ht;
	int	gf_arg_no;
	object  *gf_spec_how;
	object  gf_gfun;
};
#endif
union lispunion {
	struct fixnum_struct
			FIX;
	struct bignum	big;
	struct ratio	rat;
	struct shortfloat_struct
			SF;
	struct longfloat_struct
			LF;
	struct complex	cmp;
	struct character
			ch;
	struct symbol	s;
	struct package	p;
	struct cons	c;
	struct hashtable
			ht;
	struct array	a;
	struct vector	v;
	struct string	st;
	struct ustring	ust;
	struct bitvector
			bv;
	struct structure
			str;
	struct stream	sm;
	struct random	rnd;
	struct readtable
			rt;
	struct pathname	pn;
	struct cfun	cf;
	struct cclosure	cc;
	struct spice	spc;
	struct dummy	d;
	struct fixarray	fixa;
	struct sfarray	sfa;
	struct lfarray	lfa;
#ifdef MTCL
	struct cont   cn;
	struct thread   th;
#endif MTCL
#ifdef CLOS
	struct instance co;
	struct gfun	gf;
#endif CLOS
};
enum type {
	t_cons = 0,
	t_start = 0, /* = t_cons, */
	t_bignum,
	t_ratio,
	t_shortfloat,
	t_longfloat,
	t_complex,
	t_character,
	t_symbol,
	t_package,
	t_hashtable,
	t_array,
	t_vector,
	t_string,
	t_bitvector,
#ifndef CLOS
	t_structure,
#endif CLOS
	t_stream,
	t_random,
	t_readtable,
	t_pathname,
	t_cfun,
	t_cclosure,
	t_spice,
#ifdef MTCL
	t_cont,
	t_thread,
#endif MTCL
#ifdef CLOS
	t_instance,  
	t_gfun,
#endif CLOS
	t_end,
	t_contiguous,
	t_relocatable,
	t_other,
	t_fixnum		/*  immediate fixnum */
#ifdef LOCATIVE
	, t_locative		/*  locative */
#endif LOCATIVE
};
#ifdef LOCATIVE
#define	type_of(obje)	((enum type)(IMMEDIATE(obje) ? \
				       ((int)t_other + IMMEDIATE(obje)) \
				       : (((object)(obje))->d.t)))
#else
#define	type_of(obje)	((enum type)(FIXNUMP(obje) ? t_fixnum \
				       : (((object)(obje))->d.t)))
#endif LOCATIVE
#define	endp(obje)	endp1(obje)
#ifdef MTCL
#define value_stack     clwp->lwp_value_stack
#define vs_limit        clwp->lwp_vs_limit
#else
object value_stack[];
object *vs_limit;
#endif MTCL
#define	vs_org		value_stack
object *vs_base;
object *vs_top;
#ifdef MTCL
#define	vs_push(obje)	(((object *)++vs_top)[-1] = (obje))
#else
#define	vs_push(obje)	(*vs_top++ = (obje))
#endif MTCL
#define	vs_pop		(*--vs_top)
#define	vs_head		vs_top[-1]
#define	vs_mark		object *old_vs_top = vs_top
#define	vs_reset	vs_top = old_vs_top
#define	vs_check	if (vs_top >= vs_limit)  \
				vs_overflow();
#ifdef MTCL
#define	vs_check_push(obje)  \
			(vs_top >= vs_limit ?  \
			 (object)vs_overflow() : \
			 (((object *)++vs_top)[-1] = (obje)))
#else
#define	vs_check_push(obje)  \
			(vs_top >= vs_limit ?  \
			 (object)vs_overflow() : (*vs_top++ = (obje)))
#endif MTCL
#define	check_arg(n)  \
			if (vs_top - vs_base != (n))  \
				check_arg_failed(n)
#define	MMcheck_arg(n)  \
			if (vs_top - vs_base < (n))  \
				too_few_arguments();  \
			else if (vs_top - vs_base > (n))  \
				too_many_arguments()
#define vs_reserve(x)	if(vs_base+(x) >= vs_limit)  \
				vs_overflow();
struct bds_bd {
	object	bds_sym;
	object	bds_val;
};
#ifdef MTCL
#define bind_stack      clwp->lwp_bind_stack
#else
struct bds_bd bind_stack[]; 
#endif MTCL
#define bds_org		bind_stack
typedef struct bds_bd *bds_ptr;
#ifdef MTCL
#define bds_limit       clwp->lwp_bds_limit
#define bds_top         clwp->lwp_bds_top
#else
bds_ptr bds_limit;
bds_ptr bds_top;
#endif MTCL

#define	bds_check  \
	if (bds_top >= bds_limit)  \
		bds_overflow()
#define	bds_bind(sym, val)  \
	((++bds_top)->bds_sym = (sym),  \
	bds_top->bds_val = (sym)->s.s_dbind,  \
	(sym)->s.s_dbind = (val))
#define	bds_unwind1  \
	((bds_top->bds_sym)->s.s_dbind = bds_top->bds_val, --bds_top)
typedef struct invocation_history {
	object	ihs_function;
	object	*ihs_base;
} *ihs_ptr;
#ifdef MTCL
#define ihs_stack       clwp->lwp_ihs_stack
#else
struct invocation_history ihs_stack[];
#endif MTCL
#define ihs_org		ihs_stack
#ifdef MTCL
#define ihs_limit       clwp->lwp_ihs_limit
#define ihs_top         clwp->lwp_ihs_top
#else
ihs_ptr ihs_limit;
ihs_ptr ihs_top;
#endif MTCL

#define	ihs_check  \
	if (ihs_top >= ihs_limit)  \
		ihs_overflow()
#define ihs_push(function)  \
	(++ihs_top)->ihs_function = (function);  \
	ihs_top->ihs_base = vs_base
#define ihs_pop() 	(ihs_top--)
enum fr_class {
	FRS_CATCH,
	FRS_CATCHALL,
	FRS_PROTECT
};
struct frame {
	jmp_buf		frs_jmpbuf;
	object		*frs_lex;
	bds_ptr		frs_bds_top;
	enum fr_class	frs_class;
	object		frs_val;
	ihs_ptr		frs_ihs;
};
typedef struct frame *frame_ptr;
#define	alloc_frame_id()	alloc_object(t_spice)
#ifdef MTCL
#define frame_stack       clwp->lwp_frame_stack
#else
struct frame frame_stack[];
#endif MTCL
#define frs_org		frame_stack
#ifdef MTCL
#define frs_limit       clwp->lwp_frs_limit
#define frs_top         clwp->lwp_frs_top
#else
frame_ptr frs_limit;
frame_ptr frs_top;
#endif MTCL
#define frs_push(class, val)  \
	if (++frs_top >= frs_limit)  \
		frs_overflow();  \
 	frs_top->frs_lex = lex_env;\
	frs_top->frs_bds_top = bds_top;  \
	frs_top->frs_class = (class);  \
	frs_top->frs_val = (val);  \
	frs_top->frs_ihs = ihs_top;  \
        _setjmp(frs_top->frs_jmpbuf)
#define frs_pop()	frs_top--
#ifdef MTCL
#define nlj_active       clwp->lwp_nlj_active
#define nlj_fr           clwp->lwp_nlj_fr
#define nlj_tag          clwp->lwp_nlj_tag
#define lex_env		 clwp->lwp_lex_env
#else
bool nlj_active;
frame_ptr nlj_fr;
object nlj_tag;
object *lex_env;
#endif MTCL
object caar();
object cadr();
object cdar();
object cddr();
object caaar();
object caadr();
object cadar();
object caddr();
object cdaar();
object cdadr();
object cddar();
object cdddr();
object caaaar();
object caaadr();
object caadar();
object caaddr();
object cadaar();
object cadadr();
object caddar();
object cadddr();
object cdaaar();
object cdaadr();
object cdadar();
object cdaddr();
object cddaar();
object cddadr();
object cdddar();
object cddddr();
#define MMcons(a,d)	make_cons((a),(d))
#define MMcar(x)	(x)->c.c_car
#define MMcdr(x)	(x)->c.c_cdr
#define CMPcar(x)	(x)->c.c_car
#define CMPcdr(x)	(x)->c.c_cdr
#define CMPcaar(x)	(x)->c.c_car->c.c_car
#define CMPcadr(x)	(x)->c.c_cdr->c.c_car
#define CMPcdar(x)	(x)->c.c_car->c.c_cdr
#define CMPcddr(x)	(x)->c.c_cdr->c.c_cdr
#define CMPcaaar(x)	(x)->c.c_car->c.c_car->c.c_car
#define CMPcaadr(x)	(x)->c.c_cdr->c.c_car->c.c_car
#define CMPcadar(x)	(x)->c.c_car->c.c_cdr->c.c_car
#define CMPcaddr(x)	(x)->c.c_cdr->c.c_cdr->c.c_car
#define CMPcdaar(x)	(x)->c.c_car->c.c_car->c.c_cdr
#define CMPcdadr(x)	(x)->c.c_cdr->c.c_car->c.c_cdr
#define CMPcddar(x)	(x)->c.c_car->c.c_cdr->c.c_cdr
#define CMPcdddr(x)	(x)->c.c_cdr->c.c_cdr->c.c_cdr
#define CMPcaaaar(x)	(x)->c.c_car->c.c_car->c.c_car->c.c_car
#define CMPcaaadr(x)	(x)->c.c_cdr->c.c_car->c.c_car->c.c_car
#define CMPcaadar(x)	(x)->c.c_car->c.c_cdr->c.c_car->c.c_car
#define CMPcaaddr(x)	(x)->c.c_cdr->c.c_cdr->c.c_car->c.c_car
#define CMPcadaar(x)	(x)->c.c_car->c.c_car->c.c_cdr->c.c_car
#define CMPcadadr(x)	(x)->c.c_cdr->c.c_car->c.c_cdr->c.c_car
#define CMPcaddar(x)	(x)->c.c_car->c.c_cdr->c.c_cdr->c.c_car
#define CMPcadddr(x)	(x)->c.c_cdr->c.c_cdr->c.c_cdr->c.c_car
#define CMPcdaaar(x)	(x)->c.c_car->c.c_car->c.c_car->c.c_cdr
#define CMPcdaadr(x)	(x)->c.c_cdr->c.c_car->c.c_car->c.c_cdr
#define CMPcdadar(x)	(x)->c.c_car->c.c_cdr->c.c_car->c.c_cdr
#define CMPcdaddr(x)	(x)->c.c_cdr->c.c_cdr->c.c_car->c.c_cdr
#define CMPcddaar(x)	(x)->c.c_car->c.c_car->c.c_cdr->c.c_cdr
#define CMPcddadr(x)	(x)->c.c_cdr->c.c_car->c.c_cdr->c.c_cdr
#define CMPcdddar(x)	(x)->c.c_car->c.c_cdr->c.c_cdr->c.c_cdr
#define CMPcddddr(x)	(x)->c.c_cdr->c.c_cdr->c.c_cdr->c.c_cdr
#define CMPfuncall	funcall
#define	cclosure_call	funcall
object simple_lispcall();
object simple_lispcall_no_event();
object simple_symlispcall();
object simple_symlispcall_no_event();
struct symbol Cnil_body, Ct_body;
object MF();
object MM();
object Scons;
object siSfunction_documentation;
object siSvariable_documentation;
object siSpretty_print_format;
object Slist;
object keyword_package;
object alloc_object();
object car();
object cdr();
object list();
object listA();
object coerce_to_string();
object elt();
object elt_set();
frame_ptr frs_sch();
frame_ptr frs_sch_catch();
object make_cclosure();
object nth();
object nthcdr();
object make_cons();
object append();
object nconc();
object reverse();
object nreverse();
object number_expt();
object number_minus();
object number_negate();
object number_plus();
object number_times();
object one_minus();
object one_plus();
object fixnum_times();
object times_plus();
object get();
object getf();
object putprop();
object remprop();
object string_to_object();
object symbol_function();
object symbol_name();
object symbol_value();
object make_fixnum();
object make_shortfloat();
object make_longfloat();
object structure_ref();
object structure_set();
object princ();
object prin1();
object print();
object terpri();
object aref();
object aset();
object aref1();
object aset1();
char object_to_char();
int object_to_int();
char *object_to_string();
float object_to_float();
double object_to_double();
object TYPE_OF();
#define Creturn(v)	return((vs_top=vs,(v)))
#define Cexit		return((vs_top=vs,0))
double sin(), cos(), tan();
#ifdef MTCL

#define BDSSIZE 1024
#define BDSGETA 16
#define IHSSIZE 1024
#define IHSGETA 32
#define FRSSIZE 1024
#define FRSGETA 16

#define VSSIZE 8192
#define VSGETA 128

typedef struct lpd {
  struct bds_bd lwp_bind_stack[BDSSIZE + BDSGETA + BDSGETA];
  bds_ptr lwp_bds_limit;
  bds_ptr lwp_bds_top;
  int lwp_cssize;
  int *lwp_cs_org;
  int *lwp_cs_limit;
  struct invocation_history lwp_ihs_stack[IHSSIZE + IHSGETA + IHSGETA];
  ihs_ptr lwp_ihs_limit;
  ihs_ptr lwp_ihs_top;
  struct frame lwp_frame_stack[FRSSIZE + FRSGETA + FRSGETA];
  frame_ptr lwp_frs_limit;
  frame_ptr lwp_frs_top;
  bool lwp_nlj_active;
  frame_ptr lwp_nlj_fr;
  object lwp_nlj_tag;
  object *lwp_lex_env;
  object lwp_value_stack[VSSIZE + VSGETA + VSGETA];
  object *lwp_vs_limit;
  object *lwp_vs_base;
  object *lwp_vs_top;
  object lwp_alloc_temporary;
  int lwp_backq_level;
  object lwp_bind_temporary;
  object lwp_endp_temp;
  int lwp_eval1;
  object lwp_eval_temporary;
  int (*lwp_fmt_ch_fun)();
  object lwp_fmt_stream;
  int lwp_ctl_origin;
  int lwp_ctl_index;
  int lwp_ctl_end;
  object *lwp_fmt_base;
  int lwp_fmt_index;
  int lwp_fmt_end;
  int *lwp_fmt_jmp_buf;
  int lwp_fmt_indents;
  object lwp_fmt_string;
  object lwp_fmt_temporary_stream;
  object lwp_fmt_temporary_string;
  int lwp_fmt_nparam;
  struct {
    int fmt_param_type;
    int fmt_param_value;
  } lwp_fmt_param[100];
  int lwp_fmt_spare_spaces;
  int lwp_fmt_line_length;
  object lwp_thread_fun;
  object lwp_thread;
  object lwp_test_function;
  object lwp_item_compared;
  bool (*lwp_tf)();
  object lwp_key_function;
  object (*lwp_kf)();
  int lwp_intern_flag;
  object *lwp_PRINTvs_top;
  object *lwp_PRINTvs_limit;
  object lwp_PRINTstream;
  bool lwp_PRINTescape;
  bool lwp_PRINTpretty;
  bool lwp_PRINTcircle;
  int lwp_PRINTbase;
  bool lwp_PRINTradix;
  object lwp_PRINTcase;
  bool lwp_PRINTgensym;
  int lwp_PRINTlevel;
  int lwp_PRINTlength;
  bool lwp_PRINTarray;
  bool lwp_PRINTpackage;
  bool lwp_PRINTstructure;
  int (*lwp_write_ch_fun)();
  int (*lwp_output_ch_fun)();
#define Q_SIZE    128
#define IS_SIZE   256
  short lwp_queue[Q_SIZE];
  short lwp_indent_stack[IS_SIZE];
  int lwp_qh;
  int lwp_qt;
  int lwp_qc;
  int lwp_isp;
  int lwp_iisp;
  object lwp_READtable;
  int lwp_READdefault_float_format;
  int lwp_READbase;
  bool lwp_READsuppress;
  bool lwp_preserving_whitespace_flag;
  bool lwp_escape_flag;
  object lwp_delimiting_char;
  bool lwp_detect_eos_flag;
  bool lwp_in_list_flag;
  bool lwp_dot_flag;
  object lwp_default_dispatch_macro;
  object lwp_big_register_0;
  int lwp_sharp_eq_context_max;
  object (*lwp_read_ch_fun)();
  int lwp_sign;
  int lwp_boundary;
  bool lwp_left_trim;
  bool lwp_right_trim;
  int (*lwp_casefun)();
  object lwp_string_register;
  object lwp_gensym_prefix;
  object lwp_gentemp_prefix;
  object lwp_token;
} lpd;

extern lpd *clwp;
#endif

object make_cfun();
#ifdef CLOS
object instance_ref();
#endif CLOS
object memq();
object memql();
object member();
object assq();
object assql();
object assqlp();
object assoc();

#ifdef PDE
extern object siVsource_pathname;
#endif PDE

/* for PROLOG */
extern object *alloc_relblock();
extern object *slot;
extern object (*slotf)();
extern object *trail[];
extern object **trail_top;
#define	trail_push(loc)		(*trail_top++ = (loc))
#define	trail_pop		(**--trail_top = OBJNULL)
#define BIND(loc, val)		{loc = val; trail_push(&loc);}
#define trail_mark		trail_push((object *)NULL)
#define trail_restore	{while (trail_top[-1] != (object *)NULL) trail_pop;}
#define trail_unmark		{trail_restore; trail_top--;}
#define get_value(v, x)		unify(x, v)
#define get_constant(c, x)	(c == x || unify(x, c))
#define get_nil(x)		(Cnil == x || unify(x, Cnil))
#define unify_slot		(*slotf)(*slot)
#define unify_value(loc)	(*slotf)(loc)
#define unify_constant(c)	(*slotf)(c)
#define unify_nil		(*slotf)(Cnil)

/* these should go away. Beppe*/
#define CMPmake_fixnum(n)	((object)(((int)(n) << 2) | 1))
#define make_fixnum(n)	((object)(((int)(n) << 2) | 1))
#define small_fixnum(n)	((object)(((int)(n) << 2) | 1))
