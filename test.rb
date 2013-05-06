require 'open-uri'
time = Time.now
string = "*&%^Boys Like Girls - Hero/Heroine"
string1 = "abc"
printf( "%-40s after time: %5.2f\n" , string , (Time.now - time) )
printf( "%-40s after time: %5d\n" , string1 , (Time.now - time).to_i )