evaluate-commands %sh{	
	echo "
	        # Code highlighting
		face global value     rgb:cfb017 
		face global type      rgb:0087ff
		face global variable  rgb:af5f5f
		face global module    rgb:00af00
		face global function  rgb:af8700
		face global string    rgb:5f5fff
		face global keyword   rgb:af0000
		face global operator  rgb:ff0000
		face global attribute rgb:b854d4
		face global comment   rgb:005f00
		face global meta      rgb:183691
		face global builtin   rgb:afaf00

		# Markdown highlighting
		face global title rgb:af0000+b   
		face global header rgb:cfb017+b     
		face global bold rgb:fefbec
		face global italic rgb:a6a28c   
		face global mono rgb:1fad83
		face global block red     
		face global link  blue    
		face global bullet cyan   
		face global list yellow    

		face global Default rgb:a6a28c,rgb:20201d    
		face global PrimarySelection default,rgb:373b41+fg 
		face global SecondarySelection default,rgb:373b41+fg
		face global PrimaryCursor black,rgb:fefbec+fg      
		face global SecondaryCursor black,rgb:fefbec+fg    
		face global PrimaryCursorEol black,rgb:a6a28c+fg  
		face global SecondaryCursorEol black,rgb:a6a28c+fg
		face global LineNumbers rgb:cfb017,rgb:20201d      
		face global LineNumberCursor rgb:fefbec,rgb:20201d+b   
		face global MenuForeground rgb:a6a28c,rgb:6684e1      
		face global MenuBackground rgb:fefbec,rgb:282828    
		face global MenuInfo red           
		face global Information white,rgb:282828       
		face global Error white,rgb:d73737              
		face global StatusLine rgb:7d7a68,rgb:20201d         
		face global StatusLineMode rgb:cfb017+b    
		face global StatusLineInfo rgb:6684e1    
		face global StatusLineValue rgb:60ac39    
		face global StatusCursor rgb:282828,rgb:6684e1      
		face global Prompt rgb:20201d,rgb:6684e1            
		face global MatchingChar rgb:cfb017,rgb:20201d+b       
		face global BufferPadding rgb:6684e1,rgb:20201d      
		face global Whitespace rgb:a6a28c+f         
	    "
}
