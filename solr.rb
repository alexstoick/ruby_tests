require 'rubygems'
require 'rsolr'

# Direct connection
solr = RSolr.connect :url => 'http://localhost:8983/solr'


#solr.add :id => 42 , :content => "<div><div> Tribunalul de Arbitraj Sportiv a respins cererea formulata de Concordia Chiajna (aceea de a suspenda barajul de mentinere in prima divizie de fotbal a tarii), decizie in urma careia Rapid va ramane in Liga 1, informeaza Digisport. 'Este decizia normala, eram sigur in proportie de 99% ca asta va fi decizia. Sunt eu un optimist incurabil, dar mi s-a luat o mare piatra de pe inima. Era absurd daca alta era decizia. Acum mergem sa castigam la Vaslui' - Nicolae Cristescu la Digisport.<p>Rapid a castigat, scor 2-1, barajul de ramanere in Liga 1 cu Concordia Chiajna, partida disputandu-se pe 'Stadionul Dinamo'. </p> <p>In prima etapa a noului sezon din Liga 1, Rapidul se va deplasa la Vaslui (luni, 22 iulie, ora 21:30). </p> </div></div>" , :keywords => "rapid vaslui"
#solr.update :id=>33, :content => "33"
# send a request to /select
solr.commit
response = solr.get 'select', :params => {:q => '*:*'  }

puts response