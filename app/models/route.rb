class Route 
    include MongoMapper::EmbeddedDocument
        set_collection_name "routes"
 
 	:key :price, Integer
    #:key :start_city, Integer
    #:key :end_city, Integer	
    :many busmongs


 end