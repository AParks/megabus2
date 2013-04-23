class TripMongo
   

   include MongoMapper::Document
    
    set_collection_name "trips"
    key :start_city, Integer
    key :end_city, Integer
    key :routes, Array

end