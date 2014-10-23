
class VCFp
	attr_reader :m
	attr_writer :m
	    
	def rimc(i)
		p "Parsing del file #{i}"

		m=open("/home/andrea/Polo/CosmicParser/Andrea_Garafoli/Clone/VCF/#{i}").readlines.map{ |i| i.chomp.to_s}
		m.size.times{ |x|
			if m[x][0]=="#" then m[x]=NIL
			else
				m[x]=m[x].split("\t")

				if m[x][3].length!=1 ||  m[x][4].length!=1 then m[x]=nil
				else
					m[x][5]=m[x][6]=m[x][3]=m[x][4]=m[x][7]=m[x][8]=m[x][9]=nil
					m[x][2]=i.partition('p-').last
					m[x][2]=m[x][2].partition('-v').first
					m[x]=m[x].compact
					m[x]=m[x].join("\t")         
				end 
			end
		}     
		m=m.compact
		m.delete_if {|x| x == nil}  
#		m=m.sort_by{|k| [k[0].to_i, k[1].to_i]}
		File.open("#{i.partition('.').first}.txt", "w") {|f| f.write(m.join("\n"))}
		narr(m,i)
	end
end

def narr(m,i)
	p "Creazione dell'array delle mutazioni presenti in #{i}"
	m.size.times{ |x|
      		m[x]=m[x].split("\t")
		p=  m[x][2]

		10.times  { |y|  m[x][y+2]="0"		}	
		H.size.times  { |y|  			
			if H[y]==p then m[x][y]="1"
		end}
        	m[x]=m[x].join("\t")   	
	} 

	m=m.sort_by{|k| [k[1].to_i, k[0]]}
	m[m.size]=nil


	File.open("array.txt", "a") {|f| f.write(m.join("\n"))}
end

def sortA()

	p "Sorting dell'array"
	m=open("/home/andrea/Polo/CosmicParser/Andrea_Garafoli/Clone/array.txt").readlines.map{ |i| i.chomp.to_s}		
	
	co=m.size
	m.size.times{ |y| m[y]=m[y].split("\t") 	 }
	m= m.delete_if {|x| x == "\n"}  
	m=m.sort_by{|k| [k[0], k[1].to_i]}

	p "Merge dell'array"
	m.size.times{ |x|
		if m[x-1]!=nil && x!=0 && m[x][0]==m[x-1][0] && m[x][1]==m[x-1][1] then
		
			m[x-1][m[x].index("1")] = 1
			m[x]=	m[x-1]
			m[x-1]=nil
		end	
		if x%100000==0 then puts "#{x}/#{co}" 
		end
	} 

	p "Pulizia delle righe vuote e compattamento"
	m=m.compact
	m=m.unshift(H)
	m.size.times{ |y| m[y]=m[y].join("\t") 	}

	p "Scrittura su file"
	File.open("array.txt", "w") {|f| f.write(m.join("\n"))}
end

a=VCFp.new
f= Dir["/home/andrea/Polo/CosmicParser/Andrea_Garafoli/Clone/VCF/*"]

H=["CHR","LOC","14A","14B","14C","18B","18C","18N","23B","23C","23N","BiBC20"]
#H=["CHR","LOC","14A","23N","14C","23C","18B","18N","23B","18C","14B","BiBC20"]
File.open("array.txt", "w") {|f| f.write("")}

f.size.times { |u| a.rimc(f[u].partition('F/').last) }

sortA()

