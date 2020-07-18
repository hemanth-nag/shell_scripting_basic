chr() {
  [ "$1" -lt 256 ] || return 1
  printf "\\$(printf '%03o' "$1")"
}

ord() {
  LC_CTYPE=C printf '%d' "'$1"
  }
  
echo $'Press 1 to encode a file \nPress 2 to decode a file'
read choice
case "$choice" in 
1)  echo "Please enter name of the file to encode without .txt" 
    read name
    len=$(wc -c < $name.txt)
    for ((i=1; i<=$len; i++))
        do
         letter=$(cut -c $i $name.txt) 
         ascii_val=$(ord $letter)
         cipher_ascii=$(expr $ascii_val + 3)
         cipher_letter=$(chr $cipher_ascii)
         echo -n "$cipher_letter" >> ${name}_enc.txt
        done
     ;;
2)  echo "Please enter name of the file to decode without .txt" 
    read name
       len=$(wc -c < $name.txt)
       for ((i=1; i<=$len; i++))
           do
            letter=$(cut -c $i $name.txt) 
            ascii_val=$(ord $letter)
            cipher_ascii=$(expr $ascii_val - 3)
            cipher_letter=$(chr $cipher_ascii) 1>/dev/null
            if [$cipher_letter -eq $'\0'] 2>/dev/null
            then
            echo -n " " >> ${name}_decoded.txt 
            else
            echo -n "$cipher_letter" >> ${name}_decoded.txt
            fi
        done
    ;;
esac
        
