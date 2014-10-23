
# Elimina le mutazioni del paziente dai vettori e dalle frequenze

def eli()
	m=open("/home/andrea/Polo/CosmicParser/Andrea_Garafoli/Clone/arrayO.txt").readlines.map{ |i| i.chomp.to_s}
	# file con la matrice filtrata
	n=open("/home/andrea/Polo/CosmicParser/Andrea_Garafoli/Clone/arrayF.txt").readlines.map{ |i| i.chomp.to_s}
	# lista delle frequenze filtrate
	p"eliminazione mutazioni"

	h=["CHR","LOC","14A","23N","14C","23C","18B","18N","23B","18C","14B","BiBC20","\n"]
	h[2]=nil
	h=h.compact.join("\t")
	File.open("arrayinc2.txt", "w") {|f| f.write(h)}

	hf=["freq","\n"].join("\t")
	File.open("arrayfreq2.txt", "w") {|f| f.write(hf)}

	m.size.times{ |x|
		m[x]=m[x].split("\t")
		n[x]=n[x].split("\t")
		if x!=0 then
			if m[x][2].to_i==1 then
				m[x]=n[x]=nil
			else
				m[x][2]=nil
				m[x]=m[x].compact	
				m[x]=m[x].join("\t")
				n[x]=n[x].join("\t")	
			end
		else 
			m[x][2]=nil
			m[x]=m[x].compact
			m[x]=m[x].join("\t")
		end
	}
	m=m.compact
	n=n.compact
	
	p "creazione file .txt"
	File.open("arrayinc2.txt", "a") {|f| f.write(m.join("\n"))}
	# file con il doppio filtro frequenze/paziente sano
	# NB: ci sono ancora crom e loc, da levare altrimenti lo script di Clonality non lo legge
	File.open("arrayfreq2.txt", "a") {|f| f.write(n.join("\n"))}
	# file con le frequenze filtrate con il doppio filtro

	#  NB:  entrambi i file sono da aprire con excel/calc e salvare in .xls
	# 	per farlo leggere da Clonality

# per creare direttamente i file .xls
# ma serve una libreria aggiuntiva e altro codice

#	m.size.times{ |x|
#		m[x]=m[x].split("\t")
#		m[x][0]=m[x][1]=nil
#	
#		m[x]=m[x].compact	
#		m[x]=m[x].join("\t")
#	}
#
#	c=0.0000
#	n.size.times{ |x|
#		a=n[x].partition('/').first.to_f
#		b=n[x].partition('/').last.to_f
#
#		c=(a/b).round(5)
#		n[x]=c
#
#	}
#	p "creazione file .xls"
#	File.open("arrayinc2.xls", "w") {|f| f.write(m.join("\n"))}
#	File.open("arrayfreq2.xls", "w") {|f| f.write(n.join("\n"))}
#
end

eli()
