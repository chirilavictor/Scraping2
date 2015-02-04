require 'open-uri'
namespace :prim_rake do
	desc "Oarecare"
	task printam_ceva: :environment do
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
	end 
end