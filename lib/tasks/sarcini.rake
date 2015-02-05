require 'open-uri'
namespace :date do #inafara de partea asta de sus (care tine de sintaxa) restul l-am copiat din controller. E aceeasi metoda
	desc "Oarecare" # ruleaza in terminal bundle exec rake date:actualizare_meniuri
	task actualizare_meniuri: :environment do

		RestHora.destroy_all
  	@page_hora = Nokogiri::HTML(open('http://www.restaurantul-hora.ro/meniu-restaurantul-hora/'))  	
		@tabele_meniu = @page_hora.search('table')		
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

  	DavinciSalate.destroy_all
  	DavinciPeste.destroy_all
  	DavinciPaste.destroy_all
  	DavinciCarne.destroy_all
  	DavinciDesert.destroy_all
  	@page_davinci = Nokogiri::HTML(open('http://www.davinciristorante.ro/meniu'))
  	@categorii = @page_davinci.at_css('.colLeft').search('.meniuItem') #continutul celor 5 categorii

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

	end 
end