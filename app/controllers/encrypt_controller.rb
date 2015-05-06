class EncryptController < ApplicationController
 l=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

	def encrypt_plaiyfair(key,text)
		  l=["a","b","c","d","e","f","g","h","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
		  l1=["a","b","c","d","e","f","g","h","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
		  ciphertext=""
		  array=key[0,24].gsub(" ","").downcase
		  array=array.split("")
		  if array.index("i")
		  array[array.index("i")]="j"
		end
		  array=array.uniq.join("")
		  tmp=25-array.length
		  array.split("").each do |x|
		  	l1.delete(x)
		  end
		  array=array+l1[0,tmp].join("")
		  array=array.split("")
			text=text.gsub(" ","")
		counter=0
		(0..text.length - 1).step(2).each do |index|
				c=""
				d=""
				a=text[index]
				b=text[index+1]

				if a==b
					text.insert(index+1,"x")
				end
		end

		while text.length%2 !=0
			text=text+"x"
		end
			(0..text.length - 1).step(2).each do |index|

				c=""
				d=""
				a=text[index]
				b=text[index+1]
				if a=="i"
					a="j"
				end
				if b=="i"
					b="j"
				end

				row1=array.index(a)/5
				col1=array.index(a)%5
				row2=array.index(b)/5
				col2=array.index(b)%5
				if row1 == row2 
            		if col1 == 4
             			c = array[row1*5] 
            		else 
             			c = array[row1*5 + col1 + 1]
            		end
            		if col2 == 4
            			d = array[row2*5]
            		else
            			d = array[row2*5 + col2 + 1]
         			end
           		elsif col1 == col2 
            		if row1 == 4 
            			c = array[col1]
          			else 
            			c = array[(row1+1)*5 + col1]
           			end
            		if row2 == 4
             			d = array[col2]
            		else
            			d = array[(row2+1)*5 + col2]
         			end
        		else
            		c = array[row1*5 + col2]
            		d = array[row2*5 + col1]
        		end
        		ciphertext += c + d;
			end

			return ciphertext
	end
	
	def decrypt_plaiyfair(key,cipher)
				  l=["a","b","c","d","e","f","g","h","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
		  l1=["a","b","c","d","e","f","g","h","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
		  plaintext=""
		  array=key[0,24].gsub(" ","").downcase
		  array=array.split("")
		  if array.index("i")
		  array[array.index("i")]="j"
		end
		  array=array.uniq.join("")
		  tmp=25-array.length
		  array.split("").each do |x|
		  	l1.delete(x)
		  end
		  array=array+l1[0,tmp].join("")
		  array=array.split("")

		  counter=23
		cipher=cipher.gsub(" ","")
		while cipher.length%2 !=0
			cipher=cipher+"x"
			counter=(counter+1)%26
		end


			(0..cipher.length - 1).step(2).each do |index|
				c=""
				d=""
				a=cipher[index]
				b=cipher[index+1]
				if a==b
					b="x"
				end

				row1=array.index(a)/5
				col1=array.index(a)%5
				row2=array.index(b)/5
				col2=array.index(b)%5
				if row1 == row2 
            		if col1 == 0
             			c = array[row1*5 + 4]
            		else 
             			c = array[row1*5 + col1 - 1]
            		end
            		if col2 == 0 
            			d = array[row2*5]
            		else
            			d = array[row2*5 + col2 - 1]
         			end
           		elsif col1 == col2 
            		if row1 == 0
            			c = array[20+col1]
          			else 
            			c = array[(row1-1)*5 + col1]
           			end
            		if row2 == 0 
             			d = array[20+col2]
            		else
            			d = array[(row2-1)*5 + col2]
         			end
        		else
            		c = array[row1*5 + col2]
            		d = array[row2*5 + col1]
        		end
        		plaintext += c + d;
			end

			return plaintext

	end
	def index
	end
	def display
	end

	def playfair
		s=params
		key=s[:key]
		if s[:type]=="encrypt"
			text=encrypt_plaiyfair(key,s[:text])
		else
		  	text=decrypt_plaiyfair(key,s[:text])
		end
		render :text => text
	end

	def hillcipher

		s=params
		key=s[:key].values
		new_key=[]
		key.each do |x|
			current_key=[]
			x.each do |y|
				current_key<<y.to_i
			end
			new_key<<current_key
		end

		key=new_key

		if s[:type]=="encrypt"
			text=encrypt_hill_cipher(s[:key_length].to_i,key,s[:text])
		else
			if s[:key_length].to_i==2
		  		text=decryp_hill_cipher(2,key,s[:text])
		  	else
		  		text="nothing"
		  	end

		end

		render :text=>text

	end


	def encrypt_hill_cipher(type,key,text)
  l=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
		if type==2
		cipher=[]
		counter=23
		text=text.gsub(" ","")
		while text.length%2 !=0
			text=text+l[counter]
			counter=(counter+1)%26
		end
		puts text
		t=text.downcase.scan(/../)
		k=key
			t.each do |y|	
				y=y.split("")
				k.each do |z|
					cipher<<l[((z[0]*l.index(y[0]))+(z[1]*l.index(y[1])))%26]
				end
			end
		else
		cipher=[]
		counter=23
		text=text.gsub(" ","")
		while text.length%3 !=0
			text=text+l[counter]
			counter=(counter+1)%26
		end
		puts text
		t=text.downcase.scan(/.../)
		k=key
			t.each do |y|	
				y=y.split("")
				k.each do |z|
					cipher<<l[((z[0]*l.index(y[0]))+(z[1]*l.index(y[1]))+(z[2]*l.index(y[2])))%26]
				end
			end

		end

		cipher=cipher.join("")
		return cipher
	end

	def decryp_hill_cipher(type,key,cipher)
		  l=["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

 		if type==2
    		det = key[0][0]*key[1][1] - key[0][1]*key[1][0]
    		det =((det%26)+26)%26
    		di=0

    		l.each_with_index do |x ,i|
    			if (det*i)%26 == 1
    				di = i
    			end

    		end
    		if di == 0
    			return "this matrix has no inverse"
    	    end

    	    invkey=[[(key[1][1]%26)*di,(-1*key[0][1]%26)*di],[(-1*key[1][0]%26)*di,(key[0][0]%26)*di]]
			text=encrypt_hill_cipher(2,invkey,cipher)

		else
			text="nothing to do"
		end
		text

end
end
