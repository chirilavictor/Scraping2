require 'open-uri'
namespace :hora do #inafara de partea asta de sus (care tine de sintaxa) restul l-am copiat din controller. E aceeasi metoda
	desc "Oarecare" # ruleaza in terminal bundle exec rake hora:actualizare_meniu
	task actualizare_meniu: :environment do
		RestHora.destroy_all

  	@page = Nokogiri::HTML(open('http://www.restaurantul-hora.ro/meniu-restaurantul-hora/'))
		@tabele_meniu = @page.search('table')
		
		@tabele_meniu.each do |tabel|
			if tabel.search('tr').search('td').at_css('.menu-category') != nil 
				@categorie = tabel.search('tr').search('td').at_css('.menu-category').text

				RestHora.create(categorie:@categorie)	
			end	
		end 	
	end 
end