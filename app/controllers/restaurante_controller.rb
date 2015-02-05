require 'open-uri'

class RestauranteController < ApplicationController

  def home #dacă timpul de acum coincide cu timpul ultimului element adaugat in tabel înseamna ca cineva a apasat pe butonul: Extrage meniu acum. Am pus 3 cazuri pentru situatia cand se incarca greu.
  	if RestHora.last #e necesar pentru prima rulare. 
	   	if (Time.now.to_i == RestHora.last.updated_at.to_i) || (Time.now.to_i == RestHora.last.updated_at.to_i + 1) || (Time.now.to_i == RestHora.last.updated_at.to_i + 2) 
	    	@mesaj_actualizare_hora = "Meniu Hora actualizat"
	   	end	
   	end

  	if DavinciDesert.last #e necesar pentru prima rulare. 
	   	if (Time.now.to_i == DavinciDesert.last.updated_at.to_i) || (Time.now.to_i == DavinciDesert.last.updated_at.to_i + 1) || (Time.now.to_i == DavinciDesert.last.updated_at.to_i + 2) 
	    	@mesaj_actualizare_davinci = "Meniu Davinci actualizat"
	   	end	
   	end
  end

  def meniu_hora #doar alocam toate elementele din tabel intr-un array
  	@meniu_hora = RestHora.all 
  	@hora_paste = []
  	@hora_peste = []
  	@hora_salate = []
  	@hora_desert = []
  	@meniu_hora.each do |x|
  		@hora_paste << x if x.categorie == "Paste"
  		@hora_peste << x if x.categorie == "Preparate din peşte şi fructe de mare"
  		@hora_salate << x if x.categorie == "Salate"
  		@hora_desert << x if x.categorie == "Desert"
  	end
  end

  def extrage_meniu_hora #scriptul de extragere date din pagina si stocarea in tabel
  	RestHora.destroy_all #mai intai facem curatenie
 
  	@page = Nokogiri::HTML(open('http://www.restaurantul-hora.ro/meniu-restaurantul-hora/'))
		@tabele_meniu = @page.search('table')
		
		@tabele_meniu.each do |tabel|
			if tabel.search('tr').search('td').at_css('.menu-category') != nil 
				@categorie = tabel.search('tr').search('td').at_css('.menu-category').text
				# din fiecare tabel selectam doar partea cu "tr"(un rand) si acolo iteram iarasi pentru fiecare tr/rand în parte
				tabel_tr = tabel.search('tr')
				tabel_tr.each do |tr|
					if tr.search('td').at_css('.menu-title') != nil # la fel ca mai sus e nevoie de aceasta verificare
						# stocam fiecare camp in variabila corespunzatoare
						@fel_mancare = tr.search('td').at_css('.menu-title').text
						@cantitate = tr.search('td').at_css('.menu-qty').text
						@pret = tr.search('td').at_css('.menu-price').text
					
						RestHora.create(categorie:@categorie, fel_mancare:@fel_mancare, cantitate:@cantitate, pret:@pret)
					end
				end	
			end		
		end
		redirect_to root_url	
  end

  def meniu_davinci
  	@davinci_salate = DavinciSalate.all
  	@davinci_peste = DavinciPeste.all
  	@davinci_paste = DavinciPaste.all 
  	@davinci_carne = DavinciCarne.all 
  	@davinci_desert = DavinciDesert.all 
  end

  def extrage_meniu_davinci
  	DavinciSalate.destroy_all
  	DavinciPeste.destroy_all
  	DavinciPaste.destroy_all
  	DavinciCarne.destroy_all
  	DavinciDesert.destroy_all
  	@page = Nokogiri::HTML(open('http://www.davinciristorante.ro/meniu'))
  	@categorii = @page.at_css('.colLeft').search('.meniuItem') #continutul celor 5 categorii

  	@categoria_salate = @categorii[0].search('.details') #produsele corespunzatoare categoriei salate
  	@categoria_salate.each do |produs|
  		@fel_mancare = produs.search('h3').text
  		@pret = produs.search('span').text
  		@descriere_cantitate = produs.search('p')
  		@descriere = @descriere_cantitate[1].text
  		@cantitate = @descriere_cantitate[2].text
  		DavinciSalate.create(fel_mancare:@fel_mancare, pret:@pret, descriere:@descriere, cantitate:@cantitate)
  	end

  	@categoria_peste = @categorii[1].search('.details') 
  	@categoria_peste.each do |produs|
  		@fel_mancare = produs.search('h3').text
  		@pret = produs.search('span').text
  		@descriere_cantitate = produs.search('p') 
  		@descriere = @descriere_cantitate[1].text if @descriere_cantitate[1]
  		@cantitate = @descriere_cantitate[2].text if @descriere_cantitate[2]
  		DavinciPeste.create(fel_mancare:@fel_mancare, pret:@pret, descriere:@descriere, cantitate:@cantitate)
  	end

  	@categoria_paste = @categorii[2].search('.details') 
  	@categoria_paste.each do |produs|
  		@fel_mancare = produs.search('h3').text
  		@pret = produs.search('span').text
  		@descriere_cantitate = produs.search('p')
  		@descriere = @descriere_cantitate[1].text if @descriere_cantitate[1]
  		@cantitate = @descriere_cantitate[2].text if @descriere_cantitate[2]
  		DavinciPaste.create(fel_mancare:@fel_mancare, pret:@pret, descriere:@descriere, cantitate:@cantitate)
  	end

  	@categoria_carne = @categorii[3].search('.details') 
  	@categoria_carne.each do |produs|
  		@fel_mancare = produs.search('h3').text
  		@pret = produs.search('span').text
  		@descriere_cantitate = produs.search('p')
  		@descriere = @descriere_cantitate[1].text if @descriere_cantitate[1]
  		@cantitate = @descriere_cantitate[2].text if @descriere_cantitate[2]
  		DavinciCarne.create(fel_mancare:@fel_mancare, pret:@pret, descriere:@descriere, cantitate:@cantitate)
  	end

  	@categoria_desert = @categorii[4].search('.details') 
  	@categoria_desert.each do |produs|
  		@fel_mancare = produs.search('h3').text
  		@pret = produs.search('span').text
  		@descriere_cantitate = produs.search('p')
  		@descriere = @descriere_cantitate[1].text if @descriere_cantitate[1]
  		@cantitate = @descriere_cantitate[2].text if @descriere_cantitate[2]
  		DavinciDesert.create(fel_mancare:@fel_mancare, pret:@pret, descriere:@descriere, cantitate:@cantitate)
  	end
  	redirect_to root_url
  end

  def comparatii
  	# @meniu_hora = RestHora.all 
  	# @hora_paste = []
  	# @hora_peste = []
  	# @hora_salate = []
  	# @hora_desert = []
  	# @meniu_hora.each do |x|
  	# 	@hora_paste << x if x.categorie == "Paste"
  	# 	@hora_peste << x if x.categorie == "Preparate din peşte şi fructe de mare"
  	# 	@hora_salate << x if x.categorie == "Salate"
  	# 	@hora_desert << x if x.categorie == "Desert"
  	# end
  end

  def extrage_meniu_10ani #asta intra la categoria diverse. Nu gaseam o modalitate de a programa extragerea de date si mi-am scris eu singur un program care sa ruleze incontinu(pe asta l-am programat 10 ani sa mearga). Problema e ca daca il pornesti aplicatia va rula doar scriptul asta si nimic altceva. N-am avut ce face si l-am pornit pe Heroku si nu mai puteam sa-l opresc. Singura modalitate a fost sa comentez scriptul si sa-l urc fortat prin git (git push heroku)
  	# @var = 1423054400 
  	# while Time.now.to_i < 1738412867 #anul 2025 04 febuarie
  	# 	if @var == Time.now.to_i
  	# 		RestHora.all.each do |x|
		 #  		x.destroy
		 #  	end
		 #  	@page = Nokogiri::HTML(open('http://www.restaurantul-hora.ro/meniu-restaurantul-hora/'))

			# 	@tabele_meniu = @page.search('table')
				
			# 	@tabele_meniu.each do |tabel|
			# 		if tabel.search('tr').search('td').at_css('.menu-category') != nil 
			# 			@categorie = tabel.search('tr').search('td').at_css('.menu-category').text

			# 			RestHora.create(categorie:@categorie)
			
			# 		end		
			# 	end	
			# 	@var += 60		
		 #  end
		 # # redirect_to root_url
  	# end
	end
end
