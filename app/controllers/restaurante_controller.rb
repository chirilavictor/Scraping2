require 'open-uri'

class RestauranteController < ApplicationController

  def home #dacă timpul de acum coincide cu timpul ultimului element adaugat in tabel înseamna ca cineva a apasat pe butonul: Extrage meniu acum. Am pus 3 cazuri pentru situatia cand se incarca greu.
  	if RestHora.last #e necesar pentru prima rulare. 
	   	if (Time.now.to_i == RestHora.last.updated_at.to_i) || (Time.now.to_i == RestHora.last.updated_at.to_i + 1) || (Time.now.to_i == RestHora.last.updated_at.to_i + 2) 
	    	@mesaj_actualizare = "Meniu actualizat"
	   	end	
   	end
  end

  def meniu_hora #doar alocam toate elementele din tabel intr-un array
		@meniu_hora = RestHora.all
  end

  def extrage_meniu #scriptul de extragere date din pagina si stocarea in tabel
  	RestHora.destroy_all #mai intai facem curatenie
 
  	@page = Nokogiri::HTML(open('http://www.restaurantul-hora.ro/meniu-restaurantul-hora/'))
		@tabele_meniu = @page.search('table')
		
		@tabele_meniu.each do |tabel|
			if tabel.search('tr').search('td').at_css('.menu-category') != nil 
				@categorie = tabel.search('tr').search('td').at_css('.menu-category').text

				RestHora.create(categorie:@categorie)
	
			end		
		end
		redirect_to root_url	
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
