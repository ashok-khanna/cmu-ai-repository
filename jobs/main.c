#include <windows.h>
#include <stdio.h>

LRESULT CALLBACK WindowProcedure (HWND, UINT, WPARAM, LPARAM);


char szClassName[ ] = "WindowsApp";

int hDC;

Display320x240d24BitDibBmp()
{
 int x, y;
 int RGB[2];
 FILE *pFile; 


   pFile = fopen("RGB-320x240-24-bit.bmp","rb");
   fseek( pFile , 54, SEEK_SET);

   for( y = 240-1; y >=0 ; y--) 
    for( x = 0; x < 320; x++)
     {
      fread ( &RGB[0], 1, 3, pFile);
      SetPixel( hDC, x, y, RGB[0]);
       }
   
   fclose (pFile); 
   
   return 0;
 }

Display320x240d24BitBmp()
{
 int x, y;
 int RGB[2];
 FILE *pFile; 


   pFile = fopen("RGB-320x240-24-bit.bmp","rb");
   fseek( pFile , 54, SEEK_SET);

   for( y = 0; y < 240; y++) 
    for( x = 0; x < 320; x++)
     {
      fread ( &RGB[0], 1, 3, pFile);
      SetPixel( hDC, x, y, RGB[0]);
       }
   
   fclose (pFile); 
   
   return 0;
 }

Display640x480d24BitDibBmp()
{
 int x, y;
 int RGB[2];
 FILE *pFile; 


   pFile = fopen("RGB-150x150-640x480-24-bit.bmp","rb");
   fseek( pFile , 54, SEEK_SET);

   for( y = 480-1; y >= 0; y--) 
    for( x = 0; x < 640; x++)
     {
      fread ( &RGB[0], 1, 3, pFile);
      SetPixel( hDC, x, y, RGB[0]);
       }
   
   fclose (pFile); 
   
   return 0;
 }

Display640x480d24BitBmp()
{
 int x, y;
 int RGB[2];
 FILE *pFile; 


   pFile = fopen("RGB-150x150-640x480-24-bit.bmp","rb");
   fseek( pFile , 54, SEEK_SET);

   for( y = 0; y < 480; y++) 
    for( x = 0; x < 640; x++)
     {
      fread ( &RGB[0], 1, 3, pFile);
      SetPixel( hDC, x, y, RGB[0]);
       }
   
   fclose (pFile); 
   
   return 0;
 }



int WINAPI WinMain (HINSTANCE hThisInstance,
                    HINSTANCE hPrevInstance,
                    LPSTR lpszArgument,
                    int nFunsterStil)

{
    HWND hwnd;              
    MSG messages;            
    WNDCLASSEX wincl;        

  
    wincl.hInstance = hThisInstance;
    wincl.lpszClassName = szClassName;
    wincl.lpfnWndProc = WindowProcedure;     
    wincl.style = CS_DBLCLKS;                 
    wincl.cbSize = sizeof (WNDCLASSEX);


    wincl.hIcon = LoadIcon (NULL, IDI_APPLICATION);
    wincl.hIconSm = LoadIcon (NULL, IDI_APPLICATION);
    wincl.hCursor = LoadCursor (NULL, IDC_ARROW);
    wincl.lpszMenuName = NULL;                 /* No menu */
    wincl.cbClsExtra = 0;                      /* No extra bytes after the window class */
    wincl.cbWndExtra = 0;                      /* structure or the window instance */

    wincl.hbrBackground = (HBRUSH) COLOR_WINDOW;


    if (!RegisterClassEx (&wincl))
        return 0;


    hwnd = CreateWindowEx (
           0,                   /* Extended possibilites for variation */
           szClassName,         /* Classname */
           "Windows App",       /* Title Text */
           WS_OVERLAPPEDWINDOW, /* default window */
           CW_USEDEFAULT,       /* Windows decides the position */
           CW_USEDEFAULT,       /* where the window ends up on the screen */
           660,                 /* The programs width */
           550,                 /* and height in pixels */
           HWND_DESKTOP,        /* The window is a child-window to desktop */
           NULL,                /* No menu */
           hThisInstance,       /* Program Instance handler */
           NULL                 /* No Window Creation data */
           );

    ShowWindow (hwnd, nFunsterStil);

     while (GetMessage (&messages, NULL, 0, 0))
    {
        TranslateMessage(&messages);
        DispatchMessage(&messages);
    }


    return messages.wParam;
}


LRESULT CALLBACK WindowProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
 PAINTSTRUCT ps;
 
 
    switch (message)                  
    {
        case WM_PAINT:
            hDC = BeginPaint( hwnd, &ps);
            
            Display320x240d24BitDibBmp();
            Display320x240d24BitBmp();
            Display640x480d24BitDibBmp(); 
            Display640x480d24BitBmp();
             
            EndPaint( hwnd, &ps);  
            return 0;   

        case WM_DESTROY:
            PostQuitMessage (0);  
            break;
        default:                
            return DefWindowProc (hwnd, message, wParam, lParam);
    }

    return 0;
}
