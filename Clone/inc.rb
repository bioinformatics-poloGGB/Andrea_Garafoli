
# Crea una nuova matrice usando solo mutazioni presenti
# nella matrice completa e in quella delle frequenze

m=open("/home/andrea/Polo/CosmicParser/Andrea_Garafoli/Clone/array.txt").readlines.map{ |i| i.chomp.to_s}		
# matrice con tutte le mutazioni e tutti i pazienti
n=open("/home/andrea/Polo/CosmicParser/Andrea_Garafoli/Clone/freqmutsort2.txt").readlines.map{ |i| i.chomp.to_s}
# lista delle frequenze in formato "crom-loc-freq", ordinate per n° di cromosoma e locus

o=[]
fr=[]

n.size.times{ |y| n[y]=n[y].split("\t") 	 }

co=m.size
con=n.size
$y=0
m.size.times{ |x|
	if x%500000==0 then puts "#{x}/#{co}" 
	elsif x==co then 
		puts "#{x}/#{co}" 
		break
	end
	if x!=0 && $y<(con-1) then 
		m[x]=m[x].split("\t")
		if m[x][0]!=n[$y][0] 
			x=x+1			
		end
		while $y<(con-1) && m[x][1].to_i > n[$y][1].to_i
			break if m[x][0]!=n[$y][0]
			$y=$y+1	
		end

		if m[x][0]==n[$y][0] && m[x][1].to_i==n[$y][1].to_i then
			m[x]=m[x].join("\t") 
			fr << n[$y][2].to_s
			o << m[x]
		end
		
	end
} 

p "Scrittura su file"


File.open("arrayO.txt", "w") {|f| f.write(o.join("\n"))}
# identico al file della matrice ma filtrato
File.open("arrayF.txt", "w") {|f| f.write(fr.join("\n"))}
# una lista con solo frequenze e solo quelle che combaciano con il file arrayO.txt

