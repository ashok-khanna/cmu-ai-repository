/*
 * life.c
 *
 * Conway's game of life on a torus, for a black&white Sun screen (/dev/bwtwo0).
 * Uses a very clever method of calculating 32 positions at once.
 * I don't know who invented it, but Lew Hitchner gave it as an assignment
 * in his Computer Architecture course at UCSC.
 * I optimized it as much as I could, so even I don't understand it any more.
 *
 * On a sparc (compiled with -O) it gives about 6.8 frames per second
 * full screen, and proportionately faster on smaller regions.
 *
 * Usage: life [-i] [<x> <y> <w> <h>]
 *    x is rounded down to a multiple of 32,
 *    w is rounded up to a multiple of 32.
 *    Default is the full screen.
 *
 * The -i option makes it incorporate externally generated screen changes
 * (such as cursor movement and clock refreshes) into the calculations,
 * but it runs about half as fast.
 * 
 * Environment options:
 *      LIFETIMES --    If set and nonnegative, program exits after
 *                      this many generations
 *      LIFE_USEC --    If set and positive, the program pauses between
 *                      generations if necessary so that each generation
 *                      takes at least this many microseconds
 *      LIFE_FB --      Name of frame buffer device (default is /dev/bwtwo0)
 *      LIFE_OFF --     Offset into frame buffer device (default is 0)
 *
 * Compiling notes:
 *      Default is white life on black background, assuming the frame buffer
 *      uses 1 for black and 0 for white.
 *      If you want it to be black on white, xor your frame buffer
 *      does it the opposite way,
 *      compile with: (cut and paste the following line)
                cc -O -DBLACK_ON_WHITE life.c -o life
 *      otherwise just say
                cc -O life.c -o life
 *
 * Author: Don Hatch (hatch@math.berkeley.edu)
 * Last modified: Mon Jun  8 17:01:13 PDT 1992
 *
 * This program may be distributed freely.
 * If you like it, please send me money or give me a job.
 * Comments and suggestions are welcome regardless.
 */

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <pixrect/pixrect_hs.h>

#define SIZEX BW2SIZEX
#define SIZEY BW2SIZEY

#define LIFE_FB "/dev/bwtwo0"


#define ADD21(B1,B0, x) \
       (carry = (x), \
        B0 ^= carry, \
        carry &=~ B0, \
        B1 ^= carry)
#define ADD31(B2,B1,B0, x) \
       (ADD21(B1,B0, x), \
        carry &=~ B1, \
        B2 ^= carry)
#define ADD32(B2,B1,B0, X1,X0) \
       (ADD21(B2,B1, X1), \
        ADD31(B2,B1,B0, X0))

#ifdef BLACK_ON_WHITE
#define RESULT(B2,B1,B0,self) (((B2)^(B1)) & ((B2)^(B0)) & ((B0)|(self)))
#else
#define RESULT(B2,B1,B0,self) (~(B2) | (~(B1)^(B0)) | (~(B1) & (self)))
#endif

#define SET21(T1,T0, F0)        SET22(T1,T0, 0, F0)
#define SET22(T1,T0, F1,F0)     ((T1)=(F1), (T0)=(F0))
#define SET32(T2,T1,T0, F1,F0)  ((T2)=0, (T1)=(F1), (T0)=(F0))
#define SUMleftmidright(B1,B0, l,m,r) \
       (SET21(B1,B0, tmp=(m)), \
        ADD21(B1,B0, (tmp>>1)|((l)<<31)), \
        ADD21(B1,B0, (tmp<<1)|((r)>>31)))

#define SWAP(a,b) {u_int (*_temp_)[SIZEX/32] = (a); (a) = (b); (b) = _temp_;}
            
            


/* VARARGS */
life(src, dst, h, w, i, j)
u_int src[][SIZEX/32];
register u_int dst[][SIZEX/32];
register int h, w;
register int i, j;              /* really local variables */
{
    register u_int SUM2,SUM1,SUM0,carry, tmp;
    register u_int *rightcol, *leftcol, *midcol;

    /*
     * These probably won't get registers, but that's okay
     */
    register u_int BOT1,BOT0;
    register u_int MID1,MID0;
    register u_int TOP1,TOP0;
    register u_int VERYTOP1,VERYTOP0;

    for (j = 0; j < w; ++j) {
        leftcol =  &src[h-1][(j-1+w)%w];
        midcol =   &src[h-1][j];
        rightcol = &src[h-1][(j+1)%w];
        SUMleftmidright(SUM1,SUM0, *leftcol, *midcol, *rightcol);
        SET22(TOP1, TOP0, SUM1, SUM0);
        leftcol =  &src[0][(j-1+w)%w];
        midcol =   &src[0][j];
        rightcol = &src[0][(j+1)%w];
        SUMleftmidright(SUM1,SUM0, *leftcol, *midcol, *rightcol);
        SET22(MID1, MID0, VERYTOP1=SUM1, VERYTOP0=SUM0);
        for (i = 0; i < h-1; ++i) {
            leftcol += SIZEX/32;
            midcol += SIZEX/32;
            rightcol += SIZEX/32;
            SUMleftmidright(SUM1,SUM0, *leftcol, *midcol, *rightcol);
            SET22(BOT1, BOT0, SUM1, SUM0);
            SUM2=0;
            ADD32(SUM2,SUM1,SUM0, MID1, MID0);
            ADD32(SUM2,SUM1,SUM0, TOP1, TOP0);
            dst[i][j] = RESULT(SUM2,SUM1,SUM0, src[i][j]);
            SET22(TOP1,TOP0, MID1,MID0);
            SET22(MID1,MID0, BOT1,BOT0);
        }
        SET32(SUM2,SUM1,SUM0, VERYTOP1,VERYTOP0);
        ADD32(SUM2,SUM1,SUM0, MID1, MID0);
        ADD32(SUM2,SUM1,SUM0, TOP1, TOP0);
        dst[i][j] = RESULT(SUM2,SUM1,SUM0, src[i][j]);
    }
}

/* VARARGS */
copy(src, dst, h, w)
register u_int src[][SIZEX/32];
register u_int dst[][SIZEX/32];
register int h, w;
{
    register int i, j;
    for (i = 0; i < h; ++i) {
        for (j = 0; j < w; ++j) {
            dst[0][j] = src[0][j];
        }
        src++;
        dst++;
    }
}

void ring()
{
}

main(argc, argv)
char **argv;
{
    int argi;
    u_int (*screen)[SIZEX/32], (*next)[SIZEX/32], (*prev)[SIZEX/32];
    int x=0, y=0, w=SIZEX, h=SIZEY;
    int interactive = 0;
    int usec = 0;
    int times=-1;
    int fd;
    char *fbname = LIFE_FB;
    if (getenv("LIFE_FB"))
        fbname = getenv("LIFE_FB");

    for (argi = 1; argi < argc; ++argi) {
        if (!strcmp(argv[argi], "-i"))
            interactive = 1;
        else if (argi+3 < argc) {
            x = atoi(argv[argi++]);
            y = atoi(argv[argi++]);
            w = atoi(argv[argi++]);
            h = atoi(argv[argi]);
        } else {
            (void) fprintf(stderr, "Usage: %s [-i] [<x> <y> <w> <h>]\n",
                                           argv[0]);
            exit(1);
        }
    }

    /*
     * From the user's perspective, x is rounded down to a multiple of 32
     * and w is rounded up to a multiple of 32.
     */
    x = x / 32;
    w = howmany(w, 32);

    if (w > SIZEX/32-x)
        w = SIZEX/32-x;
    if (h > SIZEY-y)
        h = SIZEY-y;


    if (getenv("LIFETIMES"))
        times = atoi(getenv("LIFETIMES"));
    if (getenv("LIFE_USEC"))
        usec = atoi(getenv("LIFE_USEC"));
        
    /*
     * Get the frame buffer as a chunk of memory.
     * This could also be done by:
     *          screen = (int (*)[SIZEX/32])(mpr_d(pr)->md_image);
     * where pr is a pixrect referring to the screen.
     * But then you'd have to link with -lpixrect, producing
     * a needlessly big executable...
     */
    if ((fd = open(fbname, O_RDWR)) == -1)
        perror(fbname), exit(1);
    screen = (u_int (*)[SIZEX/32])mmap((caddr_t)NULL,
                    SIZEY*sizeof(*screen),
                    PROT_READ|PROT_WRITE, MAP_SHARED, fd,
                    (off_t) (getenv("LIFE_OFF") ? atoi(getenv("LIFE_OFF")) :0));
    if ((int)screen == -1)
        perror("mmap"), exit(1);
    (void) close(fd);


    next = (u_int (*)[SIZEX/32])malloc(SIZEY * SIZEX/32 * sizeof(int));
    if (!next)
        perror("malloc"), exit(1);
    if (!interactive) {
        prev = (u_int (*)[SIZEX/32])malloc(SIZEY * SIZEX/32 * sizeof(int));
        if (!prev)
            perror("malloc"), exit(1);
    } else
        prev = 0;

    (void) signal(SIGALRM, ring);

    if (prev)
        copy(&screen[y][x], &prev[y][x], h, w);

    while (times--) {
        if (usec) {
            struct itimerval it, oit;
            timerclear(&it.it_interval);
            timerclear(&it.it_value);
            it.it_value.tv_sec = usec / 1000000;
            it.it_value.tv_usec = usec % 1000000;
            (void) sigblock(sigmask(SIGALRM));
            if (setitimer(ITIMER_REAL, &it, &oit) < 0)
                perror("setitimer"), exit(1);;
        }
        if (interactive) {
            /*
             * "Interactive" mode.
             * Calculate new generation into back buffer from screen,
             * then copy back buffer to screen.
             * This is slow, since accessing the frame buffer is
             * slower than accessing "normal" memory.
             * .306 seconds/screen on a sparc
             */
            life(&screen[y][x], &next[y][x], h, w);
            copy(&next[y][x], &screen[y][x], h, w);
        } else {
            /*
             * This is the fastest mode, and is the default.
             * it calculates the new generations using only
             * the "prev" and "next" arrays, which
             * seems to be faster than accessing the frame buffer
             * memory directly.  The disadvantage is that there
             * can be no input except what is on the screen
             * at startup.
             * (Sometimes it is fun to let it run on top of a clock
             * or to violate the prime directive with the mouse.)
             * Also this mode uses an extra screen-sized chunk of memory.
             * .148 seconds/screen on a sparc
             */
            life(&prev[y][x], &next[y][x], h, w);
            copy(&next[y][x], &screen[y][x], h, w);
            SWAP(prev, next);
        }
        if (usec)
            (void) sigpause(0);
    }
    return 0;
}
