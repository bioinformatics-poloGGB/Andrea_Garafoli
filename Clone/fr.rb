
# Trasforma le frequenze da a/b a valori float(5)

def freq(i)
	m=open(i).readlines.map{ |i| i.chomp.to_s}
	c=0.0000
	m.size.times{ |x|
		if x!=0 then
		a=m[x].partition('/').first.to_f
		b=m[x].partition('/').last.to_f

		c=(a/b).round(5)
		p c
		m[x]=c
		end
	}
	File.open("out.txt", "w") {|f| f.write(m.join("\n"))}
end

freq("arrayfreq2.txt")
# il file con SOLO le frequenze (no crom/loc) già filtrate sia per i cross reference sia pe ril paziente sano
