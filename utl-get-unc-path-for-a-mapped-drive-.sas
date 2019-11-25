Get unc path for a mapped drive                                                                      
                                                                                                     
github                                                                                               
https://github.com/rogerjdeangelis/utl-get-unc-path-for-a-mapped-drive-                              
                                                                                                     
SAS Forum                                                                                            
https://tinyurl.com/qpnqa44                                                                          
https://communities.sas.com/t5/SAS-Programming/Get-UNC-path-for-a-mapped-drive/td-p/483337           
                                                                                                     
                                                                                                     
Note if you try to do this                                                                           
                                                                                                     
libname unc "h:/";                                                                                   
%put %sysfunc(pathname(unc));                                                                        
                                                                                                     
you get                                                                                              
                                                                                                     
h:\                                                                                                  
                                                                                                     
*_                   _                                                                               
(_)_ __  _ __  _   _| |_                                                                             
| | '_ \| '_ \| | | | __|                                                                            
| | | | | |_) | |_| | |_                                                                             
|_|_| |_| .__/ \__,_|\__|                                                                            
        |_|                                                                                          
;                                                                                                    
                                                                                                     
%let uncmap=H;                                                                                       
                                                                                                     
*            _               _                                                                       
  ___  _   _| |_ _ __  _   _| |_                                                                     
 / _ \| | | | __| '_ \| | | | __|                                                                    
| (_) | |_| | |_| |_) | |_| | |_                                                                     
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                    
                |_|                                                                                  
;                                                                                                    
                                                                                                     
drive letter is H:                                                                                   
path is \\xxxxxxxxxxx\xxxx\aaaaaaaa_xxxxxxx\roger                                                    
                                                                                                     
*                                                                                                    
 _ __  _ __ ___   ___ ___  ___ ___                                                                   
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                  
| |_) | | | (_) | (_|  __/\__ \__ \                                                                  
| .__/|_|  \___/ \___\___||___/___/                                                                  
|_|                                                                                                  
;                                                                                                    
                                                                                                     
FILENAME SASCBTBL CATALOG "work.temp.attrfile.source";                                               
                                                                                                     
DATA _NULL_;                                                                                         
FILE SASCBTBL;                                                                                       
    PUT "ROUTINE WNetGetConnectionA MODULE=MPR MINARG=3 MAXARG=3 STACKPOP=CALLED RETURNS=LONG;";     
    PUT "  ARG 1 CHAR INPUT BYADDR FORMAT=$CSTR200.;";                                               
    PUT "  ARG 2 CHAR UPDATE BYADDR FORMAT=$CSTR200.;";                                              
    PUT "  ARG 3 NUM UPDATE BYADDR FORMAT=PIB4.;";                                                   
RUN;                                                                                                 
                                                                                                     
%MACRO getUNC ;                                                                                      
  DATA _NULL_;                                                                                       
  length input_dir $200 output_dir $200;                                                             
  * The input directory can only be a drive letter + colon ONLY e.g. j: ;                            
  input_dir = "&H";                                                                                  
  output_dir = ' ';                                                                                  
  output_len = 200;                                                                                  
  call module("WNetGetConnectionA", input_dir, output_dir, output_len);                              
  call symputx('dir',input_dir,'l');                                                                 
  call symputx('path',output_dir,'l');                                                               
  RUN;                                                                                               
  %put drive letter is &dir;                                                                         
  %put path is &path;                                                                                
%MEND getunc;                                                                                        
                                                                                                     
%getunc;                                                                                             
                                                                                                     
