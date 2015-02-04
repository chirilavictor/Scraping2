require 'open-uri'

class RestauranteController < ApplicationController

  def home  	
  end

  def meniu_hora
		@meniu3 = RestHora.all
  end

  def extrage_meniu
  	RestHora.all.each do |x|
  		x.destroy
  	end
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

  def extrage_meniu_10ani
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
