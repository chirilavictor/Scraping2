Rails.application.routes.draw do

  root                     'restaurante#home'

  get 'hora'    		    => 'restaurante#meniu_hora'
  get 'extrage_hora'    => 'restaurante#extrage_meniu_hora'

  get 'davinci'     	  => 'restaurante#meniu_davinci'
  get 'extrage_davinci' => 'restaurante#extrage_meniu_davinci'
  
  
end
