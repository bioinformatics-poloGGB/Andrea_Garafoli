 class VCFp
    attr_reader :m
    attr_writer :m
    
    def rimc(i)
	p "Parsing del file #{i}"

      m=open("/home/andrea/Polo/Clone/VCF/#{i}").readlines.map{ |i| i.chomp.to_s}
      m.size.times{ |x|
        if m[x][0]=="#" then m[x]=NIL
        else
          m[x]=m[x].split("\t")

		if m[x][3].length!=1 ||  m[x][4].length!=1 then m[x]=nil
		else
		  m[x][5]=m[x][6]=m[x][3]=m[x][4]=m[x][7]=m[x][8]=m[x][9]="" 
		  m[x][2]=i.partition('p-').last
		  m[x][2]=m[x][2].partition('-v').first
		  m[x]=m[x].join("\t")         
		end 
        end
      }    
      m=m.compact
      m.delete_if {|x| x == nil}  
      File.open("#{i.partition('.').first}.txt", "w") {|f| f.write(m.join("\n"))}
	arr(m,i)
	
    end
	def arr(m,i)
		p "Inserimento delle mutazioni presenti in #{i}"
		
		m.size.times{ |x|
	      		m[x]=m[x].split("\t")
			p=m[x][2]
			10.times  { |y|	m[x][y+2]="0"}	
			H.size.times  { |y|  			
				if H[y]==p then m[x][y]="1"
			end}

	        	m[x]=m[x].join("\t")   	
		} 
		m[m.size]="\n"
		#m.insert(0,H)
		p=i.partition('p-').last
		p=p.partition('-v').first
   	        File.open("array#{p}.txt", "w") {|f| f.write(m.join("\n"))}
	end
  end

a=VCFp.new
f= Dir["/home/andrea/Polo/Clone/VCF/*"]

H=["CHR","LOC","14A","23N","14C","23C","18B","18N","23B","18C","14B","BiBC20","\n"]



f.size.times { |u|
	a.rimc(f[u].partition('F/').last) 
}

