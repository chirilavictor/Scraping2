Rails.application.routes.draw do

  root             'restaurante#home'
  get 'hora'    => 'restaurante#meniu_hora'
  get 'extrage' => 'restaurante#extrage_meniu'
  get 'extrage10ani' => 'restaurante#extrage_meniu_10ani'
  
end
